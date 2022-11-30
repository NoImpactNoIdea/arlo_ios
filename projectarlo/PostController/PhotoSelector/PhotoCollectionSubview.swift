//
//  PhotoCollectionSubview.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/29/22.
//


import Foundation
import UIKit
import Firebase
import Photos

final class PhotoCollectionSubview : UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PinterestLayoutDelegate, PHPhotoLibraryChangeObserver {
    
    private let photoCollectionPrivateId = "photoCollectionPrivateId"
    var imageAssets = [UIImage]()
    var originalAssets = [PHAsset]()
    var arrayOfSelectedPHAssets = [PHAsset]()
    var photos: PHFetchResult<PHAsset>!
    var photoPickerView : PhotoPickerController?
    var arrayOfSelectedIndex = [Int]()
    var currentLoadingIndexPath = [Int]()
    var fetchResult = PHFetchResult<PHAsset>()
    
    var breakLoop : Bool = false
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = coreWhiteColor
        self.alwaysBounceVertical = true
        self.dataSource = self
        self.delegate = self
        self.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: photoCollectionPrivateId)
        self.contentInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.isUserInteractionEnabled = true
        self.alpha = 0
        
        PHPhotoLibrary.shared().register(self)
        
        if let layout = self.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        self.getImages()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Helpers
extension PhotoCollectionSubview {
    func getImages() {
        
        self.imageAssets.removeAll()
        self.originalAssets.removeAll()
        self.arrayOfSelectedPHAssets.removeAll()
        self.arrayOfSelectedIndex.removeAll()
        self.currentLoadingIndexPath.removeAll()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let imageManager = PHImageManager.default()
            let fetchOptions = PHFetchOptions()
            fetchOptions.fetchLimit = 200
            fetchOptions.includeAssetSourceTypes = [.typeUserLibrary]
            fetchOptions.includeAllBurstAssets = false
            fetchOptions.includeHiddenAssets = false
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.predicate = NSPredicate(format: "mediaType == %d || mediaType == %d",
                                                 PHAssetMediaType.image.rawValue) ///PHAssetMediaType.video.rawValue
            
            let requestOptions = PHImageRequestOptions()
            
            requestOptions.version = .current
            requestOptions.resizeMode = .fast
            requestOptions.deliveryMode = .opportunistic
            requestOptions.isNetworkAccessAllowed = true ///cloud fetch and download
            requestOptions.isSynchronous = true
            
            self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
            
            if self.fetchResult.count > 0 {
                
                for i in 0..<self.fetchResult.count {
                    
                    print("🏃🏼‍♂️ FETCHING")
                    
                    if self.fetchResult.object(at: i).mediaType != .unknown && self.fetchResult.object(at: i).mediaType != .audio && self.fetchResult.object(at: i).mediaType != .unknown {
                        
                        imageManager.requestImage(for: self.fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width: self.fetchResult.object(at: i).pixelWidth / 12, height: self.fetchResult.object(at: i).pixelHeight / 12), contentMode: .aspectFill, options: requestOptions) { (image, error) in
                            
                            if let imageGrab = image {
                                self.imageAssets.append(imageGrab)
                                self.originalAssets.append(self.fetchResult.object(at: i))
                                
//                                DispatchQueue.main.async {
//                                    self.reloadData()
//                                    self.alpha = 1
//                                    self.photoPickerView?.activityIndicator.stopAnimating()
//
//                                }
                            }
                        }
                    }
            
                    if self.breakLoop == true {
                    break; ///terminate the loop process once the done button is selected
                    }
                }
                
                DispatchQueue.main.async {
                    self.reloadData()
                    UIView.animate(withDuration: 0.5) { self.alpha = 1 }
                    self.photoPickerView?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        var photos = self.fetchResult
        
        if let changes = changeInstance.changeDetails(for: photos) {
            
            photos = changes.fetchResultAfterChanges
            
            if changes.hasIncrementalChanges {
                
                DispatchQueue.main.async {
                    
                    self.performBatchUpdates({
                        
                        if let removed = changes.removedIndexes, removed.count > 0 {
                            self.deleteItems(at: removed.map { IndexPath(item: $0, section:0) })
                        }
                        
                        if let inserted = changes.insertedIndexes, inserted.count > 0 {
                            self.insertItems(at: inserted.map { IndexPath(item: $0, section:0) })
                        }
                        
                        changes.enumerateMoves { fromIndex, toIndex in
                            self.moveItem(at: IndexPath(item: fromIndex, section: 0), to: IndexPath(item: toIndex, section: 0))
                        }
                    })
                }
            } else {
                self.getImages()
            }
        }
    }
    
    private func returnDownloadedAsset(asset: PHAsset, retryAttempts: Int = 10) -> PHAsset? {
        
        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        
        options.version = .current
        options.isSynchronous = true
        options.isNetworkAccessAllowed = true
        
        options.progressHandler = { (progress, error, stop, info) in }
        
        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .default, options: options, resultHandler: { image, _ in
            img = image
        })
        
        if img == nil && retryAttempts > 0 {
            return returnDownloadedAsset(asset: asset, retryAttempts: retryAttempts - 1)
            
        } else {
            self.currentLoadingIndexPath.removeAll()
            return asset
        }
    }
}

//MARK: - CollectionView DataSource & Delegate
extension PhotoCollectionSubview {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: photoCollectionPrivateId, for: indexPath) as! PhotoCollectionCell
        ///increase the scoll smoothness
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        if self.imageAssets.count > 0 {
            
            cell.photoCollectionSubview = self
            cell.imageView.image = UIImage()
            
            let originalAsset = originalAssets[indexPath.row]
            let imageAssetsFinal = imageAssets[indexPath.row]
            
            cell.imageView.image = imageAssetsFinal
            
            if originalAsset.mediaType == .video {
                
                let timeStamp = originalAsset.duration
                let minuteDivider = timeStamp / 60
                let timeAsString = String(format : "%.2f", minuteDivider)
                let replaceInString = timeAsString.replacingOccurrences(of: ".", with: ":")
                cell.timeLabel.text = "\(replaceInString)"
                cell.timeShadow.isHidden = false
                
            } else {
                cell.timeLabel.text = ""
                cell.timeShadow.isHidden = true
            }
            
            if !self.arrayOfSelectedIndex.contains(indexPath.item) {
                cell.selectedView.isHidden = true
                
            } else if self.arrayOfSelectedIndex.contains(indexPath.item) {
                cell.selectedView.isHidden = false
            }
            
            if !self.currentLoadingIndexPath.contains(indexPath.item) {
//                cell.shouldPlayAnimation = false
                
            } else {
//                cell.shouldPlayAnimation = true
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width / 3
        return CGFloat(width)
    }
}


//MARK: - @objc
extension PhotoCollectionSubview {
    
    @objc func handleImageTap(sender : UITapGestureRecognizer) {
        
        let selectedButtonCell = sender.view as! UICollectionViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else { return }
        
        if self.imageAssets.count > 0 {
            
            //important for collection touches as accidental touched are super common
            
            let cell = self.dequeueReusableCell(withReuseIdentifier: photoCollectionPrivateId, for: indexPath) as! PhotoCollectionCell
            let originalAssets = self.originalAssets[indexPath.item]
            
            cell.contentView.isHidden = true
            
            if self.arrayOfSelectedIndex.count <= globalUploadCounter {
                
                self.currentLoadingIndexPath.removeAll()
                self.currentLoadingIndexPath.append(indexPath.item)
                
                DispatchQueue.main.async {
                    self.reloadData()
                }
                
                self.photoPickerView?.doneButton.alpha = 0.0
                self.photoPickerView?.doneButton.isUserInteractionEnabled = false
                self.photoPickerView?.loadingImageIndicator.startAnimating()
                
            } else {
                UIDevice.vibrateHeavy()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                //holding here
                let downloadedAsset = self.returnDownloadedAsset(asset: originalAssets)
                
                if !self.arrayOfSelectedIndex.contains(indexPath.item) && self.arrayOfSelectedIndex.count <= globalUploadCounter {
                    
                    self.arrayOfSelectedIndex.append(indexPath.item)
                    
                    if let safeAsset = downloadedAsset {
                        self.arrayOfSelectedPHAssets.append(safeAsset)
                        
                        self.photoPickerView?.doneButton.alpha = 1.0
                        self.photoPickerView?.doneButton.isUserInteractionEnabled = true
                        self.photoPickerView?.loadingImageIndicator.stopAnimating()
                        self.currentLoadingIndexPath.removeAll()
                        self.reloadData()
                        UIDevice.vibrateLight()

                    }
                    
                } else if self.arrayOfSelectedIndex.contains(indexPath.item) {
                    
                    if let index = self.arrayOfSelectedIndex.firstIndex(of: indexPath.item) {
                        
                        self.arrayOfSelectedIndex.remove(at: index)
                        self.arrayOfSelectedPHAssets.remove(at: index)
                        
                        self.photoPickerView?.doneButton.alpha = 1.0
                        self.photoPickerView?.doneButton.isUserInteractionEnabled = true
                        self.photoPickerView?.loadingImageIndicator.stopAnimating()
                        self.currentLoadingIndexPath.removeAll()
                        self.reloadData()

                    }
                    
                } else {
                    self.currentLoadingIndexPath.removeAll()
                    self.reloadData()
                }
                
                self.photoPickerView?.selectionLabel.text = "Chosen: \(self.arrayOfSelectedIndex.count)"
                
                if self.arrayOfSelectedPHAssets.count <= 0 {
                    self.photoPickerView?.doneButton.alpha = 0.5
                    self.photoPickerView?.doneButton.isUserInteractionEnabled = false
                    
                } else {
                    self.photoPickerView?.doneButton.alpha = 1.0
                    self.photoPickerView?.doneButton.isUserInteractionEnabled = true
                }
            }
        } else {
            self.photoPickerView?.doneButton.alpha = 0.5
            self.photoPickerView?.doneButton.isUserInteractionEnabled = false
        }
    }
}

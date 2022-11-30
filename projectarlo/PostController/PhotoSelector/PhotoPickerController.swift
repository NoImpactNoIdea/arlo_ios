//
//  PhotoPickerController.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/29/22.
//

import Foundation
import UIKit
import Photos
import Firebase
import Foundation

struct Media {
    var placeHolderImage: UIImage?
    var mediaHeight: Int?
    var mediaWidth: Int?
    var isVideo: Bool?
    var videoURL: String?
}

class PhotoPickerController: UIViewController {
    
    var postController : PostController?
    let databaseRef = Database.database().reference()
    var sequenceCounter: Int = 0
    var counter : Int = 0
    var sequenceArray = [UIImage]()

    lazy var photoCollectionSubview: PhotoCollectionSubview = {
        let layout = PinterestLayout()
        let pcv = PhotoCollectionSubview(frame: .zero, collectionViewLayout: layout)
        pcv.translatesAutoresizingMaskIntoConstraints = false
        pcv.photoPickerView = self
        return pcv
    }()
    
    var headerContainer: UIView = {
        let hcv = UIView()
        hcv.translatesAutoresizingMaskIntoConstraints = false
        hcv.backgroundColor = coreWhiteColor
        return hcv
    }()
    
    lazy var backButton : UIButton = {
        
        let dcl = UIButton(type: .system)
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFill
        dcl.setTitle("Dismiss", for: .normal)
        dcl.titleLabel?.font = UIFont(name: ralewaySemiBold, size: 14)
        dcl.tintColor = coreDeepColor
        dcl.titleLabel?.textAlignment = .center
        dcl.addTarget(self, action: #selector(self.handleBackButton), for: .touchUpInside)
        
        return dcl
    }()
    
    lazy var doneButton: UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.setTitle("Done", for: .normal)
        cbf.titleLabel?.font = UIFont(name: ralewaySemiBold, size: 14)
        cbf.titleLabel?.textColor = coreDeepColor
        cbf.titleLabel?.textAlignment = .right
        cbf.contentMode = .scaleAspectFit
        cbf.alpha = 0.5
        cbf.isUserInteractionEnabled = false
        cbf.tintColor = coreDeepColor
        cbf.addTarget(self, action: #selector(self.handleDataGrouping), for: UIControl.Event.touchUpInside)
        return cbf
    }()
    
    let selectionLabel: UILabel = {
        let etv = UILabel()
        etv.backgroundColor = .clear
        etv.font = UIFont(name: ralewaySemiBold, size: 16)
        etv.textColor = coreDeepColor
        etv.translatesAutoresizingMaskIntoConstraints = false
        etv.numberOfLines = 1
        etv.adjustsFontSizeToFitWidth = true
        etv.textAlignment = .center
        etv.lineBreakMode = .byTruncatingTail
        etv.text = "Chosen: 0"
        return etv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = coreDeepColor
        ai.hidesWhenStopped = true
        ai.startAnimating()
        return ai
    }()
    
    let loadingImageIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = coreDeepColor
        ai.hidesWhenStopped = true
        return ai
    }()
    
    //create a custom loading screen, only used once so in the file is fine
    let loader : UIView = {
        
        let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.backgroundColor = UIColor (white: 1.0, alpha: 0.9)
        lv.isUserInteractionEnabled = true
        lv.isHidden = true
        lv.alpha = 0.0
        return lv
    }()
    
    let blueCheckTransparentBacking : UIImageView = {
        
        let bci = UIImageView()
        bci.translatesAutoresizingMaskIntoConstraints = false
        bci.isUserInteractionEnabled = false//the default
        bci.contentMode = .scaleAspectFill
        bci.layer.masksToBounds = true
        let image = UIImage(named: "blue_backing_photos")?.withRenderingMode(.alwaysOriginal)
        bci.image = image
       return bci
    }()
    
    let blueCheckIcon : UIImageView = {
        
        let bci = UIImageView()
        bci.translatesAutoresizingMaskIntoConstraints = false
        bci.isUserInteractionEnabled = false//the default
        bci.contentMode = .scaleAspectFill
        bci.layer.masksToBounds = true
        let image = UIImage(named: "big_blue_check")?.withRenderingMode(.alwaysOriginal)
        bci.image = image
       return bci
    }()
    
    let loaderHeaderLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.font = UIFont(name: ralewayRegular, size: 16)
        hl.textAlignment = .center
        hl.text = "Photos uploading,\nplease do not close\nthe app until\ncomplete"
        hl.textColor = coreDeepColor
        hl.numberOfLines = -1

       return hl
    }()
    
    let loaderCounterLabel : UILabel = {
        
        let hl = UILabel()
        hl.translatesAutoresizingMaskIntoConstraints = false
        hl.backgroundColor = .clear
        hl.font = UIFont(name: ralewayRegular, size: 16)
        hl.textAlignment = .center
        hl.text = "1/"
        hl.textColor = coreBlackColor
        hl.numberOfLines = 1

       return hl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = coreWhiteColor
        self.addViews()
        self.isModalInPresentation = true
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.cancelLoadingScreen), name: NSNotification.Name(K.CLEAR_FOREGROUND_LOADER_FOR_PHOTOS), object: nil)

        ///prevents down swiping on card views along with the function call 'handlePopGesture'
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(self.handlePopGesture))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        NotificationCenter.default.post(name: NSNotification.Name(K.CLEAR_BACKGROUND_LOADER_FOR_PHOTOS), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
  
    //this runs the loading screen
    func shouldEnableLoader(shouldEnable : Bool) {
        
        if shouldEnable {
            self.loaderCounterLabel.text = ""
            self.loader.isHidden = false
            self.expandAndReduce()
            
            UIView.animate(withDuration: 0.25, delay: 0) {
                self.loader.alpha = 1.0
            }
            
        } else {
            ///the controller gets disposed of, so no need to clean up the garbage
        }
    }
    
    @objc func expandAndReduce() {
        
        UIView.animate(withDuration: 0.68, delay: 0, options: .curveEaseInOut) {
            self.blueCheckTransparentBacking.transform = CGAffineTransform(scaleX: 1.175, y: 1.175)
        } completion: { complete in
            UIView.animate(withDuration: 0.68, delay: 0, options: .curveEaseInOut) {
                self.blueCheckTransparentBacking.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { complete in
                self.expandAndReduce()
            }
        }
    }
    
    //updates the counter
    func countIncrementor(currentCount : Int, maxCount : Int) -> String {
        return "\(currentCount)/\(maxCount)"
    }
 }


//MARK: - Layout UI
extension PhotoPickerController {
    private func addViews() {
        
        self.view.addSubview(headerContainer)
        self.headerContainer.addSubview(self.backButton)
        self.headerContainer.addSubview(self.doneButton)
        self.headerContainer.addSubview(self.selectionLabel)
        
        self.view.addSubview(photoCollectionSubview)
        self.view.addSubview(activityIndicator)
        self.view.addSubview(loadingImageIndicator)
        
        self.view.addSubview(loader)
        self.loader.addSubview(self.blueCheckTransparentBacking)
        self.loader.addSubview(self.blueCheckIcon)
        self.loader.addSubview(self.loaderHeaderLabel)
        self.loader.addSubview(self.loaderCounterLabel)

        self.headerContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.headerContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.headerContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.headerContainer.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        self.backButton.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 5).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 5).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        
        self.doneButton.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 5).isActive = true
        self.doneButton.rightAnchor.constraint(equalTo: self.headerContainer.rightAnchor, constant: -5).isActive = true
        self.doneButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.doneButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true

        self.selectionLabel.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: 5).isActive = true
        self.selectionLabel.rightAnchor.constraint(equalTo: self.doneButton.leftAnchor, constant: -10).isActive = true
        self.selectionLabel.leftAnchor.constraint(equalTo: self.backButton.rightAnchor, constant: 10).isActive = true
        self.selectionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.photoCollectionSubview.topAnchor.constraint(equalTo: self.headerContainer.bottomAnchor, constant: 0).isActive = true
        self.photoCollectionSubview.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.photoCollectionSubview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.photoCollectionSubview.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        self.activityIndicator.topAnchor.constraint(equalTo: self.selectionLabel.bottomAnchor, constant: 80).isActive = true
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.sizeToFit()
        
        self.loadingImageIndicator.centerYAnchor.constraint(equalTo: self.doneButton.centerYAnchor, constant: 0).isActive = true
        self.loadingImageIndicator.centerXAnchor.constraint(equalTo: self.doneButton.centerXAnchor, constant: 0).isActive = true
        self.loadingImageIndicator.sizeToFit()
        
        ///normally these are a subclass, this is a one time and unique so this is cool - everything is a child of the loader
        self.loader.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.loader.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.loader.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.loader.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.blueCheckTransparentBacking.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = true
        self.blueCheckTransparentBacking.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.blueCheckTransparentBacking.heightAnchor.constraint(equalToConstant: 131).isActive = true
        self.blueCheckTransparentBacking.widthAnchor.constraint(equalToConstant: 131).isActive = true
        
        self.blueCheckTransparentBacking.layer.cornerRadius = 131/2
        
        self.blueCheckIcon.centerYAnchor.constraint(equalTo: self.blueCheckTransparentBacking.centerYAnchor).isActive = true
        self.blueCheckIcon.centerXAnchor.constraint(equalTo: self.blueCheckTransparentBacking.centerXAnchor).isActive = true
        self.blueCheckIcon.heightAnchor.constraint(equalToConstant: 103).isActive = true
        self.blueCheckIcon.widthAnchor.constraint(equalToConstant: 103).isActive = true
        
        self.blueCheckIcon.layer.cornerRadius = 103/2
        self.loaderHeaderLabel.topAnchor.constraint(equalTo: self.blueCheckTransparentBacking.bottomAnchor, constant: 20).isActive = true
        self.loaderHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 90).isActive = true
        self.loaderHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -90).isActive = true
        self.loaderHeaderLabel.sizeToFit()

        self.loaderCounterLabel.topAnchor.constraint(equalTo: self.loaderHeaderLabel.bottomAnchor, constant: 6).isActive = true
        self.loaderCounterLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.loaderCounterLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.loaderCounterLabel.sizeToFit()

    }
}

//MARK: - Helpers
extension PhotoPickerController {
 
    func grabVideoUrl(passedAsset : PHAsset, completion : @escaping (_ isFinshedLoading: URL) -> ()) {
        
        let requestOptions = PHVideoRequestOptions()
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.deliveryMode = .highQualityFormat
        
        PHCachingImageManager.default().requestAVAsset(forVideo: passedAsset, options: requestOptions) { (avasset, avaudioMix, nil) in
            
            guard let asset = avasset else { return }
            
            self.saveVideoInDocumentsDirectory(withAsset: asset) { (url, error) in
                
                if error != nil {
                    print("Error saving: " , error?.localizedDescription as Any)
                    return
                }
                
                if let url = url {
                    completion(url)
                }
            }
        }
    }
    
    func saveVideoInDocumentsDirectory(withAsset asset: AVAsset, completion: @escaping (_ url: URL?,_ error: Error?) -> Void) {
        
        let manager = FileManager.default
        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
        
        var outputURL = documentDirectory.appendingPathComponent("output")
        
        do {
            try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
            let name = NSUUID().uuidString
            outputURL = outputURL.appendingPathComponent("\(name).mp4")
        } catch let error {
            print(error.localizedDescription)
        }
        
        //Remove existing file
        _ = try? manager.removeItem(at: outputURL)
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality) else { return }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mp4
        
        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(outputURL, exportSession.error)
                
            case .failed:
                print("FAILED:  \(exportSession.error?.localizedDescription ?? "")")
                completion(nil, exportSession.error)
                
            case .cancelled:
                print("CANCELLED:  \(exportSession.error?.localizedDescription ?? "")")
                completion(nil, exportSession.error)
                
            default:
                break
            }
        }
    }
    
    func clearDocumentsDirectory() {
        let manager = FileManager.default
        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
        let outputURL = documentDirectory.appendingPathComponent("output")
        _ = try? manager.removeItem(at: outputURL)
    }
}


//MARK: - @objc
extension PhotoPickerController {
    
    @objc func handlePopGesture(gesture: UIGestureRecognizer) -> Void {
        if gesture.state == .began {
            self.handleBackButton()
            self.navigationController?.interactivePopGestureRecognizer?.removeTarget(self, action: #selector(self.handlePopGesture(gesture:)))
        }
    }
    
    @objc func handleBackButton() {
        
        UIDevice.vibrateLight()
    
        self.dismiss(animated: true) {
            self.photoCollectionSubview.breakLoop = true
//            self.chatControllerMain?.photoPicker = PhotoPickerController() ///the goal here is to shut down the forever loop for photos
        }
    }
    
    @objc func callLoadingScreen() {
        self.shouldEnableLoader(shouldEnable: false)
    }
    
    @objc func cancelLoadingScreen() {
        
        self.shouldEnableLoader(shouldEnable: false)
        self.handleBackButton()
    }
    
    @objc func handleDataGrouping() {
        self.threadLoader()
    }
    
    
    @objc func threadLoader() {

        self.handleDoneButton { (isComplete) in

            ///we have all the photos in this sequence array and need to add them to the amount selected
            if self.sequenceArray.count > 0 {

                for selectedImage in self.sequenceArray {
                    
//                    var enumPhotos = PhotoalbumEnum.mainImage

//                    if let imageView = self.chatControllerMain?.imageViewArray[self.counter] {///imageview
//
//                        print("NAME CHECK HERE: ", imageView.layer.name)
//
//
//                        switch imageView.layer.name {
//
//                        case "main_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.mainImage
//                        case "secondary_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.secondImage
//
//                        case "third_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.thirdImage
//
//                        case "fourth_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.fourthImage
//
//                        case "fifth_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.fifthImage
//
//                        case "sixth_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.sixthImage
//
//                        case "seventh_image_view" : print("main")
//
//                            enumPhotos = PhotoalbumEnum.seventhImage
//
//                        case "eigth_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.eigthImage
//
//                        case "ninth_image_view" : print("main")
//                            enumPhotos = PhotoalbumEnum.ninthImage
//
//                        default: print("default for photo enum")
//                            enumPhotos = PhotoalbumEnum.mainImage
//                        }
//
//                        ///get the photo enum then call callTheCameraView
//                        self.chatControllerMain?.callTheCameraView(originalImage: selectedImage, photoEnumerator: enumPhotos)
//
//                        self.counter += 1
//                    }
                }
                
//                self.chatControllerMain?.imageViewArray.removeAll()
                self.sequenceArray.removeAll()
                self.sequenceCounter = 0
                self.handleBackButton()
            } else {
                print(" no selections here, maybe bail")
            }
           
        }
    }
   
    @objc func handleDoneButton(completion : @escaping (_ isComplete: Bool) -> ()) {
        
        if self.photoCollectionSubview.arrayOfSelectedIndex.count <= 0 {
            print("failing in here")
            return
            
        }
        
        let selection = self.photoCollectionSubview.arrayOfSelectedPHAssets
        self.loaderCounterLabel.text = ""
        
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        requestOptions.isNetworkAccessAllowed = true
        requestOptions.resizeMode = .fast
        
        for i in selection {
            
            if i.mediaType == .image {
                
                imageManager.requestImage(for: i, targetSize: CGSize(width: i.pixelWidth, height: i.pixelHeight), contentMode: .default, options: requestOptions) { (image, error) in

                    if let imageGrab = image {

                        self.sequenceArray.append(imageGrab)
                        
                        print(selection.count, " : counts")
                        print(self.sequenceCounter, " : counts seq")

                        self.sequenceCounter += 1

                        if self.sequenceCounter == selection.count {
                            print("completing")

                            completion(true)
                        }
                        

                    }
                }
            } else {
                print("unknwon format")
            }
            
        }
    }
}

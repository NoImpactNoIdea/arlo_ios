//
//  Extensions.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit
import AVFoundation
import Firebase
import DeviceCheck
import PINRemoteImage
import SDWebImage
import ImageIO

//MARK: - Global Color Variables
var coreWhiteColor = UIColor(hex: 0xFFFFFF),
    coreBlackColor = UIColor(hex: 0x000000),
    coreGrayColor = UIColor(hex: 0x414141),
    coreBackgroundColor = UIColor(hex: 0xF6F4EF),///was white
    coreLightGrayColor = UIColor(hex: 0xF0F0F0),
    coreRedColor = UIColor(hex: 0xFF0000),
    coreGreenColor = UIColor(hex: 0x00F87C),
    coreOrangeColor = UIColor(hex: 0xE25E12),
    coreBackgroundWhite = UIColor(hex: 0xFAFAFA),
    mmMainColor = UIColor(hex: 0x2777F6),
    mmSecondaryColor = UIColor(hex: 0x509CF9),
    mmTertiaryColor = UIColor(hex: 0x509CF9),
    phoneCallBlue = UIColor(hex: 0x2C324A),
    predictionsBlue = UIColor(hex: 0xA5C8FF),
    greyDateColor = UIColor(hex: 0x414141),
    recordCharcoalGrey = UIColor(hex: 0x4A4A4A),
    loadingBlueProgress = UIColor(hex: 0x0062FF),
    predictionGrey = UIColor(hex: 0x707070),
    dividerGrey = UIColor(hex: 0xBCBCBC),
    imageBorderBlue = UIColor(hex: 0x1F5FC5),
    coreGoldColor = UIColor(hex: 0xFFDB51),
    fontSelectionGrey = UIColor(hex: 0xC2C2C2),
    subscriptionBlack = UIColor(hex: 0x080808),
    dummyFaceToneColor = UIColor(hex: 0xF3CAB0),
    navGrey = UIColor(hex: 0x9DA6AB),
    textFieldGrey = UIColor(hex: 0x777E82),
    placeHolderGrey = UIColor(hex: 0x4A4A4A),
    errorRed = UIColor(hex: 0xD0312D),
    selectionGrey = UIColor(hex: 0x666666),
    subscriptionGrey = UIColor(hex: 0xDEDEDE),
    makeupPink = UIColor(hex: 0xCA2442),
    pdfGrey = UIColor(hex: 0xE6E6E6),
    checkGrey = UIColor(hex: 0xD5D5D5),
    pdfDividerGrey = UIColor(hex: 0x979797),
    clientOnboardingBlack = UIColor(hex: 0x16181F),
    sideBySidePhotoGrey = UIColor(hex: 0x3C3C3C),
    clientGold = UIColor(hex: 0xC6AB6E),
    corePurpleColor = UIColor(hex: 0x201728),
    fontHeaderColor = UIColor(hex: 0x424653),
    fontSubHeaderColor = UIColor(hex: 0x887F8B),
    pastMatchesFeederGrey = UIColor(hex: 0xDDDCD9),
    toggleSwitchGreen = UIColor(hex: 0x00B89C),
    matcherGold = UIColor(hex: 0xDBBF7F),
    selectedDeepGrey = UIColor(hex: 0xCCC7D0),
    
    coreDeepColor = UIColor(hex: 0x371c4b),
    coreMediumColor = UIColor(hex: 0x5d3a6f),
    coreLightColor = UIColor(hex: 0xaa98b5),
    coreUltraLightColor = UIColor(hex: 0xcbc1d2),

    
    //FOR THE CHAT CONTROLLER, WHEN A USER SWIPES LEFT TO EXPOSE THE REPLY ARROW
    globalIsReplyExpanded : Bool = false,
    
    //MARK: - Global Fonts
    butlerRegular : String = "Butler",
    butlerMedium : String = "Butler-Medium",
    butlerBold : String = "Butler-Bold",
    robotoRegular : String = "Roboto-Regular",
    robotoBold : String = "Roboto-Bold",
    robotoItalic : String = "Roboto-Italic",
    gravityHandWritten : String = "GravityHandwritten",

    //DEMO ADJUSTMENT SETTINGS
    globalFrostTransparency : CGFloat = 1.0,
    globalSpacingForChatCells : CGFloat = 12,
    globalMediaViewControllerBackgroundColor : UIColor = coreWhiteColor,
    
    photoSelectionPath = PhotoSelectionPath.fromOnboarding,
    onboardingPath = OnboardingPath.fromLogin,
    chatEntryPath = ChatEntryPath.fromMessagesController,

    //MARK: - NEW FONTS FOR THE REBRAND V2
    merriRegular : String = "Merriweather-Regular",
    merriItalic : String = "Merriweather-Italic",
    merriLight : String = "Merriweather-Light",
    merriLightItalic : String = "Merriweather-LightItalic",
    merriBold: String = "Merriweather-Bold",
    merriBoldItalic : String = "Merriweather-BoldItalic",
    merriBlack : String = "Merriweather-Black",
    merriBlackItalic : String = "Merriweather-BlackItalic",

    ralewayRegular = "Raleway-Regular",
    ralewayItalic = "Raleway-Italic",
    ralewayThin = "Raleway-Thin",
    ralewayExtraLIght = "Raleway-ExtraLight",
    ralewayThinItalic = "Raleway-ThinItalic",
    ralewayExtraLightItalic = "Raleway-ExtraLightItalic",
    ralewayLight = "Raleway-Light",
    ralewayLightItalic = "Raleway-LightItalic",
    ralewayMedium = "Raleway-Medium",
    ralewayMediumItalic = "Raleway-MediumItalic",
    ralewaySemiBold = "Raleway-SemiBold",
    ralewaySemiBoldItalic = "Raleway-SemiBoldItalic",
    ralewayBold = "Raleway-Bold",
    ralewayBoldItalic = "Raleway-BoldItalic",
    ralewayExtraBold = "Raleway-ExtraBold",
    ralewayExtraBoldItalic = "Raleway-ExtraBoldItalic",
    ralewayBlack = "Raleway-Black",
    ralewayBlackItalic = "Raleway-BlackItalic"

class CustomTextFieldMaps: TextFieldWithImage {
    
    let padding = UIEdgeInsets(top: 0, left: 55, bottom: 0, right: 50);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


extension UITextField {
    //Toggle Password Image
    func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            button.tintColor = pdfGrey
        } else {
            button.setImage(UIImage(systemName: "eye"), for: .normal)
            button.tintColor = pdfGrey
        }
    }
    
    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    //Enable Left Padding
    func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    
    func setRightPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
   
    //Show/Hide Password
    @objc func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}

extension UITextField {
    func setupLeftImage(imageName: String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(systemName: imageName)
        
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 40))
        imageContainerView.addSubview(imageView)
        
        self.leftView = imageContainerView
        self.leftViewMode = .always
        self.tintColor = .lightGray
    }
}


class TextFieldWithImage: UITextField {
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let leftViewHeight: CGFloat = 24
        let y = bounds.size.height / 2 - leftViewHeight / 2
        return .init(x: 10, y: y, width: leftViewHeight + 20, height: leftViewHeight)
    }
}


extension CGAffineTransform {
    var angle: CGFloat { return atan2(-self.c, self.a) }
    
    var angleInDegrees: CGFloat { return self.angle * 180 / .pi }
    
    var scaleX: CGFloat {
        let angle = self.angle
        return self.a * cos(angle) - self.c * sin(angle)
    }
    
    var scaleY: CGFloat {
        let angle = self.angle
        return self.d * cos(angle) + self.b * sin(angle)
    }
}

extension UIColor {
    
    func add(overlay: UIColor) -> UIColor {
        var bgR: CGFloat = 0
        var bgG: CGFloat = 0
        var bgB: CGFloat = 0
        var bgA: CGFloat = 0
        
        var fgR: CGFloat = 0
        var fgG: CGFloat = 0
        var fgB: CGFloat = 0
        var fgA: CGFloat = 0
        
        self.getRed(&bgR, green: &bgG, blue: &bgB, alpha: &bgA)
        overlay.getRed(&fgR, green: &fgG, blue: &fgB, alpha: &fgA)
        
        let r = fgA * fgR + (1 - fgA) * bgR
        let g = fgA * fgG + (1 - fgA) * bgG
        let b = fgA * fgB + (1 - fgA) * bgB
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension UIView{
    func rotationForCABasicAnimation() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.25
        rotation.isCumulative = false
        rotation.repeatCount = 1
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

@available(iOS 10.0, *)
extension UIImage {
    func removingAlpha() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.opaque = true // removes Alpha Channel
        format.scale = scale // keeps original image scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}


// MARK: - UIView Extension
extension UIView {

    /**
       Rotate a view by specified degrees
       parameter angle: angle in degrees
     */

    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
}

extension UIView {

    //MARK: - TAKE A SCREENSHOT WITH THE DEVICES DIMENSIONS (OPTIONS TO FALSE)
    func takeAndReturnScreenshot(frame : CGRect) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}




class ContentCenteringScrollView: UIScrollView {

    override var bounds: CGRect {
        didSet { updateContentInset() }
    }

    override var contentSize: CGSize {
        didSet { updateContentInset() }
    }

    private func updateContentInset() {
        var top = CGFloat(0)
        var left = CGFloat(0)
        if contentSize.width < bounds.width {
            left = (bounds.width - contentSize.width) / 2
        }
        if contentSize.height < bounds.height {
            top = (bounds.height - contentSize.height) / 2
        }
        contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
    }
}

extension CGImagePropertyOrientation {
    /**
     Converts a `UIImageOrientation` to a corresponding
     `CGImagePropertyOrientation`. The cases for each
     orientation are represented by different raw values.

     - Tag: ConvertOrientation
     */
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}


class PaddingLabel: UILabel {

    var edgeInset: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}

///creates a .pdf from an image
func createPDFDataFromView(passedView : UIView, mutableString : NSMutableString, mutableLinkLocation : CGRect) -> NSMutableData {
    
    let pdfData = NSMutableData()
    let view = passedView
    let imageRect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
    UIGraphicsBeginPDFPage()
    let context = UIGraphicsGetCurrentContext()
    view.layer.render(in: context!)
    mutableString.draw(in: mutableLinkLocation)
    UIGraphicsEndPDFContext()

    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    let path = dir?.appendingPathComponent("match.pdf")

    do {
        try pdfData.write(to: path!, options: NSData.WritingOptions.atomic)
    } catch {
        print("error catched")
    }

    return pdfData
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension Data {
    
    /// Call this method to convert a push token from its `Data` type to a `String`.
    func pushTokenAsString() -> String {
        return self.map { String(format: "%02.2hhx", $0) }.joined()
    }
}

extension UIScrollView {
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        
        if self.contentSize.height == 0 || self.bounds.size.height == 0 {
            print("do nothing here bottom")
        } else {
            self.setContentOffset(bottomOffset, animated: true)
        }
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

//MARK: - URLS/KEYS/TONES
struct Statics {
    
    //MARK: - URLS AND LINKS FOR DUV MESSENGER
    static let  TERMS_OF_SERVICE : String = "https://www..com"
    static let  PRIVACY_POLICY : String = "https://www..com"
    
    static let  SUPPORT_EMAIL_ADDRESS : String = "support@.com"
    static let  FAQS : String = "https://www..com"
    static let  APP_STORE_URL : String = "https://"
    
    static let GOOGLE_SIGN_IN : String = "google"
    static let EMAIL_SIGN_IN : String = "email"
    
}

extension UICollectionView {
    
    var centerPoint : CGPoint {
        
        get {
            return CGPoint(x: self.center.x + self.contentOffset.x, y: self.center.y + self.contentOffset.y - 40.0)
        }
    }
    
    var centerCellIndexPath: IndexPath? {
        
        if let centerIndexPath = self.indexPathForItem(at: self.centerPoint) {
            return centerIndexPath
        }
        return nil
    }
}

func random(digits:Int) -> String {
    var number = String()
    for _ in 1...digits {
        number += "\(Int.random(in: 1...9))"
    }
    return number
}

extension UILabel {
    
    func colorString(text: String?, coloredText: String?, color: UIColor? = .red) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
        self.attributedText = attributedString
    }
}

extension UILabel {
    
    func colorFontString(text: String?, coloredText: String?, color: UIColor? = .red, fontName : String? = butlerBold, fontSize : Double? = 13) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!, NSAttributedString.Key.font: UIFont(name: fontName!, size: fontSize!)],
                                       range: range)
        
        self.attributedText = attributedString
    }
}


class ColorToHex {
    
    static func convert(color: UIColor) -> String {
        
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
    }
    
}

class GrabUsersHexColor {
    
    static func withUID(passedUID : String, completion : @escaping(_ returnedHexColorString : String) -> (Void))  {
        
        let path = Database.database().reference().child("all_users").child(passedUID)
        
        path.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
            
            if snap.exists() {
                
                let JSON = snap.value as? [String : Any] ?? ["nil" : "nil"]
                
                let hexColor = JSON["profile_hex_color"] as? String ?? "nil"
                
                completion(hexColor)
                
            } else {
                completion("nil")
            }
        }
    }
}

extension String {
    
    func grabUserInitialsFromName(passedString : String) -> String {
        
        if passedString.isEmpty {
            return "PI"
        }
        
        let nameSplice = passedString.split(separator: " ")
        
        if nameSplice.count > 0 {
            
            if nameSplice.count == 1 {
                
                let spliceOne = nameSplice[0]
                let prefixOne = spliceOne.prefix(1)
                return "\(prefixOne)"
                
            } else {
                
                let spliceOne = nameSplice[0]
                let spliceTwo = nameSplice[1]
                
                let prefixOne = spliceOne.prefix(1)
                let prefixTwo = spliceTwo.prefix(1)
                
                return "\(prefixOne)\(prefixTwo)"
                
            }
            
        } else {
            return "PI"
        }
    }
}

extension UILabel {
    var actualNumberOfLines: Int {
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.bounds.size)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var numberOfLines = 0, index = 0, lineRange = NSMakeRange(0, 1)
        
        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
}

//REMOVE DUPLICATES FROM AN ARRAY
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

//MARK: - STRING EXTENSION FOR STRING HEIGHTS AND WIDTHS
extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}


//MARK: - GRAB SPECIFIC WORDS FROM A STRING
extension StringProtocol {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}

//MARK: - Firebase helpers
class AuthCheckUsers : NSObject {
    
    static func authCheck(completion : @escaping (_ hasAuth : Bool)->()) {
        
        if let user_uid = Auth.auth().currentUser?.uid {
            
            let ref = Database.database().reference().child("all_users").child(user_uid).child("users_firebase_uid")
            
            ref.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
                
                if snap.exists() {
                    print("SNappy", snap.value as? String ?? "none-here")
                    completion(true)
                } else {
                    completion(false)
                }
                
            } withCancel: { (error) in
                completion(false)
            }
        } else {
            completion(false)
        }
    }
}

extension  CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}

extension UIView {
    func translate(_ translation: CGPoint) {
        let destination = center + translation
        let minX = frame.width/2
        let minY = frame.height/2
        let maxX = superview!.frame.width-minX
        let maxY = superview!.frame.height-minY
        center = CGPoint(
            x: min(maxX, max(minX, destination.x)),
            y: min(maxY - 80 ,max(minY + 30, destination.y)))
    }
}

class GrabDeviceID : NSObject {
    
    static func getID(completion : @escaping (_ isSuccess : Bool, _ deviceID : String)->()) {
        
        DCDevice.current.generateToken { (data, error) in
            
            if error != nil {
                completion(false, "device_id")
                return
            }
            
            guard let data = data else {
                completion(false, "device_id")
                return
            }
            
            let token = data.base64EncodedString()
            completion(true, token)
            return
        }
    }
}

//MARK: - Firebase helpers
class ProfileImageFetch : NSObject {
    
    static func image(completion : @escaping (_ icComplete : Bool, _ imageUrl : String)->()) {
        
        if let user_uid = Auth.auth().currentUser?.uid {
            
            let ref = Database.database().reference().child("all_users").child(user_uid).child("profile_image")
            
            ref.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
                
                ref.keepSynced(true)
                
                if snap.exists() {
                    
                    let image_url = snap.value as? String ?? "nil"
                    
                    completion(true, image_url)
                } else {
                    completion(false, "nil")
                    return
                }
                
            } withCancel: { (error) in
                
                completion(false, "nil")
                
            }
            
        } else {
            
            completion(false, "nil")
            
        }
    }
}

class ConvertSecondsToHMS : NSObject {
    
    static func secondsToHoursMinutesSeconds(seconds : Int) -> String {
        
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        var secondsString : String = ""
        var minutesString : String = ""
        var hoursString : String = ""
        
        //SECONDS
        if seconds < 10 {
            secondsString = "0\(seconds)"
        } else {
            secondsString = "\(seconds)"
        }
        
        //MINUTES
        if hours < 10 {
            hoursString = "0\(hours)"
        } else {
            hoursString = "\(hours)"
        }
        
        //HOURS
        if minutes < 10 {
            minutesString = "0\(minutes)"
        } else {
            minutesString = "\(minutes)"
        }
        
        if hours < 1 {
            let timeString = "\(minutesString):\(secondsString)"
            return timeString
        } else {
            let timeString = "\(hoursString):\(minutesString):\(secondsString)"
            return timeString
        }
    }
}

//MARK: - Firebase helpers
class ProfileImageFetchWithUID : NSObject {
    
    static func image(passedUID : String, completion : @escaping (_ icComplete : Bool, _ imageUrl : String, _ profileHexColor : String, _ usersName : String)->()) {
        
        if Auth.auth().currentUser?.uid != nil {
            
            let ref = Database.database().reference().child("all_users").child(passedUID)
            
            ref.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
                
                if snap.exists() {
                    
                    ref.keepSynced(true)
                    
                    let JSON = snap.value as? [String : Any] ?? ["":""]
                    
                    let profileImage = JSON["profile_image"] as? String ?? "nil"
                    let profileHexColor = JSON["profile_hex_color"] as? String ?? "nil"
                    let usersName = JSON["users_name"] as? String ?? "nil"
                    
                    completion(true, profileImage, profileHexColor, usersName)
                    
                } else {
                    completion(false, "false", "false", "false")
                    return
                }
                
            } withCancel: { (error) in
                
                completion(false, "false", "false", "false")
                
            }
            
        } else {
            
            completion(false, "false", "false", "false")
            
        }
    }
}

class GrabUsersFullNameWithUUID : NSObject {
    
    static func name(passedUid : String, completion : @escaping(_ isComplete : Bool, _ name : String)->()) {
        
        let database = Database.database().reference()
        
        if Auth.auth().currentUser?.uid != nil {
            
            let ref = database.child("all_users").child(passedUid).child("users_name")
            
            ref.observeSingleEvent(of: .value) { (snap : DataSnapshot) in
                
                ref.keepSynced(true)
                
                if snap.exists() {
                    
                    let name = snap.value as? String ?? ""
                    completion(true, name)
                }
                
            }
        } else {
            completion(false, "")
        }
    }
}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment
        
        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font as Any, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

class GrabUsersFullName : NSObject {
    
    static func name() -> String? {
        
        if Auth.auth().currentUser?.uid != nil {
            
            let usersName = Auth.auth().currentUser?.displayName
            
            return usersName
            
        } else {
            return "nil"
        }
    }
}

extension UILabel {
    
    func wordColoring (fullText : String , changeText : [String], changeTextTwo : [String], colorOne : UIColor, colorTwo : UIColor, fontOne : String, fontTwo : String, sizeOne : CGFloat, sizeTwo : CGFloat) {
        
        print("Change text is: \(changeText)")
        
        let strNumber: NSString = fullText as NSString
        
        var range = NSRange()
        
        var attribute = NSMutableAttributedString()
        
        attribute = NSMutableAttributedString.init(string: fullText)
        
        for i in changeText {
            
            range = (strNumber).range(of: i)
            
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: colorOne , range: range)
            
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontOne, size: sizeOne)!, range: range)
            
        }
        
        for orange in changeTextTwo {
            
            range = (strNumber).range(of: orange)
            
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: colorTwo , range: range)
            
            attribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontTwo, size: sizeTwo)!, range: range)
            
        }
        
        self.attributedText = attribute
        
    }
}

extension UIImageView {
    
    func loadImageGeneralUse(_ urlString: String, completion : @escaping (_ isComplete : Bool)->()) {
        
        self.image = UIImage()
        
        guard let url = URL(string: urlString) else {return}
        
        self.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground]) { (image, error, imageCacheType, imageUrl) in
            
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func loadImageGeneralUseWithFade(_ urlString: String, completion : @escaping (_ isComplete : Bool)->()) {
        
        self.image = UIImage()
        self.alpha = 0
        
        guard let url = URL(string: urlString) else {return}
        
        self.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground]) { (image, error, imageCacheType, imageUrl) in
            
            if error != nil {
                
                completion(false)
                
            } else {
                
                UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn) {
                    self.alpha = 1
                } completion: { complete in
                    print("done")
                }

                completion(true)
                
            }
        }
    }
}

// CALCULATES SIZE FOR CELL IN COLLECTIONVIEWS - USED IN THE COMMENTS CONTROLLER
public func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// CALCULATES SIZE FOR CELL IN COLLECTIONVIEWS - USED IN THE COMMENTS CONTROLLER
public func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

enum PhotoSelectionPath {
    
    case fromOnboarding
    case fromSettings
}


enum OnboardingPath {
    
    case fromLogin
    case fromRegistration
}


enum ChatEntryPath {
    
    case fromMessagesController
    case fromAddFriendsController
}

//Example usage(The 0x is a defined prefix, the hex value comes after): var customColorYellow = UIColor(hex: 0xFECF41)
extension UIColor {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        return getRed(&r, green: &g, blue: &b, alpha: &a) ? (r,g,b,a) : nil
    }
}

extension UIDevice {
    static func vibrateLight() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

extension UIDevice {
    static func vibrateMedium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

extension UIDevice {
    static func vibrateHeavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
}

class EnvironemntModeHelper : NSObject {
    
    static func isCurrentEnvironmentDebug() -> Bool {
        
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}

class FontLister : NSObject {
    
    static func enumerateFonts()
    {
        for fontFamily in UIFont.familyNames
        {
            print("Font family name = \(fontFamily as String)")
            for fontName in UIFont.fontNames(forFamilyName: fontFamily as String)
            
            {
                print("- Font name = \(fontName)")
            }
        }
    }
}

//Sets tappable hyper-links in (NSMutableAttributedString)'s Strings - *SPECIFICALLY FOR UITEXTVIEWS ONLY*
extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
            
            print("found the link NSMutableAttributedString helper")
            return true
        }
        print("can not find the link NSMutableAttributedString helper")
        return false
    }
}

//REMOVES THE FIRST CHARACTER OF A STRING BY CHOMPING :)
extension String {
    var chomp : String {
        mutating get {
            self.remove(at: self.startIndex)
            return self
        }
    }
}

//HEX Color value
extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
        
    }
}

//Money currency conversion
extension Double {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .currency
        return formater.string(from: NSNumber(value: self))!
    }
}


//Money currency conversion
extension Double {
    func formatnumberForGraph() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .currencyAccounting
        return formater.string(from: NSNumber(value: self))!
    }
}

extension Float {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .currency
        return formater.string(from: NSNumber(value: self))!
    }
}

//Radian Conversions - 3D
extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

//Reverse conversions - 3d
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

//removes all white spaces before, after and in between from a string
extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

//FILTTERS STRINGS FOR NUMERIC VALUES ONLY
extension String {
    var numbers: String {
        return String(filter { "0"..."9" ~= $0 })
    }
}

//OPENS URLS AS STRINGS
extension UIView {
    
    func openUrl(passedUrlString : String) {
        
        guard let developerWebsiteUrl = URL(string: passedUrlString) else {return}
        
        if UIApplication.shared.canOpenURL(developerWebsiteUrl) {
            
            return UIApplication.shared.open(developerWebsiteUrl, options: [:], completionHandler: nil)
            
        }
        
    }
    
}

class AlertControllerCompletion : NSObject {
    
    static func handleAlertWithCompletion(title : String, message : String, completion : @escaping (_ isFinished : Bool)->()) {
        
        var alertController = UIAlertController()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // iPad
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        } else {
            // not iPad (iPhone, mac, tv, carPlay, unspecified)
            alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        }
        
        let actionOne = UIAlertAction(title: "Ok", style: .default) { (action) in
            completion(true)
        }
        
        alertController.addAction(actionOne)
        
        if let topViewController = UIApplication.getTopMostViewController() {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
}

//MARK: - TOP VIEW CONTROLLER METHOD
extension UIApplication {
    
    class func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return nil
        }
    }
}

//24 HOUR TIME TO CHECK FOR DARK MODE - DARKEN BETWEEN THE HOURS OF 6PM THROUGH 6AM
extension UIView {
    
    func isNightTimeModeEnabled() -> Bool {
        
        let date = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: date)
        
        switch currentHour {
        
        case 6..<18 : return false
            
        default : return true
            
        }
    }
}


//ADDS THE SUFFIX FOR THE DAY OF THE MONTH EX: PASS 1 AND RETURNS 1ST AS A STRING OR 3 AND RETURNS 3RD AS A STRING
extension Int {
    
    func dayOfWeekSuffix(passedDayAsInt : Int) -> String {
        
        switch passedDayAsInt {
        
        case 1 :
            return "\(passedDayAsInt)st"
        case 2 :
            return "\(passedDayAsInt)nd"
        case 3 :
            return "\(passedDayAsInt)rd"
        case 4 :
            return "\(passedDayAsInt)th"
        case 5 :
            return "\(passedDayAsInt)th"
        case 6 :
            return "\(passedDayAsInt)th"
        case 7 :
            return "\(passedDayAsInt)th"
        case 8 :
            return "\(passedDayAsInt)th"
        case 9 :
            return "\(passedDayAsInt)th"
        case 10 :
            return "\(passedDayAsInt)th"
        case 11 :
            return "\(passedDayAsInt)th"
        case 12 :
            return "\(passedDayAsInt)th"
        case 13 :
            return "\(passedDayAsInt)th"
        case 14 :
            return "\(passedDayAsInt)th"
        case 15 :
            return "\(passedDayAsInt)th"
        case 16 :
            return "\(passedDayAsInt)th"
        case 17 :
            return "\(passedDayAsInt)th"
        case 18 :
            return "\(passedDayAsInt)th"
        case 19 :
            return "\(passedDayAsInt)th"
        case 20 :
            return "\(passedDayAsInt)th"
        case 21 :
            return "\(passedDayAsInt)st"
        case 22 :
            return "\(passedDayAsInt)nd"
        case 23 :
            return "\(passedDayAsInt)rd"
        case 24 :
            return "\(passedDayAsInt)th"
        case 25 :
            return "\(passedDayAsInt)th"
        case 26 :
            return "\(passedDayAsInt)th"
        case 27 :
            return "\(passedDayAsInt)th"
        case 28 :
            return "\(passedDayAsInt)th"
        case 29 :
            return "\(passedDayAsInt)th"
        case 30 :
            return "\(passedDayAsInt)th"
        case 31 :
            return "\(passedDayAsInt)st"
            
        default :
            
            return "\(passedDayAsInt)th"
        }
        
    }
    
}

//EXTENSION FOR MAKING A GRADIENT - JUST ADD COLOR ONE AND COLOR TWO AND APPLY IT TO THE UIVIEW
extension UIView {
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor) {
        
        clipsToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        print(gradientLayer.frame)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
}

extension Int {
    
    func square() -> Int {
        
        return self * self
    }
}

extension String {
    
    var twoFractionDigits: String {
        
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 2
        styler.maximumFractionDigits = 2
        styler.numberStyle = .currency
        let converter = NumberFormatter()
        converter.decimalSeparator = "."
        
        if let result = converter.number(from: self) {
            return styler.string(for: result) ?? ""
        }
        
        return ""
    }
}

class PulseLayerAnimation {
    
    //PULSES ANY CALAYER
    static func pulseProperties(pulseLayer : CAShapeLayer, toValue : CGFloat, duration : Double, repeatCount : Float) {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = toValue
        animation.autoreverses = true
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.isRemovedOnCompletion = false
        
        pulseLayer.add(animation, forKey: "arbitrary")
        
    }
    
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension Date {
    
    func timePassed(numericDates: Bool) -> String {
        
        let currentDate = Date()
        let nameFormatter = DateFormatter()
        
        nameFormatter.dateFormat = "EEEE"
        
        let secondsBetween: TimeInterval = currentDate.timeIntervalSince(self as Date)
        let numberOfDays = Int(secondsBetween / 86400)
        
        let currentWeekDayName = nameFormatter.string(from: currentDate)
        let passedWeekDayName = nameFormatter.string(from: self)
        
        //CHECK FOR TODAY - GIVE EXACT TIME
        if currentWeekDayName == passedWeekDayName {
            
            nameFormatter.amSymbol = "am"
            nameFormatter.pmSymbol = "pm"
            nameFormatter.dateFormat = "hh:mm a"
            let name = nameFormatter.string(from: self)
            return name
            
            //CHECK FOR THE LAST WEEK - GIVE WEEK DAY NAME
        } else if numberOfDays <= 7 {
            
            return passedWeekDayName
            
            //IF BEYOND A WEEK, GIVE THE FULL DATE
        } else {
            nameFormatter.dateFormat = "MMM dd, yyyy"
            let name = nameFormatter.string(from: self)
            return name
        }
    }
}

extension Date {
    
    func getTimeAsDouble() -> String {
        
        let calendar = Calendar.current,
            components = calendar.dateComponents([.day, .month, .year], from: self),
            year = components.year ?? 0,
            month = components.month ?? 0,
            day = components.day ?? 0
        
        var stringDay = String(day)
        var stringmonth = String(month)
        
        if stringDay.count == 1 {
            stringDay = "0\(stringDay)"
        }
        
        if stringmonth.count == 1 {
            stringmonth = "0\(stringmonth)"
        }
        
        let stringerDate = "\(year)\(stringmonth)\(stringDay)"
        
        return stringerDate
    }
}

extension Date {
    
    func collectionDate() -> String {
        
        let currentDate = Date()
        let nameFormatter = DateFormatter()
        
        nameFormatter.dateFormat = "EEEE"
        
        let secondsBetween: TimeInterval = currentDate.timeIntervalSince(self as Date)
        let numberOfDays = Int(secondsBetween / 86400)
        
        let passedWeekDayName = nameFormatter.string(from: self)
        let currentWeekDayName = nameFormatter.string(from: currentDate)
        
        
        if currentWeekDayName == passedWeekDayName && numberOfDays == 0 {
            
            return "Today"
            
        } else if numberOfDays <= 7 {
            
            return passedWeekDayName
            
            //IF BEYOND A WEEK, GIVE THE FULL DATE
        } else {
            
            nameFormatter.dateFormat = "MMM dd, yyyy"
            let name = nameFormatter.string(from: self)
            return name
        }
    }
}

extension Date {
    
    func getTimeFromDate() -> String {
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.amSymbol = "am"
        timeFormatter.pmSymbol = "pm"
        timeFormatter.dateFormat = "hh:mm a"
        let time = timeFormatter.string(from: self)
        return time
        
    }
}

extension Date {
    
    func timePassedFullFormat(numericDates: Bool) -> String {
        
        let currentDate = Date()
        let nameFormatter = DateFormatter()
        
        nameFormatter.dateFormat = "EEEE"
        
        let secondsBetween: TimeInterval = currentDate.timeIntervalSince(self as Date)
        let numberOfDays = Int(secondsBetween / 86400)
        
        let currentWeekDayName = nameFormatter.string(from: currentDate)
        let passedWeekDayName = nameFormatter.string(from: self)
        
        //CHECK FOR TODAY - GIVE EXACT TIME
        if currentWeekDayName == passedWeekDayName {
            
            nameFormatter.amSymbol = "am"
            nameFormatter.pmSymbol = "pm"
            nameFormatter.dateFormat = "hh:mm a"
            let name = nameFormatter.string(from: self)
            return name
            
            //CHECK FOR THE LAST WEEK - GIVE WEEK DAY NAME
        } else if numberOfDays <= 7 {
            
            return passedWeekDayName
            
            //IF BEYOND A WEEK, GIVE THE FULL DATE
        } else {
            nameFormatter.dateFormat = "MMM dd, yyyy"
            let name = nameFormatter.string(from: self)
            return name
        }
    }
}

class PhoneNumberFormatter : NSObject {
    
    static func formattedNumber(number: String, count : Int) -> String {
        
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        var mask : String = ""
        //TAKES INTO ACCOUNT THE AREA CODE FOR FORMATTING 10 - NO AREA CODE AND 11 - IS AN AREA CODE
        if count == 10 {
            mask = "XXX-XXX-XXXX"
        } else if count == 11 {
            mask = "X-XXX-XXX-XXXX"
        } else {
            mask = "XXX-XXX-XXXX"
        }
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

extension UIView {
    
    //MARK: USAGE
    //ie. let image = self.backgroundImageView.snapshotOfArea(of: self.foreheadExtraction.frame, afterScreenUpdates: true)
            ///backgroundImageView is the root where foreheadExtraction is a child - this will use the foreheadExtraction.frame as the screenshot location

    /// Create image snapshot of view.
    /// - Parameters:
    ///   - rect: The coordinates (in the view's own coordinate space) to be captured. If omitted, the entire `bounds` will be captured.
    ///   - afterScreenUpdates: A Boolean value that indicates whether the snapshot should be rendered after recent changes have been incorporated. Specify the value false if you want to render a snapshot in the view hierarchy’s current state, which might not include recent changes. Defaults to `true`.
    ///
    /// - Returns: The `UIImage` snapshot.

    func snapshotOfArea(of rect: CGRect? = nil, afterScreenUpdates: Bool = true) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
        }
    }
}

extension UIView {
    
    /// Snaps the interior frame of a UIView, not just the UIView itself
    func snapshotFor(of rect: CGRect? = nil) -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(bounds: rect!)
                return renderer.image { (context) in
                    self.layer.render(in: context.cgContext)
        }
    }
}

extension UIImageView {
    
    func runImageTransformer(_ urlString: String, adjustedSize : CGSize, completion : @escaping (_ isComplete : Bool, _ image : UIImage?)->()) {
        
        guard let url = URL(string: urlString) else {return}

        let imageSize = adjustedSize
        let transformer = SDImageResizingTransformer(size: imageSize, scaleMode: .aspectFill)
        self.image = UIImage()
        self.alpha = 0.0

        self.sd_setImage(with: url, placeholderImage: UIImage(),
                                   options: .continueInBackground,
                                   context: [.imageTransformer: transformer],
                                   progress: nil) { (image, error, cache, url) in
                                        
                if error != nil {
                    completion(false, nil)
                } else {
                    UIView.animate(withDuration: 0.15) {
                        self.alpha = 1.0
                        self.layoutIfNeeded()

                    }
                    completion(true, image)

                }
            }
        }
    }

extension UIImage{

func resizeImageWith(newSize: CGSize) -> UIImage {

    let horizontalRatio = newSize.width / size.width
    let verticalRatio = newSize.height / size.height

    let ratio = max(horizontalRatio, verticalRatio)
    let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
    draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
   }
}

extension UIImageView {
    
    func runImageTransformerNoResize(_ urlString: String, completion : @escaping (_ isComplete : Bool, _ image : UIImage?)->()) {
        
        guard let url = URL(string: urlString) else {return}
        
            self.image = UIImage()
        
            self.sd_setImage(with: url, placeholderImage: UIImage(),
                                   options: .highPriority,
                                   progress: nil) { (image, error, cache, url) in
                                        
                if error != nil {
                    completion(false, nil)
                } else {
                    completion(true, image)
                }
            }
        }
    }

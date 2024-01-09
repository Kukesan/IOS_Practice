//
//  ExportViewController.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-20.
//

import UIKit
import MessageUI
import TwitterKit
import FBSDKShareKit
import FirebaseStorage

enum SharingType {
    case challenge
    case community
}

class ExportViewController: UIViewController,MFMailComposeViewControllerDelegate,UIDocumentInteractionControllerDelegate {
    
    var exportViewImage : UIImage!
    var exportType : ExportTypes!
    
    let kCellIdentifier_CollectionViewCell = "kCellIdentifier_CollectionViewCell"
    
    
    private lazy var exportOptions : [[ExportTypes]] = [[.saveToDevice,.exportToPSD,.exportToPNG],
                                                        [.googleClassRoom],
                                                        [.messanger,.facebook,.email,.twitter],
                                                        [.print,.continues]]
    init(exportImage : UIImage!){
        super.init(nibName: nil, bundle: nil)
        self.exportViewImage = exportImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "#F5F5F5")
        configure()
    }
    
    private lazy var exportOptionsCollectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout();
        
        let testCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        testCollectionView.register(ExportOptionsCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        testCollectionView.translatesAutoresizingMaskIntoConstraints = false
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.backgroundColor = UIColor(hexString: "#F5F5F5")
        return testCollectionView
    }()
    
    private lazy var exportVw : UIView = {
        let evw = UIView()
        evw.translatesAutoresizingMaskIntoConstraints = false
        evw.backgroundColor = UIColor(hexString: "#E1E1E1")
        return evw
    }()
    
    private lazy var exportImageVw : UIImageView = {
       let eivw = UIImageView()
        eivw.translatesAutoresizingMaskIntoConstraints = false
        eivw.backgroundColor = .white
        eivw.image = exportViewImage
        return eivw
    }()
    
    lazy var closeBtn : UIButton = {
       let cbtn = UIButton()
        cbtn.translatesAutoresizingMaskIntoConstraints = false
        cbtn.setImage(UIImage(named: "close")?.withTintColor(UIColor(hexString: "#B8B9BA"), renderingMode: .alwaysOriginal), for: .normal)
        cbtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        return cbtn
    }()
    
    func configure(){
        self.view.addSubview(exportOptionsCollectionView)
        self.view.addSubview(exportVw)
        self.view.addSubview(closeBtn)
        exportVw.addSubview(exportImageVw)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            exportOptionsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            exportOptionsCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            exportOptionsCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            exportOptionsCollectionView.widthAnchor.constraint(equalToConstant: 180).isActive = true
            
            exportVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            exportVw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 90).isActive = true
            exportVw.heightAnchor.constraint(equalToConstant: 380).isActive = true
            exportVw.widthAnchor.constraint(equalToConstant: 600).isActive = true
            
            exportImageVw.centerYAnchor.constraint(equalTo: exportVw.centerYAnchor).isActive = true
            exportImageVw.centerXAnchor.constraint(equalTo: exportVw.centerXAnchor).isActive = true
            exportImageVw.heightAnchor.constraint(equalToConstant: 300).isActive = true
            exportImageVw.widthAnchor.constraint(equalToConstant: 580).isActive = true
            
            closeBtn.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 16).isActive = true
            closeBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16).isActive = true
            closeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            closeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
            break
        case .pad:
            exportOptionsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16).isActive = true
            exportOptionsCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            exportOptionsCollectionView.heightAnchor.constraint(equalToConstant: 600).isActive = true
            exportOptionsCollectionView.widthAnchor.constraint(equalToConstant: 184).isActive = true
            
            exportVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            exportVw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 90).isActive = true
            exportVw.heightAnchor.constraint(equalToConstant: 800).isActive = true
            exportVw.widthAnchor.constraint(equalToConstant: 850).isActive = true
            
            exportImageVw.centerYAnchor.constraint(equalTo: exportVw.centerYAnchor).isActive = true
            exportImageVw.centerXAnchor.constraint(equalTo: exportVw.centerXAnchor).isActive = true
            exportImageVw.heightAnchor.constraint(equalToConstant: 600).isActive = true
            exportImageVw.widthAnchor.constraint(equalToConstant: 800).isActive = true
            
            closeBtn.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 24).isActive = true
            closeBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16).isActive = true
            closeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            closeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
            break
        @unknown default:
            print("Unknown")
        }
    }
    
    @objc func close(){
        self.dismiss(animated: false, completion: nil)
    }
    
    func exportOptionsAction(exportOptionsEnum : ExportTypes){
        switch(exportOptionsEnum){
        case .saveToDevice:
            if(exportImageVw != nil){
                UIImageWriteToSavedPhotosAlbum(exportViewImage, nil, nil, nil)
                let aleart = UIAlertController.init(title: nil ,message: "Your Image Saved in Device", preferredStyle: .alert)
                let okButton = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                aleart.addAction(okButton)
                self.present(aleart, animated: true, completion: nil)
            }else{
                let aleart = UIAlertController.init(title: nil ,message: "Not Saved and try again!", preferredStyle: .alert)
                let okButton = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                aleart.addAction(okButton)
                self.present(aleart, animated: true, completion: nil)
            }
            
            return
        case .exportToPSD:
            print("Export PSD")
            return
        case .exportToPNG:
            let dataToShare : Any
            
            if let image = exportViewImage {
                if let data = image.pngData() {

                    let temporaryURL = FileManager.default.temporaryDirectory
                        .appendingPathComponent("Artwork")
                        .appendingPathExtension("png")
                    
                    do {
                        try data.write(to: temporaryURL, options: [])
                    } catch {
                        print(error)
                    }
                    dataToShare = [temporaryURL]
                    
                    let activityViewController = UIActivityViewController(activityItems: dataToShare as! [Any], applicationActivities: nil)
                    
                    let fakeViewController = UIViewController()
                    fakeViewController.view.backgroundColor = UIColor.clear
                    fakeViewController.modalPresentationStyle = .overFullScreen
                    
                    activityViewController.popoverPresentationController?.sourceView = fakeViewController.view
                    activityViewController.popoverPresentationController?.sourceRect = fakeViewController.view.frame
                    activityViewController.popoverPresentationController?.permittedArrowDirections = []
                    
                    activityViewController.completionWithItemsHandler = { [weak fakeViewController] activity, completed, items, error in
                        if let presentingViewController = fakeViewController?.presentingViewController {
                            presentingViewController.dismiss(animated: false, completion: nil)
                        } else {
                            fakeViewController?.dismiss(animated: false, completion: nil)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                        //                                           progressHudVC.dismissProgressHudVC()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            self.present(fakeViewController, animated: true) { [weak fakeViewController] in
                                fakeViewController?.present(activityViewController, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            
            func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                return paths[0]
            }

            return
        case .googleClassRoom:
            
            let imageRef = Storage.storage().reference().child("test_image.jpg")
               uploadImage(exportViewImage, at: imageRef) { (downloadURL) in
                   guard let downloadURL = downloadURL else {
                       return
                   }

                   let urlString = downloadURL.absoluteString
                   print("image url: \(urlString)")
                   let encodedString = downloadURL.absoluteString.addingPercentEncoding(withAllowedCharacters:.alphanumerics)
                   if encodedString != nil{
                       let url = URL(string: "https://classroom.google.com/share?url=" + encodedString!)
                       if url != nil{
                           UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                       }
                   }
               }
                
            
            func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
                guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                    return completion(nil)
                }
                reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                        return completion(nil)
                    }
                    reference.downloadURL(completion: { (url, error) in
                        if let error = error {
                            assertionFailure(error.localizedDescription)
                            return completion(nil)
                        }
                        completion(url)
                    })
                })
            }
            
            print("Google Class Room")
            return
        case .messanger:
            let photo = SharePhoto(image: exportViewImage, isUserGenerated: true)
            let content = SharePhotoContent()
                    content.photos = [photo]

            let dialog = MessageDialog(content: content, delegate: self)

            if(dialog.canShow){
                do {
                    try dialog.validate()
                } catch {
                    print(error)
                }
                

                dialog.show()
            }else{
                let aleart = UIAlertController.init(title: nil ,message: "Please install Messenger app and try again!", preferredStyle: .alert)
                let okButton = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                aleart.addAction(okButton)
            }
            print("Messenger")
            return
        case .facebook:
            print("Facebook")

            let photo = SharePhoto(image: exportViewImage, isUserGenerated: true)
            let content = SharePhotoContent()
            content.photos = [photo]

            let showDialog = ShareDialog(viewController: self, content: content, delegate: self)
            
            if (showDialog.canShow) {
                showDialog.show()
            } else {
                let aleart = UIAlertController.init(title: nil ,message: "Please install Facebook app and try again!", preferredStyle: .alert)
                let okButton = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
                aleart.addAction(okButton)
                self.present(aleart, animated: true, completion: nil)
                
            }
            return
        case .email:
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate;
                mail.setSubject("Hello! This is my drawing !!")
                mail.setMessageBody("Hello, have a look at my Drawing Desk art !!. I drew this from Drawing Desk by 4Axis Solutions.", isHTML: false)
                
                let imageData: NSData = exportViewImage.pngData()! as NSData
   
                mail.addAttachmentData(imageData as Data, mimeType: "image/jpeg", fileName: "drawingdeskArt.jpg")
                
                self.present(mail, animated: true, completion: nil)
                
            }else  {
                let email = "kukesan@4axissolutions.com"
                if let url = URL(string: "mailto:\(email)") {
                  if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                  } else {
                    UIApplication.shared.openURL(url)
                  }
                }
            }
            
            print("Email")
            return
        case .twitter:
            let store = TWTRTwitter.sharedInstance().sessionStore
            if store.session() != nil {
                composeTweet(image: exportViewImage, viewController: self)
            }
            else {
                TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
                    if (session != nil) {
                        print("login first time in twitter as \(String(describing: session?.userName))");
                        composeTweet(image: self.exportViewImage, viewController: self)
                    } else {
                        print("error: \(String(describing: error?.localizedDescription))");
                    }
                })
            }
            
            func composeTweet(image : UIImage, viewController : UIViewController){
                let composer = TWTRComposer()
                
                composer.setText("#MadeWithDrawingDesk")
                composer.setImage(image)
                
                composer.show(from: viewController) { result in
                    if result == TWTRComposerResult.cancelled {
                        print("Tweet composition cancelled")
                        
                    }else if(result == TWTRComposerResult.done) {
                        print("Tweet composition done")
                    } else {
                        print("Sending Tweet!")
                    }
                }
            }
            
            print("Twitter")
            return
        case .print:
            let data: Data? = exportViewImage.pngData()!
            let pic = UIPrintInteractionController.shared
            
            if let data = data {
                if UIPrintInteractionController.canPrint(data) {
                    
                    let printInfo = UIPrintInfo.printInfo()
                    printInfo.outputType = .photo
                    printInfo.jobName = "Drawing Desk Art"
                    pic.printInfo = printInfo
                    pic.printingItem = data
                    
                    let completionHandler: ((UIPrintInteractionController?, Bool, Error?) -> Void)? = { pic, completed, error in
                        if !completed && error != nil {
                            print(String(format: "FAILED! due to error in domain %@ with error code %ld", (error as NSError?)?.domain ?? "", Int(error?._code ?? 0)))
                        } else {
                            if completed {
                                
                            }
                        }
                    }
                    pic.present(animated: true, completionHandler: completionHandler)
                }
            }
            print("Print")
            return
        case .continues:
            print("Continue")
            return
        }
    }
}

extension ExportViewController :  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exportOptions[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? ExportOptionsCollectionViewCell
        cell?.exportOptionName.text = exportOptions[indexPath.section][indexPath.item].descriptions
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return exportOptions.count
    }
}

extension ExportViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 180, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 4
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 12, left: 4, bottom: 12, right: 4)
    }
    
}

extension ExportViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        exportOptionsAction(exportOptionsEnum : exportOptions[indexPath.section][indexPath.item])
    }
}

extension ExportViewController : SharingDelegate {
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print("Successfully shared to facebook or messenger")
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print("Successfully shared to facebook or messenger")
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        print("Successfully shared to facebook or messenger")
    }
    
    
}

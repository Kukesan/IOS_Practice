//
//  ViewController.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-06.
//

import UIKit
import Popover

class DocumentData{
    var documentId : String! = ""
    var image : UIImage!
}

class ViewController: UIViewController {
    
    private var popover: Popover?
    let kCellIdentifier_CollectionViewCell = "kCellIdentifier_CollectionViewCell"
    
    private lazy var imagePickerOptions : [String] = ["Camera", "Library", "Saved Image"]
    private lazy var sideBarButtonOptions : [SideBarOptions] = [.addButton,.layerButton,.lessonsButton,.shapesButton,.imagePickerButton]
    private var savedDocumentsArray : [DocumentData] = UserDefaults.standard.value(forKey: "UserSavedDocuments" ) as? [DocumentData] ?? []
//    = UserDefaults.standard.array(forKey: "UserSavedDocuments")
    
    var orientations = UIInterfaceOrientationMask.landscape
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        get { return self.orientations }
        set { self.orientations = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    
    private lazy var sideBarButtonOptionsCollectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout();
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(SideBarCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var imagePickerOptionsCollectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout();
        collectionViewLayout.scrollDirection = .horizontal
        
        let testCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        testCollectionView.register(ImagePickerOptionsCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        testCollectionView.translatesAutoresizingMaskIntoConstraints = false
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.frame = CGRect(x: 0, y: 0, width: 120, height:100)
        return testCollectionView
    }()
    
    private lazy var imageVw : UIImageView = {
       let vw = UIImageView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    private lazy var savedDocumentssCollectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout();
        collectionViewLayout.scrollDirection = .vertical
        
        let testCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        testCollectionView.register(SavedDocumentsCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        testCollectionView.translatesAutoresizingMaskIntoConstraints = false
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.backgroundColor = .brown
        return testCollectionView
    }()

    func getSavedDocuments(){
        self.savedDocumentsArray = UserDefaults.standard.value(forKey: "UserSavedDocuments" )! as! [DocumentData]
    }

    func configure(){
        imageVw.isHidden = false
        savedDocumentssCollectionView.isHidden = true
        
        self.view.addSubview(imageVw)
        self.view.addSubview(sideBarButtonOptionsCollectionView)
        self.view.addSubview(savedDocumentssCollectionView)
        
        switch UIDevice.current.userInterfaceIdiom {
          case .phone:
            
            imageVw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 32).isActive = true
            imageVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            imageVw.widthAnchor.constraint(equalToConstant: 720).isActive = true
            imageVw.heightAnchor.constraint(equalToConstant: 330).isActive = true
            
            break
          case .pad:
            
            imageVw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 32).isActive = true
            imageVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            imageVw.widthAnchor.constraint(equalToConstant: 900).isActive = true
            imageVw.heightAnchor.constraint(equalToConstant: 600).isActive = true
            
            sideBarButtonOptionsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 250).isActive = true
            sideBarButtonOptionsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16).isActive = true
            sideBarButtonOptionsCollectionView.widthAnchor.constraint(equalToConstant: 60).isActive = true
            sideBarButtonOptionsCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            
            savedDocumentssCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 32).isActive = true
            savedDocumentssCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            savedDocumentssCollectionView.widthAnchor.constraint(equalToConstant: 900).isActive = true
            savedDocumentssCollectionView.heightAnchor.constraint(equalToConstant: 600).isActive = true

            break
        @unknown default:
              print("Unknown")
          }
        
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func buttonFunction(buttonType : SideBarOptions){
        switch buttonType {
        case .addButton:
            imageVw.isHidden = true
            savedDocumentssCollectionView.isHidden = false
            savedDocumentssCollectionView.reloadData()
        case .layerButton:
            let startPoint = CGPoint(x: self.view.center.x-258 , y:730 )
            let options:[PopoverOption] = [
                .cornerRadius(8),
                .type(.right),
                .arrowSize(CGSize.zero),
                .animationIn(0.3),
                .animationOut(0.3),
                .color(UIColor(hexString: "#9E9FA1"))
            ]

            self.popover = Popover(options: options)
            self.popover!.layer.cornerRadius = 8

            self.popover!.show(LayerPopOver(), point: startPoint, inView: self.view)
        case .lessonsButton:
            let vc = AllLessonsViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
        case .shapesButton:
            let vc = FullShapesViewController()
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
        case .imagePickerButton:
            let startPoint = CGPoint(x: sideBarButtonOptionsCollectionView.frame.width , y: sideBarButtonOptionsCollectionView.frame.origin.y + 280 )
            let options:[PopoverOption] = [
                .cornerRadius(8),
                .type(.right),
                .arrowSize(CGSize.zero),
                .animationIn(0.3),
                .animationOut(0.3),
                .color(.black)
            ]

            self.popover = Popover(options: options)
            self.popover!.layer.cornerRadius = 8

            self.popover!.show(imagePickerOptionsCollectionView, point: startPoint, inView: self.view)
        case .exportImageButton:
            let vc = ExportViewController(exportImage : imageVw.image)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated: false)
        }
    }
    
    func getDocumentId()->Int{
        if let savedDocument = UserDefaults.standard.array(forKey:"UserSavedDocuments"){
//            let documentIds:IndexSet = []
//            return documentIds.max()!
            return savedDocument.count
        }
        return 0
    }
}

extension ViewController :  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == imagePickerOptionsCollectionView){
            return imagePickerOptions.count
        }else if(collectionView == sideBarButtonOptionsCollectionView){
            return sideBarButtonOptions.count
        }else{
            return savedDocumentsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == imagePickerOptionsCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? ImagePickerOptionsCollectionViewCell
            cell?.imagePickerOptionsName.text = imagePickerOptions[indexPath.item]
            return cell!
        }else if(collectionView == sideBarButtonOptionsCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? SideBarCollectionViewCell
            cell?.sideBarButtonImage.image = UIImage(named: sideBarButtonOptions[indexPath.item].buttonName)
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? SavedDocumentsCollectionViewCell
            cell?.savedDocumentImage.image = savedDocumentsArray[indexPath.item].image as? UIImage
            return cell!
        }
    }
}

extension ViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == imagePickerOptionsCollectionView){
            if(indexPath.row == 0){
                let cameraImagePicker = self.imagePicker(sourceType: .camera)
                cameraImagePicker.delegate = self
                self.present(cameraImagePicker,animated: true)
            }else if(indexPath.row == 1){
                let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
                libraryImagePicker.delegate = self
                self.present(libraryImagePicker,animated: true)
            }else{
                let savedImagePicker = self.imagePicker(sourceType: .savedPhotosAlbum)
                savedImagePicker.delegate = self
                self.present(savedImagePicker,animated: true)
            }
            popover?.dismiss()
        }else{
            buttonFunction(buttonType :sideBarButtonOptions[indexPath.item])
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == imagePickerOptionsCollectionView){
            return CGSize(width: 140, height: 20)
        }else if(collectionView == sideBarButtonOptionsCollectionView){
            return CGSize(width: 45, height: 45)
        }else{
            return CGSize(width: 200, height: 160)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if(collectionView == imagePickerOptionsCollectionView){
            return 16
        }else{
            return 2
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if(collectionView == imagePickerOptionsCollectionView){
            return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        }else{
            return UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
        }
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.imageVw.image = image
        self.dismiss(animated: true, completion: nil)
//        exportBtn.isHidden = false
//        savedDocumentsArray.append(image)
        imageVw.isHidden = false
        savedDocumentssCollectionView.isHidden = true
//       var savedDocument = UserDefaults.standard.dictionary(forKey:"UserSavedDocuments")
//        savedDocuments[String(getDocumentId())] = image
        var savedDocuments = DocumentData()
        savedDocuments.documentId! = String(getDocumentId())
        savedDocuments.image = image
        self.savedDocumentsArray.append(savedDocuments)
            
//        savedDocument.updateValue(image, forKey: getDocumentId())
        
        UserDefaults.standard.set(self.savedDocumentsArray, forKey: "UserSavedDocuments" )
        UserDefaults.standard.synchronize()
    }
}




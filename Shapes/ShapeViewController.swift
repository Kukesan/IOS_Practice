//
//  ShapeViewController.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-07.
//

import UIKit
import Popover

protocol ShapeViewControllerDelegate : class {
    func addFavItem(for addArrayItem : Shape)
    func removeFavItem(for removeArrayItem : Shape)
}

class ShapeViewController: UIViewController {
    
    private var popover: Popover?

    var shapeNameArray : [Shape] = []
    var isFavVc : Bool!
    let kCellIdentifier_CollectionViewCell = "kCellIdentifier_CollectionViewCell"
    
    weak var delegate : ShapeViewControllerDelegate?
    
    init(shapeArray:[Shape],isFav:Bool){
        super.init(nibName: nil, bundle: nil)
        self.shapeNameArray = shapeArray
        self.isFavVc = isFav
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        super.loadView()
        configure()
    }
    
    lazy var shapesCollectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout();
        
        let testCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        testCollectionView.register(ShapeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        testCollectionView.translatesAutoresizingMaskIntoConstraints = false
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.backgroundColor = UIColor.clear
        testCollectionView.layer.cornerRadius = 10
        testCollectionView.isUserInteractionEnabled = true
        return testCollectionView
        
    }()
    
    lazy var favBtn : UIButton = {
        let btn = UIButton()
        if(isFavVc == false){
            btn.setTitle("Add Favourite", for: .normal)
            btn.addTarget(self, action: #selector(addToList(_ : )), for: .touchUpInside)
        }else{
            btn.setTitle("Remove Favourite", for: .normal)
            btn.addTarget(self, action: #selector(removeToList(_ : )), for: .touchUpInside)
        }
        return btn
    }()
    
    func configure(){
        self.view.addSubview(shapesCollectionView)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            shapesCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 4).isActive = true
            shapesCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            shapesCollectionView.widthAnchor.constraint(equalToConstant: 680).isActive = true
            shapesCollectionView.heightAnchor.constraint(equalToConstant: 230).isActive = true
            break
        case .pad:
            shapesCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 4).isActive = true
            shapesCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            shapesCollectionView.widthAnchor.constraint(equalToConstant: 1000).isActive = true
            shapesCollectionView.heightAnchor.constraint(equalToConstant: 600).isActive = true
            break
        @unknown default:
            print("Unknown")
        }
    }
}

extension ShapeViewController :  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shapeNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? ShapeCategoryCollectionViewCell
        cell?.delegate = self
        cell?.shapeIcon.image =  UIImage(named:shapeNameArray[indexPath.item].name)?.withTintColor(UIColor(hexString: "#B8B9BA"), renderingMode: .alwaysOriginal)
        return cell!
    }
}

extension ShapeViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: - UICollectionViewDelegateFlowLayout delegate methods
extension ShapeViewController: UICollectionViewDelegateFlowLayout {
    
   

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return CGSize(width: 120, height: 150)
        case .pad:
            return CGSize(width: 160, height: 190)
        @unknown default:
            print("Unknown")
            return CGSize(width: 140, height: 190)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}


extension ShapeViewController : ShapeCategoryCollectionViewCellDelegate {
    
    func fav(for indexPath: IndexPath) {
        print(indexPath)
        
        let cell = shapesCollectionView.cellForItem(at: indexPath) as! ShapeCategoryCollectionViewCell
        print(shapesCollectionView.tag)
        
        let startPoint = CGPoint(x: cell.frame.origin.x + cell.frame.width - 24 , y: cell.frame.origin.y + cell.frame.height + 32 )
        
        let favouriteVw = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 60))
        favouriteVw.isUserInteractionEnabled = true
        
        favBtn.frame = CGRect(x: 0, y: 0, width: 160, height: 60)
        favouriteVw.addSubview(favBtn)
        favBtn.isUserInteractionEnabled = true

        favBtn.setTitleColor(.black, for: .normal)
        favBtn.tag = indexPath.row
        
        let options:[PopoverOption] = [
            .cornerRadius(8),
            .type(.right),
            .arrowSize(CGSize.zero),
            .animationIn(0.3),
            .animationOut(0.3),
            .color(UIColor.white)
        ]

        self.popover = Popover(options: options)
        self.popover!.layer.cornerRadius = 8

        self.popover!.show(favouriteVw, point: startPoint, inView: shapesCollectionView)

    }
    
    @objc func addToList(_ sender: UIButton){
        delegate?.addFavItem(for : shapeNameArray[sender.tag])
        self.popover!.dismiss()
    }
    
    @objc func removeToList(_ sender: UIButton){
        delegate?.removeFavItem(for : shapeNameArray[sender.tag])
        self.popover!.dismiss()
    }
}

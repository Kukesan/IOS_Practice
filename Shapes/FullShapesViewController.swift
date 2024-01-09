//
//  FullShapesViewController.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-06.
//

import UIKit

class FullShapesViewController: UIViewController {
    
    let kCellIdentifier_CollectionViewCell = "kCellIdentifier_CollectionViewCell"
    let pageIndex:Int = 0
//    var pages = [UIViewController]()
    
    private lazy var shapeTypes : [ShapeType] = [.favourite , .square , .circle , .triangle]

    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        if let firstViewController = shapeViewControllers.first {
            shapesPageViewController.setViewControllers([firstViewController],
                                      direction: .forward,
                       animated: true,
                       completion: nil)
               }
    }
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    lazy var fullShapeVw : UIView = {
       let fsv = UIView()
        fsv.translatesAutoresizingMaskIntoConstraints = false
        fsv.backgroundColor = UIColor(hexString: "#313233")
        fsv.layer.cornerRadius = 10
        return fsv
    }()
    
    lazy var closeBtn : UIButton = {
       let cbtn = UIButton()
        cbtn.translatesAutoresizingMaskIntoConstraints = false
        cbtn.setImage(UIImage(named: "close")?.withTintColor(UIColor(hexString: "#B8B9BA"), renderingMode: .alwaysOriginal), for: .normal)
        cbtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        return cbtn
    }()
    
    lazy var shapesHeadLbl : UILabel = {
        let shvw = UILabel()
        shvw.translatesAutoresizingMaskIntoConstraints = false
        shvw.text = "Select items"
        shvw.textColor = UIColor(hexString: "#E2E3E4")
        shvw.font = UIFont(name: "Aktiv Grotesk", size: 17)
        shvw.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return shvw
    }()
    
    lazy var searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.searchBarStyle = .minimal
        sb.setTextField(color: UIColor(hexString: "#242526"))
        sb.searchTextField.layer.cornerRadius = 8
        sb.placeholder = "Search shape"
        sb.set(textColor: UIColor(hexString: "#B8B9BA"))
        sb.setSearchImage(color: UIColor(hexString:"#B8B9BA"))
        sb.setPlaceholder(textColor: UIColor(hexString: "#B8B9BA"))
        sb.clipsToBounds = true
        sb.layer.cornerRadius = 8
        return sb
    }()
    
    lazy var doneBtn : UIButton = {
       let dbtn = UIButton()
        dbtn.translatesAutoresizingMaskIntoConstraints = false
        dbtn.setTitle("Done", for: .normal)
        dbtn.backgroundColor = UIColor(hexString: "#1874EE")
        dbtn.titleLabel?.font = UIFont(name: "Aktiv Grotesk", size: 14)
        dbtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        dbtn.titleLabel?.textColor = UIColor(hexString: "#FFFFFF")
        dbtn.layer.cornerRadius = 8
        dbtn.addTarget(self, action: #selector(done), for: .touchUpInside)
        return dbtn
    }()
    
    lazy var shapesHeaderCollectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout();
        collectionViewLayout.scrollDirection = .horizontal
        let testCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        testCollectionView.register(ShapesHeaderCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        testCollectionView.translatesAutoresizingMaskIntoConstraints = false
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.backgroundColor = UIColor(hexString: "#313233")
        return testCollectionView
    }()
    
    private lazy var shapesPageViewController : UIPageViewController = {
        let spvc = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        spvc.dataSource = self
        spvc.delegate = self
        spvc.view.translatesAutoresizingMaskIntoConstraints = false
        spvc.view.isUserInteractionEnabled = true
        return spvc
    }()
    
    var favouriteVC :ShapeViewController?
    var squareVC:ShapeViewController?
    var circleVC:ShapeViewController?
    var triangleVC:ShapeViewController?
    
    private lazy var shapeViewControllers: [UIViewController] = {
        
        favouriteVC = ShapeViewController(shapeArray: shapeTypes[0].shapeArray,isFav : true)
        squareVC = ShapeViewController(shapeArray: shapeTypes[1].shapeArray,isFav : false)
        circleVC = ShapeViewController(shapeArray: shapeTypes[2].shapeArray,isFav : false)
        triangleVC = ShapeViewController(shapeArray: shapeTypes[3].shapeArray,isFav : false)
        
        favouriteVC?.delegate = self
        squareVC?.delegate = self
        circleVC?.delegate = self
        triangleVC?.delegate = self
        
        return [favouriteVC! as UIViewController ,squareVC! as UIViewController,circleVC! as UIViewController,triangleVC! as UIViewController]
        
    }()
    
    func configure(){
        self.view.addSubview(fullShapeVw)
        
        fullShapeVw.addSubview(closeBtn)
        fullShapeVw.addSubview(shapesHeadLbl)
        fullShapeVw.addSubview(searchBar)
        fullShapeVw.addSubview(doneBtn)
        
        fullShapeVw.addSubview(shapesPageViewController.view)
        fullShapeVw.addSubview(shapesHeaderCollectionView)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            fullShapeVw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 32).isActive = true
            fullShapeVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            fullShapeVw.widthAnchor.constraint(equalToConstant: 720).isActive = true
            fullShapeVw.heightAnchor.constraint(equalToConstant: 330).isActive = true

            closeBtn.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 16).isActive = true
            closeBtn.leadingAnchor.constraint(equalTo: fullShapeVw.leadingAnchor,constant: 16).isActive = true
            closeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            closeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            shapesHeadLbl.leadingAnchor.constraint(equalTo: closeBtn.trailingAnchor,constant: 12).isActive = true
            shapesHeadLbl.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 24).isActive = true
            shapesHeadLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            doneBtn.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 16).isActive = true
            doneBtn.trailingAnchor.constraint(equalTo: fullShapeVw.trailingAnchor,constant: -16).isActive = true
            doneBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
            doneBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            searchBar.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 16).isActive = true
            searchBar.trailingAnchor.constraint(equalTo: doneBtn.leadingAnchor,constant: -16).isActive = true
            searchBar.widthAnchor.constraint(equalToConstant: 200).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            shapesHeaderCollectionView.topAnchor.constraint(equalTo: closeBtn.bottomAnchor,constant: 8).isActive = true
            shapesHeaderCollectionView.leadingAnchor.constraint(equalTo: fullShapeVw.leadingAnchor,constant: 16).isActive = true
            shapesHeaderCollectionView.widthAnchor.constraint(equalToConstant: 500).isActive = true
            shapesHeaderCollectionView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            shapesPageViewController.view.topAnchor.constraint(equalTo: shapesHeaderCollectionView.bottomAnchor,constant: 4).isActive = true
            shapesPageViewController.view.centerXAnchor.constraint(equalTo: fullShapeVw.centerXAnchor).isActive = true
            shapesPageViewController.view.widthAnchor.constraint(equalToConstant: 680).isActive = true
            shapesPageViewController.view.heightAnchor.constraint(equalToConstant: 230).isActive = true
            
            break
        case .pad:
            fullShapeVw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 32).isActive = true
            fullShapeVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            fullShapeVw.widthAnchor.constraint(equalToConstant: 1000).isActive = true
            fullShapeVw.heightAnchor.constraint(equalToConstant: 700).isActive = true
            
            closeBtn.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 16).isActive = true
            closeBtn.leadingAnchor.constraint(equalTo: fullShapeVw.leadingAnchor,constant: 16).isActive = true
            closeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            closeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            shapesHeadLbl.leadingAnchor.constraint(equalTo: closeBtn.trailingAnchor,constant: 12).isActive = true
            shapesHeadLbl.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 24).isActive = true
            shapesHeadLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            doneBtn.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 16).isActive = true
            doneBtn.trailingAnchor.constraint(equalTo: fullShapeVw.trailingAnchor,constant: -16).isActive = true
            doneBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
            doneBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            searchBar.topAnchor.constraint(equalTo: fullShapeVw.topAnchor,constant: 16).isActive = true
            searchBar.trailingAnchor.constraint(equalTo: doneBtn.leadingAnchor,constant: -16).isActive = true
            searchBar.widthAnchor.constraint(equalToConstant: 200).isActive = true
            searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            shapesHeaderCollectionView.topAnchor.constraint(equalTo: closeBtn.bottomAnchor,constant: 8).isActive = true
            shapesHeaderCollectionView.leadingAnchor.constraint(equalTo: fullShapeVw.leadingAnchor,constant: 16).isActive = true
            shapesHeaderCollectionView.widthAnchor.constraint(equalToConstant: 500).isActive = true
            shapesHeaderCollectionView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            shapesPageViewController.view.topAnchor.constraint(equalTo: shapesHeaderCollectionView.bottomAnchor,constant: 20).isActive = true
            shapesPageViewController.view.centerXAnchor.constraint(equalTo: fullShapeVw.centerXAnchor).isActive = true
            shapesPageViewController.view.widthAnchor.constraint(equalToConstant: 980).isActive = true
            shapesPageViewController.view.heightAnchor.constraint(equalToConstant: 600).isActive = true
            break
        @unknown default:
            print("Unknown")
        }
    }

    @objc func close(){
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func done(){
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension FullShapesViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool){
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = shapeViewControllers.index(of: currentViewController) {
                self.shapesHeaderCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .init())
            }
        }
    }
}

extension FullShapesViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = shapeViewControllers.firstIndex(of: viewController) else {
                return nil
            }

            let previousIndex = viewControllerIndex - 1

            // User is on the first view controller and swiped left to loop to
            // the last view controller.
            guard previousIndex >= 0 else {
                return shapeViewControllers.last
            }

            guard shapeViewControllers.count > previousIndex else {
                return nil
            }

            return shapeViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = shapeViewControllers.firstIndex(of: viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = shapeViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
            guard orderedViewControllersCount != nextIndex else {
                return shapeViewControllers.first
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return shapeViewControllers[nextIndex]
    }
}


extension FullShapesViewController :  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shapeViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? ShapesHeaderCollectionViewCell
        cell?.shapeCategoryName.text = shapeTypes[indexPath.item].shapeTypeName
        return cell!
    }
}

// MARK: - UICollectionViewDelegate delegate methods
extension FullShapesViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.shapesPageViewController.setViewControllers([shapeViewControllers[indexPath.item]], direction: .forward, animated: true)
        
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout delegate methods
extension FullShapesViewController: UICollectionViewDelegateFlowLayout {
    
   

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 20)
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

extension FullShapesViewController : ShapeViewControllerDelegate {

    func addFavItem(for addArrayItem : Shape){
        favouriteArray.append(addArrayItem)
        favouriteVC?.shapeNameArray = shapeTypes[0].shapeArray
        favouriteVC?.shapesCollectionView.reloadData()
    }
    
    func removeFavItem(for removeArrayItem: Shape) {
        if let index = shapeTypes[0].shapeArray.index(where: {$0.name == removeArrayItem.name}) {
            favouriteArray.remove(at: index)
        }
        favouriteVC?.shapeNameArray = shapeTypes[0].shapeArray
        favouriteVC?.shapesCollectionView.reloadData()
    }
}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension UISearchBar {

    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func set(textColor: UIColor) { if let textField = getTextField() { textField.textColor = textColor } }
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }

    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }

    func setSearchImage(color: UIColor) {
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        imageView.tintColor = color
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    }
}

private extension UITextField {

    private class Label: UILabel {
        private var _textColor = UIColor.lightGray
        override var textColor: UIColor! {
            set { super.textColor = _textColor }
            get { return _textColor }
        }

        init(label: UILabel, textColor: UIColor = .lightGray) {
            _textColor = textColor
            super.init(frame: label.frame)
            self.text = label.text
            self.font = label.font
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }


    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = "txt"
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }

    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }

    func setPlaceholder(textColor: UIColor) {
        guard let placeholderLabel = placeholderLabel else { return }
        let label = Label(label: placeholderLabel, textColor: textColor)
        setValue(label, forKey: "placeholderLabel")
    }

    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }
}

//
//  AllLessonsViewController.swift
//  Practice1
//
//  Created by Ketheeswaran Kukesan on 2023-04-26.
//

import UIKit

class AllLessonsViewController: UIViewController {
    
    let kCellIdentifier_CollectionViewCell = "kCellIdentifier_CollectionViewCell"
    
    var lessonsCategory : LessonCategories!
    
    private var srollTimer: Timer? = nil
    private var lessonsCollectionViewLeft:CGFloat = 0
    private var lessonsCollectionViewLeading:NSLayoutConstraint!
    
    private lazy var lessonsCategoriesOptions : [LessonCategories] = [.horizontalLine,
                                                                      .verticalLine,
                                                                      .curvedLine,
                                                                      .circularSpiral,
                                                                      .rectangularSpiral,
                                                                      .freehandDrawing,
                                                                      .drawingExercise,
                                                                      .drawLighthouse,
                                                                      .circularSpiral,
                                                                      .horizontalLine,
                                                                      .rectangularSpiral,
                                                                      .drawLighthouse
    ]
    
    private var lessonsCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        lessonsCount = lessonsCategoriesOptions.count
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 ) {
            self.lessonsCollectionView.reloadData()
            print("0.05")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ) { [self] in
            print("1")
            srollTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.animationfunc), userInfo: nil, repeats: true)
        }
        
        self.view.layoutIfNeeded()
    }
    
    @objc func animationfunc(){
        UIView.animate(withDuration: 4, delay: 0, options: UIView.AnimationOptions.curveLinear) { [self] in
            print("Animation")
            lessonsCollectionViewLeft = lessonsCollectionViewLeft - 120
            self.lessonsCollectionViewLeading.constant = lessonsCollectionViewLeft
            self.view.layoutIfNeeded()
            lessonsCount+=1
            lessonsCollectionView.reloadData()
        }
    }
    
    lazy var fullLessonsVw : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.layer.shadowOffset = CGSize(width: 1,
                                       height: 1)
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var lessonsCollectionView: UICollectionView = {
        
        let collectionVL = CustomAlignedCollectionViewFlowLayout()
        collectionVL.scrollDirection = .horizontal
        
        let testCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionVL)
        testCollectionView.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        testCollectionView.translatesAutoresizingMaskIntoConstraints = false
        testCollectionView.dataSource = self
        testCollectionView.delegate = self
        testCollectionView.showsHorizontalScrollIndicator = false
        return testCollectionView
    }()
    
    lazy var closeBtn : UIButton = {
       let cbtn = UIButton()
        cbtn.translatesAutoresizingMaskIntoConstraints = false
        cbtn.setImage(UIImage(named: "close")?.withTintColor(UIColor(hexString: "#B8B9BA"), renderingMode: .alwaysOriginal), for: .normal)
        cbtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        return cbtn
    }()
    
    func configure(){
        self.view.addSubview(fullLessonsVw)
    
        fullLessonsVw.addSubview(lessonsCollectionView)
        fullLessonsVw.addSubview(closeBtn)
        
        fullLessonsVw.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        fullLessonsVw.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        fullLessonsVw.heightAnchor.constraint(equalToConstant: 300).isActive = true
        fullLessonsVw.widthAnchor.constraint(equalToConstant: 800).isActive = true
        
        lessonsCollectionView.centerXAnchor.constraint(equalTo: fullLessonsVw.centerXAnchor).isActive = true
        lessonsCollectionView.centerYAnchor.constraint(equalTo: fullLessonsVw.centerYAnchor).isActive = true
        lessonsCollectionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        lessonsCollectionView.widthAnchor.constraint(equalToConstant: 780).isActive = true
        
        closeBtn.topAnchor.constraint(equalTo: fullLessonsVw.topAnchor,constant: 4).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: fullLessonsVw.trailingAnchor,constant: -4).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.lessonsCollectionViewLeading = lessonsCollectionView.leadingAnchor.constraint(equalTo: fullLessonsVw.leadingAnchor)
        self.lessonsCollectionViewLeading.isActive = true
    }
    
    @objc func close(){
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
        self.dismiss(animated: false, completion: nil)
    }

}

extension AllLessonsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessonsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? LessonCollectionViewCell
        cell?.lessonName.text = lessonsCategoriesOptions[indexPath.item%lessonsCategoriesOptions.count].name
    
        return cell!
    }
}

extension AllLessonsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
        
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

class CustomAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
//        self.scrollDirection = .horizontal
//        self.minimumInteritemSpacing = 10.0
//        self.minimumLineSpacing = 10.0
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var indexNo : Int = 0
    

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

        attributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.forEach { minY, line in
                line.forEach {  i in
                    indexNo = i.indexPath.item
                    if(indexNo % 2 == 0){
                        i.frame = i.frame.offsetBy(
                            dx: 0,
                            dy: minY - 110
    //                        dy: minY - $0.frame.origin.y
                        )
                    }else{
                        i.frame = i.frame.offsetBy(
                            dx: 0,
                            dy: minY + 20
        //                    dy: minY - $0.frame.origin.y
                        )
                    }                    
                }
            }
        return attributes
    }
}
    


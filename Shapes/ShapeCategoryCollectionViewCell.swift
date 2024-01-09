//
//  ShapeCategoryCollectionViewCell.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-07.
//

import UIKit


protocol ShapeCategoryCollectionViewCellDelegate : class {
    func fav(for indexPath : IndexPath )
}

class ShapeCategoryCollectionViewCell: UICollectionViewCell {
    
    
    
    weak var delegate : ShapeCategoryCollectionViewCellDelegate?
    private var indexPath : IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var shapeIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var shapeBtn : UIButton = {
        let shapebtn = UIButton(type: .custom)
        let image = UIImage(named: "3dots")?.withRenderingMode(.alwaysTemplate)
        shapebtn.setImage(image, for: .normal)
        shapebtn.tintColor = UIColor(hexString: "#B8B9BA")
        shapebtn.translatesAutoresizingMaskIntoConstraints = false
        shapebtn.addTarget(self, action: #selector(clickFav), for: .touchUpInside)
        return shapebtn
    }()
    
    func configureCell()  {
        self.contentView.addSubview(shapeIcon)
        self.contentView.addSubview(shapeBtn)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            shapeIcon.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            shapeIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            shapeIcon.widthAnchor.constraint(equalToConstant: 120).isActive = true
            shapeIcon.heightAnchor.constraint(equalToConstant: 120).isActive = true
            
            shapeBtn.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -4).isActive = true
            shapeBtn.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -4).isActive = true
            shapeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            shapeBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
            break
        case .pad:
            shapeIcon.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            shapeIcon.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            shapeIcon.widthAnchor.constraint(equalToConstant: 160).isActive = true
            shapeIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            shapeBtn.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -4).isActive = true
            shapeBtn.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -4).isActive = true
            shapeBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
            shapeBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
            break
        @unknown default:
            print("Unknown")
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shapeIcon.image = nil
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.layer.borderColor = UIColor(hexString: "#1874EE").cgColor
                self.layer.borderWidth = 2
            }
            else
            {
                self.layer.borderWidth = 0
            }
        }
    }
    
    @objc func clickFav(){
        if let indexPath =  (self.superview as? UICollectionView)?.indexPath(for: self){
            delegate?.fav(for : indexPath)
        }
    }
}


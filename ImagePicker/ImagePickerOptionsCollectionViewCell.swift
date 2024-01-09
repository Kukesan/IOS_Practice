//
//  ImagePickerOptionsCollectionViewCell.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-19.
//

import UIKit

class ImagePickerOptionsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imagePickerOptionsVw : UIView = {
       let svw = UIView()
        svw.translatesAutoresizingMaskIntoConstraints = false
        return svw
    }()
    
    lazy var imagePickerOptionsName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "Aktiv Grotesk", size: 24)
        view.textColor = .white
        return view
    }()
    
    func configureCell()  {
        
        self.contentView.addSubview(imagePickerOptionsVw)
        imagePickerOptionsVw.addSubview(imagePickerOptionsName)
        
        NSLayoutConstraint.activate([
            imagePickerOptionsVw.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imagePickerOptionsVw.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imagePickerOptionsVw.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imagePickerOptionsVw.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            imagePickerOptionsName.topAnchor.constraint(equalTo: imagePickerOptionsVw.topAnchor),
            imagePickerOptionsName.leadingAnchor.constraint(equalTo: imagePickerOptionsVw.leadingAnchor),
            imagePickerOptionsName.trailingAnchor.constraint(equalTo: imagePickerOptionsVw.trailingAnchor),
        ])
    }
    
//    override var isSelected: Bool{
//        didSet{
//            if self.isSelected
//            {
//                self.imagePickerOptionsName.textColor = UIColor(hexString: "#E2E3E4")
//            }
//            else
//            {
//                self.imagePickerOptionsName.textColor = UIColor(hexString: "#B8B9BA")
//            }
//        }
//    }
}

//
//  LayerCollectionViewCell.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-27.
//

import UIKit

class LayerCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) { 
        super.init(frame: frame)
        self.backgroundColor = .black
        self.layer.cornerRadius = 4
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var layerImg : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    func configureCell()  {
        self.contentView.addSubview(layerImg)
        
        layerImg.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        layerImg.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        layerImg.heightAnchor.constraint(equalToConstant: self.contentView.frame.height-8).isActive = true
        layerImg.widthAnchor.constraint(equalToConstant: self.contentView.frame.width-8).isActive = true
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

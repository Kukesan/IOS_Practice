//
//  SavedDocumentsCollectionViewCell.swift
//  Practice1
//
//  Created by Ketheeswaran Kukesan  on 2023-05-16.
//

import UIKit

class SavedDocumentsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 4
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var savedDocumentImage : UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    func configureCell()  {
        self.contentView.addSubview(savedDocumentImage)
        
        savedDocumentImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        savedDocumentImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        savedDocumentImage.heightAnchor.constraint(equalToConstant: self.contentView.frame.height-8).isActive = true
        savedDocumentImage.widthAnchor.constraint(equalToConstant: self.contentView.frame.width-8).isActive = true
    }
}

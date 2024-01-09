//
//  ExportOptionsCollectionViewCell.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-20.
//

import UIKit

class ExportOptionsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var exportOptionName: UILabel = {
        let ul = UILabel()
        ul.translatesAutoresizingMaskIntoConstraints = false
        ul.textColor = .black
        ul.backgroundColor = .white
        ul.textAlignment = .left
        ul.font = UIFont(name: "Aktiv Grotesk", size: 14)
        ul.layer.cornerRadius = 5
        ul.clipsToBounds = true
        return ul
    }()
    
    func configureCell()  {
        
        self.contentView.addSubview(exportOptionName)
        
        NSLayoutConstraint.activate([
            
            exportOptionName.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            exportOptionName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            exportOptionName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            exportOptionName.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

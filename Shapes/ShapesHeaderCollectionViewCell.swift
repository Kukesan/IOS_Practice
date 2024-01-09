//
//  ShapesCollectionViewCell.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-06.
//

import UIKit

class ShapesHeaderCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var shapeCategoryName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.font = UIFont(name: "Aktiv Grotesk", size: 14)
        view.textColor = UIColor(hexString: "#B8B9BA")
        view.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return view
    }()
    
    func configureCell()  {
        self.contentView.addSubview(shapeCategoryName)
        
        shapeCategoryName.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        shapeCategoryName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        shapeCategoryName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        shapeCategoryName.widthAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.shapeCategoryName.textColor = UIColor(hexString: "#E2E3E4")
            }
            else
            {
                self.shapeCategoryName.textColor = UIColor(hexString: "#B8B9BA")
            }
        }
    }
}

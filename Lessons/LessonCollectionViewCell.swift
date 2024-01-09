//
//  LessonCollectionViewCell.swift
//  Practice1
//
//  Created by Ketheeswaran Kukesan on 2023-04-26.
//

import UIKit

class LessonCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var lessonVw : UIView = {
       let vw = UIView()
        vw.layer.borderWidth = 1
        vw.layer.borderColor = UIColor.black.cgColor
        vw.layer.cornerRadius = 2
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    lazy var lessonImg : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .white
        img.image = UIImage(named: "study")
        return img
    }()
    
    lazy var lessonName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.font = UIFont(name: "Aktiv Grotesk", size: 14)
        lb.textColor = .black
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return lb
    }()
    
    func configureCell()  {
        self.contentView.addSubview(lessonVw)
        
        lessonVw.addSubview(lessonName)
        lessonVw.addSubview(lessonImg)
        
        lessonVw.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        lessonVw.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        lessonVw.heightAnchor.constraint(equalToConstant: 100).isActive = true
        lessonVw.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        lessonImg.topAnchor.constraint(equalTo: lessonVw.topAnchor,constant: 8).isActive = true
        lessonImg.centerXAnchor.constraint(equalTo: lessonVw.centerXAnchor).isActive = true
        lessonImg.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lessonImg.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        lessonName.centerXAnchor.constraint(equalTo: lessonVw.centerXAnchor).isActive = true
        lessonName.bottomAnchor.constraint(equalTo: lessonVw.bottomAnchor,constant: -4).isActive = true
        lessonName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lessonName.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

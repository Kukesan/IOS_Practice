//
//  LayerPopOver.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-27.
//

import UIKit

class LayerPopOver: UIView {
    
    let kCellIdentifier_CollectionViewCell = "kCellIdentifier_CollectionViewCell"
    
    private lazy var layersOptionArray : [LayerOptions] = [.layer1,.layer2,.layer3,.layer4,.layer5,.layer6,.layer7,.layer5,.layer3,.layer5,.layer1]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: 506, height:96)
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var playButton:UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "play"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var addButton:UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "add"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var settingsButton:UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var layerOptionsCollectionVC : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout();
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionview.register(LayerCollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier_CollectionViewCell)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.backgroundColor = .clear
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
     
    func configureSubViews(){
        
        addSubview(playButton)
        addSubview(addButton)
        addSubview(settingsButton)
        
        addSubview(layerOptionsCollectionVC)
        
        playButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 4).isActive = true
        playButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 4).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -4).isActive = true
        addButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 4).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        settingsButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor,constant: -4).isActive = true
        settingsButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 8).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        layerOptionsCollectionVC.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -4).isActive = true
        layerOptionsCollectionVC.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        layerOptionsCollectionVC.heightAnchor.constraint(equalToConstant: 44).isActive = true
        layerOptionsCollectionVC.widthAnchor.constraint(equalToConstant: 498).isActive = true
    }
}

extension LayerPopOver : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layersOptionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier_CollectionViewCell, for: indexPath) as? LayerCollectionViewCell
        cell?.layerImg.image = UIImage(named: layersOptionArray[indexPath.item].imageName)?.withTintColor(.white)
        return cell!
    }
}

extension LayerPopOver: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:44, height: 44)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 2, left: 2, bottom: 2, right: 2)
    }
}

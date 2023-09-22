//
//  MainCollectionViewCell.swift
//  todolistreal1
//
//  Created by t2023-m0088 on 2023/09/19.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    
    private let ImageViewSize: CGFloat = 130
    
     let ImageVIew: UIImageView = {
        var view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        self.addSubview(ImageVIew)
    }
    
    private func setConstraint(){
        configureImageViewConstraint()
    }
    
    private func configureImageViewConstraint(){
        ImageVIew.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ImageVIew.topAnchor.constraint(equalTo: self.topAnchor),
            ImageVIew.widthAnchor.constraint(equalToConstant: ImageViewSize),
            ImageVIew.heightAnchor.constraint(equalToConstant: ImageViewSize),
            ImageVIew.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
}

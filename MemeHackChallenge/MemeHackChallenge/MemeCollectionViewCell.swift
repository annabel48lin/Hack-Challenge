//
//  MemeCollectionViewCell.swift
//  MemeHackChallenge
//
//  Created by Claire Wang on 11/21/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    var meme: UIImageView!
    var deleteLabel: UILabel!
    var id: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        meme = UIImageView()
        meme.contentMode = .scaleAspectFill
        meme.layer.masksToBounds = true
        meme.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(meme)
        
        deleteLabel = UILabel()
        deleteLabel.text = "PUT IN MEME ID"
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        //contentView.addSubview(deleteLabel)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let vPadding: CGFloat = -3
        let hPadding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            meme.topAnchor.constraint(equalTo: contentView.topAnchor, constant: hPadding),
            meme.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding),
            meme.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -hPadding),
            meme.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -hPadding)
        ])
    }
    
    @objc func tapped() {
        
    }
    
    func config(for m: Meme) {
        meme.image = UIImage(named: m.URL) // creating image using URL from Backend
        id = m.imageID
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

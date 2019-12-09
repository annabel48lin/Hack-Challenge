//
//  RestaurantCollectionViewCell.swift
//  cw696_p5
//
//  Created by Claire Wang on 11/2/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    var image: UIImageView!
    var name: UILabel!
    var mealType1: UILabel!
    var mealType2: UILabel!
    var mealType3: UILabel!
    var allMealTypes: [UILabel] = []
    var foodType: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        name = UILabel()
        name.font = UIFont(name: "SavoyeLetPlain", size: 30)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
        
        foodType = UILabel()
        foodType.font = Constants.subFont
        foodType.backgroundColor = Constants.foodColor
        foodType.layer.masksToBounds = true
        foodType.layer.cornerRadius = Constants.radius
        foodType.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(foodType)
        
        mealType1 = UILabel()
        mealType1.font = Constants.subFont
        mealType1.backgroundColor = Constants.mealColor
        mealType1.layer.masksToBounds = true
        mealType1.layer.cornerRadius = Constants.radius
        mealType1.isHidden = true
        mealType1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mealType1)
        
        mealType2 = UILabel()
        mealType2.font = Constants.subFont
        mealType2.backgroundColor = Constants.mealColor
        mealType2.layer.masksToBounds = true
        mealType2.layer.cornerRadius = Constants.radius
        mealType2.isHidden = true
        mealType2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mealType2)
        
        mealType3 = UILabel()
        mealType3.font = Constants.subFont
        mealType3.backgroundColor = Constants.mealColor
        mealType3.layer.masksToBounds = true
        mealType3.layer.cornerRadius = Constants.radius
        mealType3.isHidden = true
        mealType3.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mealType3)
        
        allMealTypes.append(mealType1)
        allMealTypes.append(mealType2)
        allMealTypes.append(mealType3)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let vPadding: CGFloat = -3
        let hPadding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: hPadding),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -hPadding),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            foodType.topAnchor.constraint(equalTo: name.bottomAnchor, constant: vPadding),
            foodType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hPadding)
        ])
        
        NSLayoutConstraint.activate([
            mealType1.topAnchor.constraint(equalTo: name.bottomAnchor, constant: vPadding),
            mealType1.leadingAnchor.constraint(equalTo: foodType.trailingAnchor, constant: hPadding)
        ])
        
        NSLayoutConstraint.activate([
            mealType2.topAnchor.constraint(equalTo: name.bottomAnchor, constant: vPadding),
            mealType2.leadingAnchor.constraint(equalTo: mealType1.trailingAnchor, constant: hPadding)
        ])
        
        NSLayoutConstraint.activate([
            mealType3.topAnchor.constraint(equalTo: name.bottomAnchor, constant: vPadding),
            mealType3.leadingAnchor.constraint(equalTo: mealType2.trailingAnchor, constant: hPadding)
        ])
    }
    
    func configure(for restaurant: Restaurant) {
        image.image = UIImage(named: restaurant.imagePath)
        name.text = restaurant.name
        foodType.text = "  \(restaurant.foodType)  "
        
        for n in 0..<restaurant.mealType.count {
            allMealTypes[n].text = "  \(restaurant.mealType[n])  "
            allMealTypes[n].isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

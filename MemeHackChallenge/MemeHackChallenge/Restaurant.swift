//
//  Restaurant.swift
//  cw696_p5
//
//  Created by Claire Wang on 11/1/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import Foundation

class Restaurant {
    
    var name: String
    var imagePath: String
    var mealType: [String] // breakfast, lunch, dinner
    var foodType: String // Chinese, Korean, Japanese, Indian, Mexican, American
    var star: String // 1-5 according to yelp.com
    var priceRange: String // $$ according to yelp.com
    var address: String
    var phone: String
    var detail: String
    
    init(name: String, imagePath: String, mealType: [String], foodType: String, star: String, priceRange: String, address: String, phone: String, detail: String) {
        self.name = name
        self.imagePath = imagePath
        self.mealType = mealType
        self.foodType = foodType
        self.star = star
        self.priceRange = priceRange
        self.address = address
        self.phone = phone
        self.detail = detail
    }
}

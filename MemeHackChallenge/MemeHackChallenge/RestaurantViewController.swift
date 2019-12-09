//
//  ViewController.swift
//  cw696_p5
//
//  Created by Claire Wang on 11/1/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    var restaurantCollection: UICollectionView!
    var allRestaurants: [Restaurant] = []

    var mealTypeFilterCollection: UICollectionView!
    var foodTypeFilterCollection: UICollectionView!
    var priceFilterCollection: UICollectionView!
    var starFilterCollection: UICollectionView!
    
    let restaurantCellReuseIdentifier = "restaurantCellReuseIdentifier"

    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Restaurants"
        view.backgroundColor = .black
        
        createRestaurants()
        
        let restaurantLayout = UICollectionViewFlowLayout()
        restaurantLayout.scrollDirection = .vertical
        restaurantLayout.minimumLineSpacing = padding
        restaurantLayout.minimumInteritemSpacing = padding
        
        restaurantCollection = UICollectionView(frame: .zero, collectionViewLayout: restaurantLayout)
        restaurantCollection.backgroundColor = .black
        restaurantCollection.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: restaurantCellReuseIdentifier)
        restaurantCollection.translatesAutoresizingMaskIntoConstraints = false
        restaurantCollection.dataSource = self
        restaurantCollection.delegate = self
        view.addSubview(restaurantCollection)
       
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            restaurantCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            restaurantCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            restaurantCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            restaurantCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }

    func createRestaurants() {
        let CTB = Restaurant(name: "Collegetown Bagels", imagePath: "CTB", mealType: ["Breakfast", "Lunch"], foodType: "American", star: "4 ✰✰✰✰", priceRange: "$", address: "415 College Ave Ithaca, NY 14850", phone: "(607) 273-0982", detail: "Bagels, Sandwiches, Coffee & Tea")
        let apollo = Restaurant(name: "Apollo", imagePath: "apollo", mealType: ["Lunch", "Dinner"], foodType: "Chinese", star: "3 ✰✰✰", priceRange: "$", address: "407 College Ave Ithaca, NY 14850", phone: "(607) 272-1188", detail: "Buffet-style traditional Chinese dish")
        let koko = Restaurant(name: "Koko", imagePath: "koko", mealType: ["Lunch", "Dinner"], foodType: "Korean", star: "3 ✰✰✰", priceRange: "$$", address: "321 College Ave Ithaca, NY 14850", phone: "(607) 277-8899", detail: "Traditional Korean dish (e.g. bibimbop, kalbi and bulgogi")
        let littleThaiHouse = Restaurant(name: "Little Thai House", imagePath: "littleThaiHouse", mealType: ["Lunch", "Dinner"], foodType: "Thai", star: "3 ✰✰✰", priceRange: "$", address: "202 Dryden Ct Ithaca, NY 14850", phone: "(607) 273-1977", detail: "Buffet-style Thai dish")
        let maruRamen = Restaurant(name: "Maru Ramen", imagePath: "maruRamen", mealType: ["Lunch", "Dinner"], foodType: "Japanese", star: "4 ✰✰✰✰", priceRange: "$$", address: "512 W State St Ithaca, NY 14850", phone: "(607) 339-0329", detail: "Ramen, Bars, Soul Food")
        let saigonKitchen = Restaurant(name: "Saigon Kitchen", imagePath: "saigonKitchen", mealType: ["Lunch", "Dinner"], foodType: "Vietnamese", star: "4 ✰✰✰✰", priceRange: "$$", address: "526 W State St Ithaca, NY 14850", phone: "(607) 257-8881", detail: "Traditional Vietnamese dish!")
        let deTastyHotPot = Restaurant(name: "De Tasty Hot Pot", imagePath: "deTastyHotPot", mealType: ["Lunch", "Dinner"], foodType: "Chinese", star: "3 ✰✰✰", priceRange: "$$", address: "422 Eddy St Ithaca, NY 14850", phone: "(607) 821-2312", detail: "Hot Pot, Dim Sum, Szechuan")
        let fourSeason = Restaurant(name: "Four Seasons", imagePath: "fourSeason", mealType: ["Lunch", "Dinner"], foodType: "Korean", star: "3 ✰✰✰", priceRange: "$$", address: "404 Eddy St Ithaca, NY 14850", phone: "(607) 277-1117", detail: "Traditional Korean dish!")
        let asianNoodleHouse = Restaurant(name: "Asian Noodle House", imagePath: "asianNoodleHouse", mealType: ["Lunch", "Dinner"], foodType: "Chinese", star: "3 ✰✰✰", priceRange: "$", address: "204 Dryden Rd Ithaca, NY 14850", phone: "(607) 272-9106", detail: "Tradition Chinese dish!")
        let sangamIndianCuisine = Restaurant(name: "Sangam Indian Cuisine", imagePath: "sangamIndianCuisine", mealType: ["Lunch", "Dinner"], foodType: "Indian", star: "3 ✰✰✰", priceRange: "$$", address: "424 Eddy St Ithaca, NY 14850", phone: "(607) 273-1006", detail: "Indian, seafood")
        let francosPizzeria = Restaurant(name: "Franco's Pizzeria", imagePath: "francosPizzeria", mealType: ["Lunch", "Dinner"], foodType: "Italian", star: "4 ✰✰✰✰", priceRange: "$", address: "508 W State St Ithaca, NY 14850", phone: "(607) 319-5132", detail: "Italian, pizza")
        allRestaurants = [CTB, apollo, koko, littleThaiHouse, maruRamen, saigonKitchen, deTastyHotPot, fourSeason, asianNoodleHouse, sangamIndianCuisine, francosPizzeria]
    }
}

extension RestaurantViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allRestaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
            let cell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
            cell.configure(for: allRestaurants[indexPath.row])
            return cell
        
    }
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 25
        
        if collectionView == self.restaurantCollection {
            let size = (restaurantCollection.frame.width - 1 * padding) / 2.0
            return CGSize(width: size, height: size)
        } else if collectionView == self.mealTypeFilterCollection {
            return CGSize(width: 65, height: height)
        } else if collectionView == self.foodTypeFilterCollection {
            return CGSize(width: 70, height: height)
        } else if collectionView == self.priceFilterCollection {
            return CGSize(width: 50, height: height)
        } else {
            return CGSize(width: 80, height: height)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: restaurantCollection.frame.width, height: headerHeight)
//    }
}

extension RestaurantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        restaurantCollection.reloadData()
    }
}

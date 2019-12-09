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
    var searchResult: [Meme] = []
    var searchBar: UISearchController!
    var memeImage: UIImageView!
    var topTextField: UITextField!
    var bottomTextField: UITextField!
    var finishButton: UIButton!
    var nameOfImage: String = "https://i.imgflip.com/3il2cu.jpg"
    var tempID: String = ""
    
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
        restaurantCollection.backgroundColor = .systemPink
        restaurantCollection.register(RestaurantCollectionViewCell.self, forCellWithReuseIdentifier: restaurantCellReuseIdentifier)
        restaurantCollection.translatesAutoresizingMaskIntoConstraints = false
        restaurantCollection.dataSource = self
        restaurantCollection.delegate = self
        view.addSubview(restaurantCollection)
        
        searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.placeholder = "Want a meme? Search for one!"
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.sizeToFit()
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.obscuresBackgroundDuringPresentation = false
        self.navigationItem.titleView = searchBar.searchBar
        //view.addSubview(searchBar)
        
        topTextField = UITextField()
        topTextField.text = "hellooooo"
        topTextField.clearsOnBeginEditing = true
        topTextField.borderStyle = .roundedRect
        topTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topTextField)
        
        bottomTextField = UITextField()
        bottomTextField.text = "byeee"
        bottomTextField.clearsOnBeginEditing = true
        bottomTextField.borderStyle = .roundedRect
        bottomTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomTextField)
        
        finishButton = UIButton()
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.setTitle("Finish", for: .normal)
        finishButton.addTarget(self, action: #selector(finishAction), for: .touchUpInside)
        view.addSubview(finishButton)
        
        memeImage = UIImageView()
        memeImage.image = UIImage(named: nameOfImage)
        memeImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(memeImage)
        
        setUpConstraints()
    }
    
    @objc func finishAction() {
        print(NetworkManger.userID)
        NetworkManger.create(userID: NetworkManger.userID, templateID: NetworkManger.templateID, text0: topTextField.text ?? " ", text1: bottomTextField.text ?? " ")
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            restaurantCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            restaurantCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            restaurantCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding*60),
            restaurantCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            topTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topTextField.topAnchor.constraint(equalTo: restaurantCollection.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            bottomTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomTextField.topAnchor.constraint(equalTo: topTextField.bottomAnchor, constant: 400)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.topAnchor.constraint(equalTo: bottomTextField.topAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            memeImage.topAnchor.constraint(equalTo: topTextField.bottomAnchor, constant: 30),
            memeImage.bottomAnchor.constraint(equalTo: bottomTextField.topAnchor, constant: -30),
            memeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            memeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            memeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func createRestaurants() {
        for i in 0..<NetworkManger.urlsTemps.count {
            //urlsTemps.append(Array(userData.data.values)[i]["url"]!)
            var newmeme = Meme(URL: NetworkManger.urlsTemps[i], imageID:"1", name: "meme", tID: NetworkManger.idTemps[i])
            searchResult.append(newmeme)
        }
    }
}

extension RestaurantViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: restaurantCellReuseIdentifier, for: indexPath) as! RestaurantCollectionViewCell
        cell.configure(for: searchResult[indexPath.row] )
        return cell
        
    }
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
        
    }
    
}

extension RestaurantViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //selectedRow = indexPath.row
        nameOfImage = searchResult[indexPath.row].URL
        NetworkManger.templateID = searchResult[indexPath.row].templateID
        let url = URL(string: nameOfImage)!
        let data = try? Data(contentsOf: url)
        memeImage.image = UIImage(data: data!)
    }
}

extension RestaurantViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            for i in 0..<NetworkManger.urlsTemps.count {
                //urlsTemps.append(Array(userData.data.values)[i]["url"]!)
                var newmeme = Meme(URL: NetworkManger.urlsTemps[i], imageID:"1", name: "meme", tID: NetworkManger.idTemps[i])
                searchResult.append(newmeme)
            }
                if !searchText.isEmpty {
                    NetworkManger.searchMemes(fromTitle: searchText)
                }
            restaurantCollection.reloadData()
            
        }
    }
}

//
//  SearchCollectionViewController.swift
//  MemeHackChallenge
//
//  Created by Claire Wang on 12/8/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
                if !searchText.isEmpty {
                    NetworkManger.searchMeme(fromTitle: searchText, { results in
                        DispatchQueue.main.async {
                            print(results)
                        }
                    })
            }
        }
    }
    
    var searchCollection: UICollectionView!
    let searchCellReuseIdentifier = "searchCellReuseIdentifier"
    
    override func viewDidLoad() {
        let searchLayout = UICollectionViewFlowLayout()
        searchLayout.scrollDirection = .vertical
        searchLayout.minimumLineSpacing = 10
        searchLayout.minimumInteritemSpacing = 10
        
        searchCollection = UICollectionView(frame: .zero, collectionViewLayout: searchLayout)
        searchCollection.backgroundColor = .white
        searchCollection.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: searchCellReuseIdentifier)
        searchCollection.translatesAutoresizingMaskIntoConstraints = false
        searchCollection.dataSource = self
        searchCollection.delegate = self
        view.addSubview(searchCollection)
        
        setUpConstraints()
    }

    func setUpConstraints() {
    let padding: CGFloat = 10
    NSLayoutConstraint.activate([
        searchCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding*5),
        searchCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        searchCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
        searchCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        searchCollection.heightAnchor.constraint(equalToConstant: 100)])
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}

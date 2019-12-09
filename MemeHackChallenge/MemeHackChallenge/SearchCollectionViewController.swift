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
    var searchResult: [Meme] = []
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
        searchCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)])
        //searchCollection.heightAnchor.constraint(equalToConstant: 100)])
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.config(for: searchResult[indexPath.row])
        return cell
    }
}

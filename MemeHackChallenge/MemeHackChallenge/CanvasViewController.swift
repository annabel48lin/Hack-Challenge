//
//  CanvasViewController.swift
//  MemeHackChallenge
//
//  Created by Natasha  on 12/6/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController { //, UICollectionViewDelegate, UICollectionViewDataSource, UISearchResultsUpdating {

    var memeImage: UIImageView!
    var topTextField: UITextField!
    var bottomTextField: UITextField!
    var finishButton: UIButton!
    var searchBar: UISearchController!
    
    var searchCollection: UICollectionView!
    var searchResult: [Meme] = [Meme(URL: "https://i.imgflip.com/3il2cu.jpg", imageID: "1", name: "Natasha")]
    let searchCellReuseIdentifier = "searchCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeImage = UIImageView()
        
        view.backgroundColor = .systemPink
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
        
//        searchBar = UISearchController(searchResultsController: nil)
//        searchBar.searchBar.placeholder = "Want a meme? Search for one!"
//        searchBar.searchResultsUpdater = self
//        searchBar.searchBar.sizeToFit()
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            searchCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)

        ])
        
        NSLayoutConstraint.activate([
            topTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topTextField.topAnchor.constraint(equalTo: searchCollection.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            bottomTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomTextField.topAnchor.constraint(equalTo: topTextField.bottomAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.topAnchor.constraint(equalTo: bottomTextField.topAnchor, constant: 40)
        ])
    }
    
    @objc func finishAction() {
        NetworkManger.create(userID: ViewController.userID, username: ViewController.username, password: ViewController.password)
        self.navigationController?.popViewController(animated: true)
    }
}

extension CanvasViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

extension CanvasViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: searchCellReuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.config(for: searchResult[indexPath.row])
        cell.backgroundColor = .blue
        //cell.delegate = self
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        searchCollection.reloadData()
//    }
  
}

extension CanvasViewController: UISearchResultsUpdating {
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
}

extension CanvasViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        searchCollection.reloadData()
    }
}

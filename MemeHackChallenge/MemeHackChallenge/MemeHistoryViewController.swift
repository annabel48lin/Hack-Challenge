//
//  MemeHistoryViewController.swift
//  MemeHackChallenge
//
//  Created by Claire Wang on 11/22/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class MemeHistoryViewController: UIViewController {
    
    var memeCollection: UICollectionView!
    let memeCellReuseIdentifier = "memeCellReuseIdentifier"
    var memeHistory: [Meme] = []
    var createButton: UIButton!
    var invalidName: UIAlertController!
    
    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeLayout = UICollectionViewFlowLayout()
        memeLayout.scrollDirection = .vertical
        memeLayout.minimumLineSpacing = padding
        memeLayout.minimumInteritemSpacing = padding
        
        memeCollection = UICollectionView(frame: .zero, collectionViewLayout: memeLayout)
        memeCollection.backgroundColor = .white
        memeCollection.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: memeCellReuseIdentifier)
        memeCollection.translatesAutoresizingMaskIntoConstraints = false
        memeCollection.dataSource = self
        memeCollection.delegate = self
        view.addSubview(memeCollection)
        
        createButton = UIButton()
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.setTitle("Create", for: .normal)
        createButton.addTarget(self, action: #selector(createAction), for: .touchUpInside)
        view.addSubview(createButton)
        
        invalidName = UIAlertController(title: "Invalid Input!", message: "Meme ID cannot be empty.", preferredStyle: .alert)
        
        
        createMemeHistory()
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            memeCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding*5),
            memeCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            memeCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            memeCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])

    }
    
    func createMemeHistory() {
        
        
        for i in 0..<NetworkManger.urlsTemps.count {
            //urlsTemps.append(Array(userData.data.values)[i]["url"]!)
            var newmeme = Meme(URL: NetworkManger.urlsTemps[i], imageID:"1", name: "meme", tID: NetworkManger.idTemps[i])
            memeHistory.append(newmeme)
        }
//
//        let url = URL(string: nameOfImage)!
//        let data = try? Data(contentsOf: url)
//        memeImage.image = UIImage(data: data!)

        
       // memeHistory = []
        memeCollection.reloadData()
    }
    
    @objc func createAction() {
        let canvasView = RestaurantViewController()
        navigationController?.pushViewController(canvasView, animated: true)
    }
    
    
    @objc func backgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension MemeHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memeCollection.dequeueReusableCell(withReuseIdentifier: memeCellReuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.config(for: memeHistory[indexPath.row])
        return cell
    }
}

extension MemeHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
}



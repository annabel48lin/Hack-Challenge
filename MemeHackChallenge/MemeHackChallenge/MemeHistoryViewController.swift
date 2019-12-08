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
    var memeHistory: [Meme]!
    
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
        
        createMemeHistory()
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            memeCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            memeCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            memeCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            memeCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func createMemeHistory() {
        
        /**
         At this point, our UICollectionView is completed but empty because we'll need to collaborate with the Backend to actually extract the image URL from the API
         */
        
        // let example: Meme = Meme(URL: "https://i.imgflip.com/1bij.jpg", imageID: "61579", name: "One Does Not Simply")
        // memeHistory = [example]
        
        memeHistory = []
    }
}

extension MemeHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memeCollection.dequeueReusableCell(withReuseIdentifier: memeCellReuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.configure(for: memeHistory[indexPath.row])
        return cell
    }
}

extension MemeHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
}



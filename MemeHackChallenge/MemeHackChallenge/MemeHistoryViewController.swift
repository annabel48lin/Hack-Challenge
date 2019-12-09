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
    var createButton: UIButton!
    var deleteButton: UIButton!
    var deleteTextField: UITextField!
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
        
        deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        view.addSubview(deleteButton)
        
        deleteTextField = UITextField()
        deleteTextField.text = "Meme ID"
        deleteTextField.clearsOnBeginEditing = true
        deleteTextField.borderStyle = .roundedRect
        deleteTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteTextField)
        
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
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        ])
        
        NSLayoutConstraint.activate([
            deleteTextField.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 10),
            deleteTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)
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
    
    @objc func createAction() {
        let canvasView = CanvasViewController()
        navigationController?.pushViewController(canvasView, animated: true)
    }
    
    @objc func deleteAction() {
        
        let d: String = deleteTextField.text ?? ""
        if d == "" {
            self.present(invalidName, animated: true) {
            self.invalidName.view.superview?.subviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped)))
            }
            return
        }
        NetworkManger.delete(memeID: 0, username: ViewController.username, password: ViewController.password, userID: ViewController.userID)
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



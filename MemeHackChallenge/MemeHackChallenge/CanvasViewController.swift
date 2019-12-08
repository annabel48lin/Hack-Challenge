//
//  CanvasViewController.swift
//  MemeHackChallenge
//
//  Created by Natasha  on 12/6/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    var memeImage: UIImageView!
    var topTextField: UITextField!
    var bottomTextField: UITextField!
    var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            topTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
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

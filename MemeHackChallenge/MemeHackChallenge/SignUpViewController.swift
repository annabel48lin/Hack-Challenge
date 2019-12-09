//
//  SignUpViewController.swift
//  MemeHackChallenge
//
//  Created by Claire Wang on 12/6/19.
//  Copyright © 2019 Claire Wang. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    var titleLabel: UILabel!
    var userNameLabel: UILabel!
    var passwordLabel: UILabel!
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var invalidName: UIAlertController!
    var success: UIAlertController!
    var failed: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 216/255.0, green: 249/255.0, blue: 255/255.0, alpha: 1)
        title = "Sign Up"

        titleLabel = UILabel()
        titleLabel.text = "Welcome!!"
        titleLabel.font = UIFont(name: "Zapfino", size: 40)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        userNameLabel = UILabel()
        userNameLabel.text = "Username:"
        userNameLabel.font = UIFont(name: "SavoyeLetPlain", size: 40)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        
        passwordLabel = UILabel()
        passwordLabel.text = "Password:"
        passwordLabel.font = UIFont(name: "SavoyeLetPlain", size: 40)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordLabel)
        
        userNameTextField = UITextField()
        userNameTextField.text = "Username"
        userNameTextField.backgroundColor = .white
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.font = UIFont(name: "Papyrus-Condensed", size: 28)
        userNameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        userNameTextField.clearsOnBeginEditing = true
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.text = "Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.font = UIFont(name: "Papyrus-Condensed", size: 28)
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.clearsOnBeginEditing = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.setTitle("Sign Up", for: .normal)
        loginButton.setTitleColor(.systemBlue, for: .normal)
        loginButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        loginButton.backgroundColor = .white
        loginButton.layer.borderColor = UIColor.systemBlue.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 5
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        loginButton.titleLabel?.font = UIFont(name: "SavoyeLetPlain", size: 40)
        loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        invalidName = UIAlertController(title: "Invalid Input!", message: "Username or password cannot be empty", preferredStyle: .alert)
        success = UIAlertController(title: "Account Created!", message: "Your account is created successfully!", preferredStyle: .alert)
        failed = UIAlertController(title: "Account Failed to Create!", message: "Your account was not created successfully due to existing username!", preferredStyle: .alert)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let offset: CGFloat = 30
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: offset),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: offset),
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: offset)
        ])
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: offset - 5),
            userNameTextField.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: offset),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: offset),
            passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: offset)
                ])
                
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: offset - 5),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor, constant: offset),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: offset * 3),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func loginAction() {
        let u: String = userNameTextField.text ?? ""
        let p: String = passwordTextField.text ?? ""
        if u == "" || p == "" {
            self.present(invalidName, animated: true) {
            self.invalidName.view.superview?.subviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped)))
            }
            return
        } else {
            NetworkManger.signup(username: u, password: p)
            
            print(NetworkManger.signUpResult)
            
            if NetworkManger.signUpResult == true {
               self.present(success, animated: true) { self.success.view.superview?.subviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapAndView)))
                }
            } else {
                self.present(failed, animated: true) { self.failed.view.superview?.subviews[0].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped)))
                }
            }
        }
    }
    
    @objc func backgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backgroundTapAndView() {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        //navigationController?.popToRootViewController(animated: true)
        //dismiss(animated: true, completion: nil)
    }
}

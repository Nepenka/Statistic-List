//
//  Registration.swift
//  StatsList
//
//  Created by 123 on 10.07.23.
//

import UIKit
import SnapKit
import CoreData

class RegistrationController: UIViewController, UITextFieldDelegate {
    
    let regButton: UIButton = .init()
    let nameField = PaddingTextField()
    let lastNameField = PaddingTextField()
    let loginField = PaddingTextField()
    let passwordField = PaddingTextField()
    let helloLabel = UILabel()
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        passwordField.delegate = self
        saveUser()
        
    }
    
    func saveUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = UserAccount(context: context)
        newUser.login = loginField.text ?? ""
        newUser.name = nameField.text ?? ""
        newUser.lastName = lastNameField.text ?? ""
        newUser.password = passwordField.text ?? ""
        
        do {
            try context.save()
            print("Пользователь удачно зарегистрирован")
        }catch{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let englishLetters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")
        
        for character in string {
            let scalar = String(character).unicodeScalars.first!
            
            if !englishLetters.contains(scalar) {
                return false
            }
        }
        
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.helloLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.nameField.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.lastNameField.alpha = 1.0
        }, completion: nil)
        
        
        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.loginField.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 2.5, delay: 0.5, options: .curveEaseInOut, animations: {
            self.passwordField.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 3.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.regButton.alpha = 1.0
        }, completion: nil)
        
        
        
    }
    func setupUI() {
        
        view.addSubview(helloLabel)
        helloLabel.text = "Welcome!"
        helloLabel.textAlignment = .left
        helloLabel.numberOfLines = 0
        helloLabel.font = UIFont(name: "Arial", size: 35)
        helloLabel.font = UIFont.boldSystemFont(ofSize: helloLabel.font.pointSize)
        helloLabel.alpha = 0.0
        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.left.equalTo(30)
        }
        
        view.addSubview(nameField)
        nameField.layer.borderColor = UIColor.black.cgColor
        nameField.placeholder = "Name"
        nameField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .footnote), size: 12)
        nameField.keyboardType = .default
        nameField.textColor = .black
        nameField.alpha = 0.0
        nameField.layer.borderWidth = 0.5
        nameField.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().inset(20)
            make.right.equalTo(-50)
            make.height.equalTo(30)
            
        }
        
        view.addSubview(lastNameField)
        lastNameField.layer.borderColor = UIColor.black.cgColor
        lastNameField.placeholder = "Last name"
        lastNameField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .footnote), size: 12)
        lastNameField.keyboardType = .default
        lastNameField.textColor = .black
        lastNameField.layer.borderWidth = 0.5
        lastNameField.alpha = 0.0
        lastNameField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
            make.right.equalTo(-50)
            make.height.equalTo(30)
            
        }
        
        view.addSubview(loginField)
        loginField.placeholder = "Login"
        loginField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .footnote), size: 12)
        loginField.keyboardType = .default
        loginField.textColor = .black
        loginField.layer.borderWidth = 0.5
        loginField.alpha = 0.0
        loginField.snp.makeConstraints { make in
            make.top.equalTo(lastNameField.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
            make.right.equalTo(-50)
            make.height.equalTo(30)
            
        }
        
        view.addSubview(passwordField)
        passwordField.placeholder = "Password"
        passwordField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .footnote), size: 12)
        passwordField.keyboardType = .emailAddress
        passwordField.textColor = .black
        passwordField.layer.borderWidth = 0.5
        passwordField.alpha = 0.0
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(20)
            make.right.equalTo(-50)
            make.height.equalTo(30)
            
        }
        view.addSubview(regButton)
        regButton.setTitle("Register", for: .normal)
        regButton.backgroundColor = .systemBlue
        regButton.layer.cornerRadius = 10
        regButton.alpha = 0.0
        regButton.titleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 16)
        regButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(100)
            make.top.equalTo(passwordField.snp.bottom).offset(45)
        }
        regButton.addTarget(self, action: #selector(regButtonAction), for: .touchUpInside)
        
    }
    @objc func regButtonAction() {
        guard let name = nameField.text, !name.isEmpty,
              let lastName = lastNameField.text, !lastName.isEmpty,
              let login = loginField.text, !login.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(message: "You must fill in all fields!")
            return
        }
        
        saveUser()
        
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("Кнопка нажата")
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


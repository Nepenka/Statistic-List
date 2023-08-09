import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    let button: UIButton = .init()
    let textField = PaddingTextField()
    let textFieldTwo = PaddingTextField()
    let secureButton: UIButton = .init()
    let signUpButton: UIButton = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        textFieldTwo.isSecureTextEntry = true
        secureButton.setBackgroundImage(UIImage(named: "eye.slash.png"), for: .normal)
        view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        checkUser(login: "", password: "")
    }
    
    func loginUser(login: String, password: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<UserAccount> = UserAccount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "login == %@ AND password == %@", login, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                print("Вход успешно выполнен \(user.name) \(user.lastName)!")
            } else {
                print("Данные не верны")
            }
        } catch {
            print("Ошибка при поиске пользователя \(error.localizedDescription)")
        }
    }
    
    func setupUI() {
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 16)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(320)
            make.right.left.equalToSuperview().inset(100)
        }
        
        view.addSubview(textField)
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Login"
        textField.keyboardType = .default
        textField.textColor = .systemBlue
        textField.layer.borderWidth = 0.5
        textField.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(50)
            make.top.equalToSuperview().inset(200)
            make.height.equalTo(30)
        }
        
        view.addSubview(textFieldTwo)
        textFieldTwo.layer.borderColor = UIColor.black.cgColor
        textFieldTwo.placeholder = "Password"
        textFieldTwo.keyboardType = .default
        textFieldTwo.textColor = .systemBlue
        textFieldTwo.layer.borderWidth = 0.5
        textFieldTwo.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.right.equalTo(-90)
            make.top.equalToSuperview().inset(250)
            make.height.equalTo(30)
        }
        
        view.addSubview(secureButton)
        secureButton.addTarget(self, action: #selector(secureButtonAction), for: .touchUpInside)
        secureButton.snp.makeConstraints { make in
            make.left.equalTo(textFieldTwo.snp.right).offset(10)
            make.centerY.equalTo(textFieldTwo)
            make.height.equalTo(textFieldTwo)
            make.width.equalTo(100)
            make.right.equalToSuperview().inset(40)
        }
        
        view.addSubview(signUpButton)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.layer.cornerRadius = 10
        signUpButton.titleLabel?.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .largeTitle), size: 16)
        signUpButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(100)
            make.top.equalTo(button.snp.bottom).offset(30)
        }
        signUpButton.addTarget(self, action: #selector(signButtAction), for: .touchUpInside)
    }
    
    @objc func signButtAction() {
        UIView.animate(withDuration: 0.4, animations: {
            self.signUpButton.backgroundColor = .systemGray2
        })
        UIView.animate(withDuration: 0.1, animations: {
            self.signUpButton.backgroundColor = .systemBlue
        })
        
        let registrationViewController = RegistrationController()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    @objc func secureButtonAction() {
        textFieldTwo.isSecureTextEntry = !textFieldTwo.isSecureTextEntry
        if !textFieldTwo.isSecureTextEntry {
            secureButton.setBackgroundImage(UIImage(named: "eye.png"), for: .normal)
        } else if textFieldTwo.isSecureTextEntry {
            secureButton.setBackgroundImage(UIImage(named: "eye.slash.png"), for: .normal)
        }
    }
    
    @objc func buttonAction() {
        UIView.animate(withDuration: 0.4, animations: {
            self.button.backgroundColor = .systemGray2
        })
        UIView.animate(withDuration: 0.1, animations: {
            self.button.backgroundColor = .systemBlue
        })
        
        guard let login = textField.text, !login.isEmpty,
              let password = textFieldTwo.text, !password.isEmpty else {
            return
        }
        
        if let user = checkUser(login: login, password: password) {
            let secondViewController = SecondViewController()
            navigationController?.pushViewController(secondViewController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Invalid login or password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func checkUser(login: String, password: String) -> UserAccount? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<UserAccount> = UserAccount.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "login == %@ AND password == %@", login, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Ошибка при поиске пользователя \(error.localizedDescription)")
            return nil
        }
    }
}


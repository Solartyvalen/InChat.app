//
//  LoginController.swift
//  InChat
//
//  Created by Mac on 24.09.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: UIImage(imageLiteralResourceName: "logo10"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 50))
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return view
    }()
     
    private let emailTextField = UITextField.setupTextField(placeholder: "Email...", hideText: false)
    private let passwordTextField = UITextField.setupTextField(placeholder: "Password...", hideText: true)
    private let loginButton = UIButton.setupButton(title: "Login", color: UIColor.rgb(red: 149, green: 204, blue: 244))
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        // First part of Button
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.lightGray])
        // Second part of button
        attributedTitle.append(NSAttributedString(string: "Sing IN", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .heavy), .foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Handlers
    
    @objc fileprivate func goToSignUp() {
        let signUpController = SignUpController()
      //  navigationController?.pushViewController(signUpController, animated: true)
      //  present(signUpController, animated: true)
        let navController = UINavigationController(rootViewController: signUpController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        setupTapGesture()
        
        handlers()
        
    }
    
    fileprivate func handlers() {
        emailTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc fileprivate func handleLogin() {
        
        guard let email = emailTextField.text  else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print("Failed to login with error:", err.localizedDescription)
                return
            }
            
            print("Succesfuly signed user in")
            
           //DispatchQueue.main.async {
          //let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow}).first
                
          //if let maintabVC = keyWindow?.rootViewController as? MainTabVC {
         // maintabVC.configure()
        //}
                
         //self.dismiss(animated: true)
        //}

        let mainTabVC = MainTabVC()
        mainTabVC.modalPresentationStyle = .fullScreen
        self.present(mainTabVC, animated: true, completion: nil)
            
        }
    }
    
    @objc fileprivate func formValidation() {
        guard
            emailTextField.hasText,
            passwordTextField.hasText
        else {
            self.loginButton.isEnabled = false
            self.loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
                 return
        }
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    private func configureViewComponents() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 180))
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 10, right: 40))
    }
    
    //MARK: - Keyboard
    fileprivate func setupTapGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.removeObserver(self)    }
}

//
//  SignUpController.swift
//  InChat
//
//  Created by Mac on 24.09.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase




class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    //   fileprivate let plusPhotoButoon: UIButton = {
    //       let button = UIButton(type: .system)
    //       button.setImage(UIImage(imageLiteralResourceName: "plus_photo"), for: .normal)
    //       return button
    var imageSelected = false
    
    fileprivate let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.rgb(red: 149, green: 204, blue: 244).cgColor
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return button
    }()
    @objc fileprivate func selectPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    fileprivate let emailTextField = UITextField.setupTextField(placeholder: "Email...", hideText: false)
    fileprivate let fullNameTextField = UITextField.setupTextField(placeholder: "Full name...", hideText: false)
    fileprivate let userNameTextField = UITextField.setupTextField(placeholder: "User name...", hideText: false)
    fileprivate let passwordTextField = UITextField.setupTextField(placeholder: "Password...", hideText: true)
    fileprivate let signUpButton = UIButton.setupButton(title: "Sign UP", color: UIColor.rgb(red: 149, green: 204, blue: 244))
    
    
   fileprivate let alredyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        // First part of Button
        let attributedTitle = NSMutableAttributedString(string: "Alredy have an account?  ", attributes: [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.lightGray])
        // Second part of button
        attributedTitle.append(NSAttributedString(string: "Sing UP", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .heavy), .foregroundColor: UIColor.rgb(red: 17, green: 154, blue: 237)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(goToSignIN), for: .touchUpInside)
        return button
    }()
    
    
    @objc fileprivate func goToSignIN() {
        //        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
        
        setupNotificationObserver()
        setupTapGesture()
        hadleres()
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UIImagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
        imageSelected = true
        
        selectPhotoButton.layer.cornerRadius = selectPhotoButton.frame.width / 2
        selectPhotoButton.layer.masksToBounds = true
        selectPhotoButton.layer.backgroundColor = UIColor.black.cgColor
        selectPhotoButton.layer.borderWidth = 2
        selectPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Handlers
    
    fileprivate func hadleres() {
        emailTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
    }
    
    @objc fileprivate func handleSignUp() {
        self.handleTapDismiss()
        
        guard let email = emailTextField.text?.lowercased() else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        guard let username = userNameTextField.text?.lowercased() else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            print("Пользователь успешно создан")
            
            guard let profileImage = self.selectPhotoButton.imageView?.image else {return}
            guard let uploadData = profileImage.jpegData(compressionQuality: 0.3) else {return}
            
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_image").child(filename)
            
            storageRef.putData(uploadData, metadata: nil) {(_, err) in
                if let err = err {
                    print("Не удалось загрузить фотографию")
                    return
                }
                print("Загрузка прошла успешно")
                
                storageRef.downloadURL { (downLoadUrl, err ) in
                    guard let profileImageUrl = downLoadUrl?.absoluteString else {return}
                    if let err = err {
                    print("Profile image is nil", err.localizedDescription)
                    return
                  }
                    print("Eспешно получена ссылка на картинку")
                    
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    
                    let docData = ["uid": uid, "name": fullName, "username": username, "profileImageUrl": profileImageUrl]
                    
                    Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
                        if let err = err {
                            print("Falied", err.localizedDescription)
                            return
                        }
                        
                        print("Данные успешно сохранены")
                    }
                }
            }
        }
    }
    
    @objc fileprivate func formValidation() {
        guard
            emailTextField.hasText,
            fullNameTextField.hasText,
            userNameTextField.hasText,
            passwordTextField.hasText,
            imageSelected == true else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            return
        }
        
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [
        emailTextField,
        fullNameTextField,
        userNameTextField,
        passwordTextField,
        signUpButton
])
    
    fileprivate func configureViewComponents() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), size: .init(width: 250, height: 250))
        
        selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectPhotoButton.layer.cornerRadius = 250 / 2
        

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.anchor(top: selectPhotoButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 250))
        
        view.addSubview(alredyHaveAccountButton)
        alredyHaveAccountButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 40, bottom: 10, right: 40))
    }
    
    // MARK: - Keyboard
    
    fileprivate func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = value.cgRectValue
        print(notification)
        
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 10)
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.transform = .identity
        }
    }
    
    fileprivate func setupTapGesture(){
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        view.endEditing(true)
    }
}

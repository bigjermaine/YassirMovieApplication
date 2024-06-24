//
//  SettingsViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit

class SettingsViewController: UIViewController {
    enum PicturePickerType {
        case camera
        case photoLibrary
    }
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal)
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 32
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.backgroundColor =  .red
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let  settingSeachImageView : UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        backgroundSetup()
        addSubviews()
        configureHomeAvatar()
        configureAction()
        setUpGif()
    }
    override func viewWillAppear(_ animated: Bool) {
        HapticManager.shared.vibrateForSelection()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let screenWidth = UIScreen.main.bounds.width
        avatarImageView.frame = CGRect(x: (screenWidth - 64) / 2, y: view.safeAreaInsets.top + 10, width: 64, height: 64)
        logoutButton.frame = CGRect(x:20, y:avatarImageView.bottom + 40, width: 90, height:50)
        settingSeachImageView.frame = CGRect(x: (screenWidth - 64) / 2, y: logoutButton.bottom + 20, width: 100, height: 100)
    }
    private func setUpGif() {
        settingSeachImageView.image = UIImage.gifImageWithName("checking")
    }
    private func configureAction() {
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }
    
    @objc  func didTapLogout() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            // User confirmed logout
            let welcomeViewController = OnboardingViewController()
            let navController = welcomeViewController
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                let window = sceneDelegate.window {
                window.rootViewController = navController
            }
        }))

        // Assuming your initial view controller is a UINavigationController
        navigationController?.present(alert, animated: true, completion: nil)
    
       }
    private func configureHomeAvatar() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
    }
    private func backgroundSetup() {
        title = "Profile"
        view.backgroundColor =  .white
     }
    private func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(logoutButton)
        view.addSubview(settingSeachImageView)
    }
    
    @objc  func didTapAvatar() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _  in
            DispatchQueue.main.async {
                self.presentProfilePicturePicker(type: .camera)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.presentProfilePicturePicker(type: .photoLibrary)
            }
        }))

        present(actionSheet, animated: true)
    }
    private   func presentProfilePicturePicker(type: PicturePickerType) {
        let picker = UIImagePickerController()
        picker.sourceType = type == .camera ? .camera : .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate  {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.avatarImageView.image = image
    }
    
    
}


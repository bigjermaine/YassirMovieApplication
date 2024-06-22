//
//  ViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    private let  onboardingImageView : UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tonHomeImage")
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let onboardingLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome To The Home Of Movies"
        label.font = .italicSystemFont(ofSize: 28)
        label.clipsToBounds = true
        return label
    }()
    
    
    private let  createNewWalletButton:UIButton = {
        let button = UIButton()
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        button.titleLabel?.font = label.font
        button.setTitle("Click To Explore", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        configureBackgroundController()
        addSubviews()
        addSubviews()
        setUpGif()
        configureConstriansts()
    }
    func configureBackgroundController() {
        view.backgroundColor = .white
    }
    func addSubviews() {
        view.addSubview(onboardingImageView)
        view.addSubview(onboardingLabel)
        view.addSubview(createNewWalletButton)
    }
    func setUpGif() {
        onboardingImageView .image = UIImage.gifImageWithName("unboarding")
    }
    
    func configureConstriansts() {
        NSLayoutConstraint.activate([
            onboardingImageView.centerYAnchor.constraint(equalTo:  view.centerYAnchor,constant: -40),
            onboardingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingImageView.widthAnchor.constraint(equalToConstant: 124),
            onboardingImageView.heightAnchor.constraint(equalToConstant: 124),
            ])
        NSLayoutConstraint.activate([
            onboardingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingLabel.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 10),
            onboardingLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -40),
            ])
        
        NSLayoutConstraint.activate([
            createNewWalletButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createNewWalletButton.topAnchor.constraint(equalTo: onboardingLabel.bottomAnchor, constant: 20),
            createNewWalletButton.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -40),
            createNewWalletButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    
    }
}


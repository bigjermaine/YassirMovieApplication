//
//  DescriptiveViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import UIKit
import SDWebImage
import WebKit
import JGProgressHUD

class DescriptiveViewController: UIViewController {
    private let spinner = JGProgressHUD(style:.light)
    
    private let  noVideoImageView : UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let scrollView: UIScrollView = {
          let scrollView = UIScrollView()
          scrollView.translatesAutoresizingMaskIntoConstraints = false
         scrollView.isScrollEnabled = true
          return scrollView
      }()
    
    
    private let webView:WKWebView = {
        let webview  = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
        
    }()
    
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptiveLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.clipsToBounds = true
        return label
    }()
    
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.clipsToBounds = true
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.clipsToBounds = true
        return label
    }()
    private let favouriteButton:UIButton = {
        let button = UIButton()
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        button.titleLabel?.font = label.font
        button.setTitle("Add To Favourite", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layoutIfNeeded()
        return button
    }()
    
    var result:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureBackgroundController()
        addSubviews()
        configureConstriants()
        configureData()
        configureAction()
    }
    private func configureAction() {
        favouriteButton.addTarget(self, action: #selector(<#T##@objc method#>), for: <#T##UIControl.Event#>)
        
    }
    private func configureData() {
        noVideoImageView.image = UIImage.gifImageWithName("created")
        fetchYoutubeDetails()
        guard let result = result else {return}
        titleLabel.text = result.title
        subTitleLabel.text = result.releaseDate
        descriptiveLabel.text = result.overview
        guard let backdropPath = result.backdropPath else {return}
        guard let url = URL(string: "\(Constants.imageBaseUrl)\(backdropPath)") else {return}
        movieImageView.sd_setImage(with: url)
        
    }
    
    private func fetchYoutubeDetails() {
        spinner.detailTextLabel.text = "please wait...."
        spinner.show(in: view)
        ApiManager.shared.getYoutubeTrailer(with: ((result?.originalTitle ?? result?.title) ?? "") + "trailer") { [ weak self ] result in
            switch result {
            case.success(let videoelement):
                DispatchQueue.main.async {
                    self?.noVideoImageView.isHidden = true
                    guard let url = URL(string:"https://www.youtube.com/embed/\(videoelement.id.videoId)") else {return}
                    self?.webView.load(URLRequest(url: url))
                    self?.spinner.dismiss()
                }
            case .failure(let error):
                self?.spinner.dismiss()
                self?.noVideoImageView.isHidden = false
            }
        }
    }
    
    private  func configureBackgroundController() {
        view.backgroundColor = .white
        title = "Movie Details"
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(movieImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(descriptiveLabel)
        scrollView.addSubview(webView)
        scrollView.addSubview(noVideoImageView)
        scrollView.addSubview(favouriteButton)
        
    }
    
    private func configureConstriants() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            movieImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant:300),
            movieImageView.widthAnchor.constraint(equalTo:view.widthAnchor,constant: -20),
            movieImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor,constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor,constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor,constant: -20),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20),
            subTitleLabel.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: 10),
            subTitleLabel.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor,constant: -10),
            subTitleLabel.bottomAnchor.constraint(equalTo: descriptiveLabel.topAnchor,constant: -20),
            
            
            
            descriptiveLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor,constant: 20),
            descriptiveLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor,constant: 10),
            descriptiveLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor,constant: -10),
            descriptiveLabel.bottomAnchor.constraint(equalTo: webView.topAnchor,constant: -10),
            
            webView.topAnchor.constraint(equalTo: descriptiveLabel.bottomAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            webView.heightAnchor.constraint(equalToConstant: 250),
            
            
            noVideoImageView.topAnchor.constraint(equalTo: descriptiveLabel.bottomAnchor, constant: 10),
            noVideoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noVideoImageView.widthAnchor.constraint(equalToConstant: 100),
            noVideoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            
            
            
            favouriteButton.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            favouriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            favouriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50),
            favouriteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -10),
            
            
            
            
        ])
    }
    
    
    
}

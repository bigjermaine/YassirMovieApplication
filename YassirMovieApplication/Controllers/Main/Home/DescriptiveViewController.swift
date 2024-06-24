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
        button.setTitle("Add To Favourite", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.layoutIfNeeded()
        return button
    }()
    
    private let firstReviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let reviewTitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reviews"
        label.clipsToBounds = true
        return label
    }()
    
    private let firstReviewLabel : UILabel = {
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
    private let SeocndReviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "")
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var result:Movie?
    var checkFavoriteBool:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureBackgroundController()
        addSubviews()
        configureConstriants()
        configureData()
        configureAction()
        checkIfMovieIsFavourite()
    }
    private func configureAction() {
        favouriteButton.addTarget(self, action: #selector(didTapToFavouriteMovie), for: .touchUpInside)
        
    }
    private func checkIfMovieIsFavourite() {
        guard let result = result else {
            checkFavoriteBool = false
            favouriteButton.setTitle("Add To Favourite", for: .normal)
            favouriteButton.backgroundColor = .systemYellow
            return
        }
        
        let downloadedMovies = UserDefaults().downloadedMovies()
        
        if let index = downloadedMovies.firstIndex(where: { $0.id == result.id }) {
            // Movie is found in downloadedMovies, mark as favorite
            checkFavoriteBool = true
            favouriteButton.setTitle("Part Of Your Favourites⭐️", for: .normal)
            favouriteButton.backgroundColor = .systemBlue
        } else {
            // Movie is not found in downloadedMovies, mark as not favorite
            checkFavoriteBool = false
            favouriteButton.setTitle("Add To Favourite", for: .normal)
            favouriteButton.backgroundColor = .systemYellow
        }
    }

   @objc func didTapToFavouriteMovie() {
       if checkFavoriteBool {
           guard let result = result else {return}
           UserDefaults().deleteMovie(movie: result)
           checkIfMovieIsFavourite()
           
       }else{
           guard let result = result else {return}
           UserDefaults().downloadMovie(movie: result)
           tabBarController?.viewControllers?[1].tabBarItem.badgeValue = "New"
           checkIfMovieIsFavourite()
       }
    }
    private func configureData() {
        noVideoImageView.image = UIImage.gifImageWithName("created")
    
        guard let result = result else {return}
        titleLabel.text = result.title
        subTitleLabel.text = result.releaseDate
        descriptiveLabel.text = result.overview
        guard let backdropPath = result.backdropPath else {return}
        guard let url = URL(string: "\(Constants.imageBaseUrl)\(backdropPath)") else {return}
        movieImageView.sd_setImage(with: url)
        fetchYoutubeDetails()
        
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
                guard let self =  self else {return}
                Alert.showBasic(title: "Error", message: error.localizedDescription, vc: self)
                self.noVideoImageView.isHidden = false
                self.spinner.dismiss()
            }
        }
        guard let result = result else {return}
        ApiManager.shared.getReviewsMovies(movieID: result.id ) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {[weak self] in
                    guard let success = success.first else {return}
                    self?.firstReviewLabel.text = success.content
                    guard let imagePath  = success.author_details.avatar_path  else {return}
                    guard let url = URL(string: "\(Constants.imageBaseUrl)\(imagePath)") else {return}
                    self?.firstReviewImageView.sd_setImage(with: url)
                }
            case .failure(let failure):
                Alert.showBasic(title: "Error", message: failure.localizedDescription, vc: self)
                self.spinner.dismiss()
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
        scrollView.addSubview(reviewTitleLabel)
        scrollView.addSubview(firstReviewImageView)
        scrollView.addSubview(firstReviewLabel)
        
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
            
            webView.topAnchor.constraint(equalTo: descriptiveLabel.bottomAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            webView.heightAnchor.constraint(equalToConstant: 250),
            
            
            noVideoImageView.topAnchor.constraint(equalTo: descriptiveLabel.bottomAnchor, constant: 20),
            noVideoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noVideoImageView.widthAnchor.constraint(equalToConstant: 100),
            noVideoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            
            
            
            favouriteButton.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            favouriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            favouriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50),
         //   favouriteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20),
            
            
            reviewTitleLabel.topAnchor.constraint(equalTo: favouriteButton.bottomAnchor, constant: 10),
            reviewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            reviewTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            
            
            
            
            firstReviewImageView.topAnchor.constraint(equalTo: reviewTitleLabel.bottomAnchor, constant: 10),
            firstReviewImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            firstReviewImageView.heightAnchor.constraint(equalToConstant: 50),
            firstReviewImageView.widthAnchor.constraint(equalToConstant: 50),
            
            
            firstReviewLabel.topAnchor.constraint(equalTo: reviewTitleLabel.bottomAnchor, constant: 10),
            firstReviewLabel.leadingAnchor.constraint(equalTo: firstReviewImageView.trailingAnchor,constant: 10),
            firstReviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            firstReviewLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20),
        
        ])
    }
    
    
    
}

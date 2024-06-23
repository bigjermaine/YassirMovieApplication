//
//  DescriptiveViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import UIKit
import SDWebImage
class DescriptiveViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
          let scrollView = UIScrollView()
          scrollView.translatesAutoresizingMaskIntoConstraints = false
         scrollView.isScrollEnabled = true
          return scrollView
      }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "2")
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
        label.text = "To Address To Address To Address To Address To Address To Address  To Address To Address To Address"
        label.clipsToBounds = true
        return label
    }()
    
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To To Address To Address To Address To Address"
        label.clipsToBounds = true
        return label
    }()
    
    private let subTitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1994"
        label.clipsToBounds = true
        return label
    }()
    
    private var result:Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureBackgroundController()
        addSubviews()
        configureConstriants()
        configureData()
      }
    private func configureData() {
        guard let result = result else {return}
        titleLabel.text = result.title
        subTitleLabel.text = result.releaseDate
        descriptiveLabel.text = result.overview
        guard let backdropPath = result.backdropPath else {return}
        guard let url = URL(string: "\(Constants.imageBaseUrl)\(backdropPath)") else {return}
        movieImageView.sd_setImage(with: url)
    }
    
   private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(movieImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(descriptiveLabel)
        
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
             descriptiveLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
         
     ])
    }
    private  func configureBackgroundController() {
        view.backgroundColor = .white
        title = "Movie Detials"
     }
   

}

//
//  DescriptiveViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 23/06/2024.
//

import UIKit

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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptiveLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .poppinsRegular(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To Address"
        label.clipsToBounds = true
        return label
    }()
    
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .poppinsRegular(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To Address"
        label.clipsToBounds = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureBackgroundController()
        addSubviews()
      }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(movieImageView)
    }
    
     func configureConstriants() {
         NSLayoutConstraint.activate([
             scrollView.topAnchor.constraint(equalTo: view.topAnchor),
             scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             
             movieImageView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 100),
             movieImageView.heightAnchor.constraint(equalToConstant: 100),
             movieImageView.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor,constant: 10),
             movieImageView.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor,constant: -10),
         
     ])
    }
     func configureBackgroundController() {
        view.backgroundColor = .white
        title = "Movie Detials"
     }
   

}

//
//  HomeTableViewCell.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit
import SDWebImage
class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
   private let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
   }()
    private let subMovielabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
   public let bookMarkButton: UIButton = {
           let button = UIButton()
           button.setImage(UIImage(systemName: "star.fill"), for: .normal)
           button.tintColor = .systemBlue
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addContentView()
        configureLayout()
    }
    

    private  func addContentView() {
        contentView.addSubview(movieLabel)
        contentView.addSubview(subMovielabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(bookMarkButton)
        
    }
    private  func configureLayout() {
         NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
             
            movieLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            movieLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            movieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieLabel.bottomAnchor.constraint(equalTo: subMovielabel.topAnchor,constant: -10),
            
            subMovielabel.topAnchor.constraint(equalTo: movieLabel.bottomAnchor,constant: 5),
            subMovielabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            subMovielabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
           // subMovielabel.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            
            bookMarkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            bookMarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookMarkButton.heightAnchor.constraint(equalToConstant: 20),
            bookMarkButton.widthAnchor.constraint(equalToConstant: 20)
         
            ])
            }
    
 public  func configure(viewModel:Movie) {
        movieLabel.text = viewModel.title
        subMovielabel.text = viewModel.releaseDate
        guard let backdropPath = viewModel.backdropPath else {return}
        guard let url = URL(string: "\(Constants.imageBaseUrl)\(backdropPath)") else {return}
        movieImageView.sd_setImage(with: url)
        
        let downloadedMovies = UserDefaults().downloadedMovies()
        
        if let index = downloadedMovies.firstIndex(where: { $0.id == viewModel.id }) {
            bookMarkButton.isHidden = false
        } else {
            bookMarkButton.isHidden = true
        }
        
    }

}

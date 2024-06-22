//
//  HomeTableViewCell.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "jamitCoinIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
   private let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
       label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The Coming TRON"
        return label
   }()
    private let subMovielabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1994"
        return label
    }()
    
    private let bookMarkButton: UIButton = {
        let button = UIButton()
        button.setTitle("B", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .systemFont(ofSize: 12)
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
        addContentView()
        configureLayout()
    }
    

    func addContentView() {
        contentView.addSubview(movieLabel)
        contentView.addSubview(subMovielabel)
        contentView.addSubview(movieImageView)
        contentView.addSubview(bookMarkButton)
        
    }
     func configureLayout() {
         NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieImageView.widthAnchor.constraint(equalToConstant: 50),
            movieImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor,constant: -20),
             
            movieLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor,constant: 10),
            movieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
          
            subMovielabel.topAnchor.constraint(equalTo: subMovielabel.bottomAnchor,constant: 10),
            subMovielabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subMovielabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
          
            
            bookMarkButton.bottomAnchor.constraint(equalTo: subMovielabel.bottomAnchor,constant: 10),
            bookMarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookMarkButton.heightAnchor.constraint(equalToConstant: 20),
            bookMarkButton.widthAnchor.constraint(equalToConstant: 20)
         
            ])
            }

}

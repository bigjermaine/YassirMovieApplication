//
//  FavoriteViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private let discoverMoviesTableView:UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.backgroundColor =  .white
        return tableView
    }()
    
    
    private let  noFavouritesImageView : UIImageView  = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private var results:[Movie] = UserDefaults().downloadedMovies()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureBackgroundController()
        addSuview()
        configureConstraints()
        configureTableDelegate()
        setUpGif()
        makeBadgeNil()
       
      
    }
    override func viewDidAppear(_ animated: Bool) {
        results = UserDefaults().downloadedMovies()
       
        discoverMoviesTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HapticManager.shared.vibrateForSelection()
    }
    private func setUpGif() {
        noFavouritesImageView.image = UIImage.gifImageWithName("password")
    }
    private func makeBadgeNil() {
        tabBarController?.tabBar.items?[0].badgeValue = nil
    }
    private func addSuview() {
        view.addSubview(discoverMoviesTableView)
        view.addSubview(noFavouritesImageView)
    }
    private func configureConstraints() {
        discoverMoviesTableView.frame = view.bounds
        let imageViewWidth: CGFloat = 200
        let xPosition = (view.frame.width - imageViewWidth)/2
        noFavouritesImageView.frame = CGRect(x: xPosition, y: 120, width: imageViewWidth, height: imageViewWidth)
    }
    private  func configureTableDelegate() {
        discoverMoviesTableView.delegate = self
        discoverMoviesTableView.dataSource = self
    }
    private func configureBackgroundController() {
        view.backgroundColor = .white
        discoverMoviesTableView.backgroundColor = .white
        title = "Favourites Movies"
    }
   

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if results.count > 0 {
            noFavouritesImageView.layer.opacity = 0
        }else{
            noFavouritesImageView.layer.opacity = 1
        }
        return results.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else
            {return UITableViewCell()}
         let result = results[indexPath.row]
        cell.configure(viewModel: result)
        cell.bookMarkButton.isHidden = true
            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                results.remove(at: indexPath.row)
                discoverMoviesTableView.deleteRows(at: [indexPath], with: .automatic)
                UserDefaults().deleteMovie(at: indexPath.row)
                discoverMoviesTableView.reloadData()
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = results[indexPath.row]
        HapticManager.shared.vibrateForSelection()
        let vc = DescriptiveViewController()
        vc.result = result
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
    }
}

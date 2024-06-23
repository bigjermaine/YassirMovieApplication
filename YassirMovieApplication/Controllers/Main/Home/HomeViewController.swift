//
//  HomeViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit

class HomeViewController: UIViewController {
    

    private let tableView:UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.backgroundColor =  .white
        return tableView
    }()
    
    private var results:[Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureBackgroundController()
        addSuview()
        configureConstraints()
        configureTableDelegate()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        HapticManager.shared.vibrateForSelection()
    }
   private func newWorkFetch() {
        ApiManager.shared.getDiscoverMovies {[weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.results = success
                }
            case .failure(let failure):
                guard let self =  self else {return}
                Alert.showBasic(title: "Error", message: "try again later", vc: self)
            }
        }
       
    }
    private func addSuview() {
        view.addSubview(tableView)
    }
    private func configureConstraints() {
        tableView.frame = view.bounds
    }
    private  func configureTableDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func configureBackgroundController() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        title = "Movies"
    }
   

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else
            {return UITableViewCell()}
            cell.bookMarkButton.isHidden = true
            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DescriptiveViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

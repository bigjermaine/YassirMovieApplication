//
//  HomeViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit
import JGProgressHUD
class HomeViewController: UIViewController {
    private let refreshControl = UIRefreshControl()
    private let spinner = JGProgressHUD(style:.light)
    private let discoverMoviesTableView:UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.backgroundColor =  .white
        return tableView
    }()
    var fetchBool = true
    private var results:[Movie] = []
    var totalPage =  1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureBackgroundController()
        addSuview()
        configureConstraints()
        configureTableDelegate()
        newWorkFetch()
        configureActions()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        HapticManager.shared.vibrateForSelection()
    }
    private  func configureActions() {
        refreshControl.addTarget(self, action: #selector(newWorkFetch), for: .valueChanged)
        discoverMoviesTableView.refreshControl = refreshControl
    }
    
    @objc private func newWorkFetch() {
        spinner.detailTextLabel.text = "please wait...."
        spinner.show(in: view)
        ApiManager.shared.getDiscoverMovies(page:totalPage) {[weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    if success.isEmpty {
                        self?.fetchBool = false
                    }
                  
                    self?.results.append(contentsOf: success)
                    self?.discoverMoviesTableView.reloadData()
                    self?.spinner.dismiss()
                    self?.discoverMoviesTableView.refreshControl?.endRefreshing()
                }
              case .failure(let error):
                guard let self =  self else {return}
                Alert.showBasic(title: "Error", message: error.localizedDescription, vc: self)
                self.spinner.dismiss()
                self.discoverMoviesTableView.refreshControl?.endRefreshing()
            }
        }
       
    }
    private func addSuview() {
        view.addSubview(discoverMoviesTableView)
    }
    private func configureConstraints() {
        discoverMoviesTableView.frame = view.bounds
    }
    private  func configureTableDelegate() {
        discoverMoviesTableView.delegate = self
        discoverMoviesTableView.dataSource = self
    }
    private func configureBackgroundController() {
        view.backgroundColor = .white
        discoverMoviesTableView.backgroundColor = .white
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
        let result = results[indexPath.row]
        cell.configure(viewModel: result)
        return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == results.count - 1 && fetchBool {
            totalPage += 1
            newWorkFetch()
        }
    }
    
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = results[indexPath.row]
        HapticManager.shared.vibrateForSelection()
        let vc = DescriptiveViewController()
        vc.result = result
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

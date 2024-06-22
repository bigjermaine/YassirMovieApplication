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
        tableView.register( self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.backgroundColor =  .white
        tableView.allowsSelection = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureBackgroundController()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        HapticManager.shared.vibrateForSelection()
    }
    func configureTableView() {
        
    }
    func addSuview() {}
    func configureBackgroundController() {
        view.backgroundColor = .white
    }
   

}

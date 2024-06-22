//
//  MaintTabbarViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit

class MaintTabbarViewController: UITabBarController {
    let Vc1 =  HomeViewController()
    let Vc2 =  FavoriteViewController()
    let Vc3 =  SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureSetupTabbarViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HapticManager.shared.vibrateForSelection()
    }
     func configureSetupTabbarViewController() {
      
         Vc1.navigationItem.largeTitleDisplayMode = .never
         Vc2.navigationItem.largeTitleDisplayMode = .never
         Vc3.navigationItem.largeTitleDisplayMode = .never
       
       
         let nav1 = UINavigationController(rootViewController: Vc1)
         let nav2 = UINavigationController(rootViewController: Vc2)
         let nav3 = UINavigationController(rootViewController: Vc3)
     
      
         
         nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "movieclapper"), tag: 0)
         nav2.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "star.fill"), tag: 1)
         nav3.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
       
         
         nav1.navigationBar.backgroundColor = .clear
         nav1.navigationBar.setBackgroundImage(UIImage(), for: .default)
         nav1.navigationBar.shadowImage = UIImage()
         setViewControllers([nav1,nav2,nav3], animated: false)

     }
     
}

//
//  SettingsViewController.swift
//  YassirMovieApplication
//
//  Created by MacBook AIR on 22/06/2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    override func viewWillAppear(_ animated: Bool) {
        HapticManager.shared.vibrateForSelection()
    }

}

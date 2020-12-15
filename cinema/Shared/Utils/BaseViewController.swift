//
//  BaseViewController.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 30/10/20.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = true
    }
}

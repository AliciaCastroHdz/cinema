//
//  SplashViewController.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 09/12/20.
//

import UIKit

class SplashViewController: BaseViewController {
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = MovieMenuViewController(nibName: "MovieMenuViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

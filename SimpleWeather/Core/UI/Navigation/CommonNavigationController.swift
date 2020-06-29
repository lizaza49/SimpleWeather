//
//  CommonNavigationController.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import UIKit

class CommonNavigationController: CustomTransitioningNavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        view.backgroundColor = UIColor.white
        view.frame = UIScreen.main.bounds
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.white
    }
}


//
//  AppDelegateRouter.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import UIKit

protocol AppDelegateRouterProtocol {
	func pushToRoot(_ vc: UIViewController)
	func presentCities()
}

final class AppDelegateRouter: AppDelegateRouterProtocol {

	private let window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	static var shared: AppDelegateRouterProtocol {
		return (UIApplication.shared.delegate as? AppDelegate)!.viewModel.router
	}

    func pushToRoot(_ vc: UIViewController) {
        (window.rootViewController as? UINavigationController)?.pushViewController(vc, animated: true)
    }

	func presentCities() {
		let builder = CitiesBuilder()
		let citiesVC = builder.build()
		setRootViewController(with: citiesVC)
	}

    private func setRootViewController(with vc: UIViewController) {
        let navigationController =  CommonNavigationController(rootViewController: vc)
		navigationController.transitionManager = SmoothSlideTransitionManager()
        window.rootViewController = navigationController
    }
}

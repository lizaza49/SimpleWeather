//
//  AppDelegateViewModel.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import UIKit

protocol AppDelegateViewModelProtocol {
	var router: AppDelegateRouterProtocol { get }
	func onFinishLaunching(with options: [UIApplication.LaunchOptionsKey: Any]?)
	func onAppDidBecomeActive()
}

final class AppDelegateViewModel: NSObject, AppDelegateViewModelProtocol {
	let router: AppDelegateRouterProtocol

	init(router: AppDelegateRouterProtocol) {
		self.router = router
	}

	func onFinishLaunching(with options: [UIApplication.LaunchOptionsKey: Any]?) {

		performRouting()
    }

	func onAppDidBecomeActive() {
	}

    private func performRouting() {
       self.router.presentCities()
    }
}

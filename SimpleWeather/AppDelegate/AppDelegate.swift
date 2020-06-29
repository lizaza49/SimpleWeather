//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 27.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let navigationController = UINavigationController()
	lazy var viewModel: AppDelegateViewModelProtocol = {
		let router = AppDelegateRouter(window: window!)
		return AppDelegateViewModel(router: router)
	}()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let screenSize = UIScreen.main.bounds
		self.window = UIWindow(frame: screenSize)
		self.window?.backgroundColor = UIColor.white
		self.window?.makeKeyAndVisible()
		viewModel.onFinishLaunching(with: launchOptions)
		return true
	}
}


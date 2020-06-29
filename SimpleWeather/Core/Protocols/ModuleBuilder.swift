//
//  ModuleBuilder.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import UIKit

public protocol ModuleBuilder: class {
	init()

	func build() -> UIViewController
}

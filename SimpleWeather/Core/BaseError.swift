//
//  BaseError.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation

public protocol ErrorProtocol: Error {
	var description: String { get }
}

class BaseError: ErrorProtocol {
	let description: String

	init(description: String) {
		self.description = description
	}
}

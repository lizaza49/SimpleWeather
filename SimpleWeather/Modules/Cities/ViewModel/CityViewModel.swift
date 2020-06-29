//
//  CityViewModel.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation

protocol CityViewModelProtocol {
	var name: String { get }
	var country: String { get }
	var latitude: Double { get }
	var longitude: Double { get }
}

struct CityViewModel: CityViewModelProtocol {
	var name: String
	var country: String
	var latitude: Double
	var longitude: Double

	init(model: CityModel) {
		self.name = model.name
		self.country = model.country
		self.latitude = model.latitude
		self.longitude = model.longitude
	}
}

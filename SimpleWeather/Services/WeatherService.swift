//
//  WeatherService.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public protocol WeatherServiceProtocol {
	func getData(cityQuery: String, completionHandler:@escaping (WeatherModel?, WeatherErrorResponce?) -> Void)
}

final class WeatherService {

	public init() {
		
	}

	func getData(cityQuery: String, completionHandler:@escaping (WeatherModel?, WeatherErrorResponce?) -> Void) {

		AF.request(ForecastRouter.getForecast(query: cityQuery))
			.validate(statusCode: [200])
			.responseJSON { (response) in
				switch response.result {
				case .success(let value):
					let forecasts = Mapper<WeatherModel>().map(JSONObject: value)
					completionHandler(forecasts, nil)
					
				case .failure(let error):
					let errorResponce = Mapper<WeatherErrorResponce>().map(JSONObject: error)
					completionHandler(nil, errorResponce)
			}
		}
	}
}

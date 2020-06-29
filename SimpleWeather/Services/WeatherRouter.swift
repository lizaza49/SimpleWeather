//
//  WeatherRouter.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum ForecastRouter: URLRequestConvertible {

	struct Constants {
		static let weatherUrl = "https://api.openweathermap.org"
		static let weatherApikey = "bb79c694c97b9f4b5fdf15c1dbc40aaf"
	}
    //it can be possible to add other requests
    case getForecast(query: String)

    public var BaseURL: URL {
        return URL(string: Constants.weatherUrl)!
    }

    var method: HTTPMethod {
        switch self {
        case .getForecast:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getForecast:
            return "/data/2.5/forecast"
        }
    }

    var parameters: Parameters {
        switch self {
        case .getForecast(let query):
            return ["APPID": Constants.weatherApikey,
                    "q": query,
                    "mode": "json",
                    "units": "metric"]
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try self.BaseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getForecast:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: self.parameters)
        }
        return urlRequest
    }
}

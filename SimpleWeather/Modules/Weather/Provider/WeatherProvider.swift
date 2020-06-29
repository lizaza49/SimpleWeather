//
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import Foundation

protocol WeatherProviderProtocol {
	func fetchData(cityQuery: String, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

class WeatherProvider: WeatherProviderProtocol {

	private let service = WeatherService()

	func fetchData(cityQuery: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
		service.getData(cityQuery: cityQuery) { result, error  in
			if let result = result {
				completion(.success(result))
			}
			if let error = error {
				completion(.failure(BaseError(description: error.localizedDescription)))
			}
		}
	}
}

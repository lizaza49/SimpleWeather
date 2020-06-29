//
//  Weather module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

enum Weather {

	enum BaseLogic {
		struct Response {
			var result: Result<WeatherModel, BaseError>
		}

		struct ViewModel {
			var state: State
		}
	}

	enum State {
		case result(WeatherViewModel)
		case error(message: String)
		case loading
		case stopLoading
	}
}

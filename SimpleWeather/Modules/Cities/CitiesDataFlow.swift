//
//  Cities module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

enum Cities {

	enum BaseLogic {
		struct Response {
			var result: Result<[CityModel], BaseError>
		}

		struct ViewModel {
			var state: State
		}
	}

	enum State {
		case result([CityViewModelProtocol])
		case error(message: String)
		case loading
		case stopLoading
	}
}

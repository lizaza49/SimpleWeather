//
//  Weather module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit

protocol WeatherPresentLogic {
	func presentModel(response: Weather.BaseLogic.Response)
	func showLoadingIndicator()
	func hideLoadingIndicator()
}

final class WeatherPresenter: WeatherPresentLogic {

	weak var viewController: WeatherViewLogic?

// MARK: -

	func presentModel(response: Weather.BaseLogic.Response) {
		switch response.result {
		case let .failure(error):
			viewController?.display(viewState: .error(message: error.localizedDescription))

		case let .success(result):
			viewController?.display(viewState: .result(WeatherViewModel(model: result)))
		}
	}

	func showLoadingIndicator() {
		viewController?.display(viewState: .loading)
	}

	func hideLoadingIndicator() {
		viewController?.display(viewState: .stopLoading)
	}
}

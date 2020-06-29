//
//  Cities module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit

protocol CitiesPresentLogic {
	func present(response: Cities.BaseLogic.Response)
	func showLoadingIndicator()
	func hideLoadingIndicator()
}

final class CitiesPresenter: CitiesPresentLogic {

	weak var viewController: CitiesViewLogic?

	// MARK: -

	func present(response: Cities.BaseLogic.Response) {
		switch response.result {
		case let .failure(error):
			viewController?.display(viewState: .error(message: error.localizedDescription))

		case let .success(result):
			let viewModels: [CityViewModelProtocol] = result.map() { city in
				return CityViewModel(model: city)
			}
			viewController?.display(viewState: .result(viewModels))
		}
	}

	func showLoadingIndicator() {
		viewController?.display(viewState: .loading)
	}

	func hideLoadingIndicator() {
		viewController?.display(viewState: .stopLoading)
	}
}

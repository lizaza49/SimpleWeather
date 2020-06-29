//
//  Weather module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

protocol WeatherBusinessLogic {
	func initialState()
}

final class WeatherInteractor: WeatherBusinessLogic {
	private let presenter: WeatherPresentLogic
	private let provider: WeatherProviderProtocol
	private let cityViewModel: CityViewModelProtocol

	init(presenter: WeatherPresentLogic, provider: WeatherProviderProtocol = WeatherProvider(), config: WeatherBuilder.Config) {
		self.presenter = presenter
		self.provider = provider
		self.cityViewModel = config.cityViewModel
	}

	// MARK: -

	func initialState() {
		presenter.showLoadingIndicator()
		provider.fetchData(cityQuery: cityViewModel.name) { [weak self] (result) in
			guard let self = self else { return }
			switch result {
			case let .success(model):
				self.presenter.presentModel(response: Weather.BaseLogic.Response(result: .success(model)))
			case let .failure(error):
				self.presenter.presentModel(response: Weather.BaseLogic.Response(result: .failure(BaseError(description: error.localizedDescription))))
			}
			self.presenter.hideLoadingIndicator()
		}
	}
}

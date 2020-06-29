//
//  Weather module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit

class WeatherBuilder: ModuleBuilder {
	struct Config {
		let cityViewModel: CityViewModelProtocol
	}

	private let config: Config

	init(config: Config) {
		self.config = config
	}

	required init() {
		fatalError("init() is not implemented. Use init(:Config)")
	}

	func build() -> UIViewController {
		let presenter = WeatherPresenter()
		let interactor = WeatherInteractor(presenter: presenter, config: config)
		let controller = WeatherViewController(interactor: interactor, title: config.cityViewModel.name)

		presenter.viewController = controller
		return controller
	}
}

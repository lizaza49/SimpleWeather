//
//  Cities module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit

class CitiesBuilder: ModuleBuilder {

	required init() {
	}

	func build() -> UIViewController {
		let presenter = CitiesPresenter()
		let interactor = CitiesInteractor(presenter: presenter)
		let controller = CitiesViewController(interactor: interactor)

		presenter.viewController = controller
		return controller
	}
}

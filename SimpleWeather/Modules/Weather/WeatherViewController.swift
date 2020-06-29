//
//  Weather module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit

// MARK: - WeatherViewLogic

protocol WeatherViewLogic: class {
	func display(viewState: Weather.State)
}

// MARK: - WeatherViewController

class WeatherViewController: UIViewController {

	// MARK: Private variables

	let cityTitle: String
	private var customView: WeatherView { return view as! WeatherView }
	private let interactor: WeatherBusinessLogic

	// MARK: Inits

	init(interactor: WeatherBusinessLogic, title: String) {
		self.interactor = interactor
		self.cityTitle = title
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
	}

	// MARK: View lifecycle

	override func loadView() {
		view = WeatherView(frame: UIScreen.main.bounds)
		self.navigationItem.title = cityTitle
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		interactor.initialState()
	}
}

// MARK: - Weather implementation

extension WeatherViewController: WeatherViewLogic {

	func display(viewState: Weather.State) {
		switch viewState {
		case .loading:
			print("loading...")
		case .stopLoading:
			print("stop loading...")
		case let .error(message):
			print("error \(message)")
		case let .result(model):
			print("result: \(model)")
			customView.configureCollectionView(weather: model)
		}
	}
}

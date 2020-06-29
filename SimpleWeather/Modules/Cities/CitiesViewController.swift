//
//  Cities module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit

// MARK: - CitiesViewLogic

protocol CitiesViewLogic: class {
	func display(viewState: Cities.State)
}

// MARK: - CitiesViewController

final class CitiesViewController: UIViewController {

	// MARK: Private variables

	private var customView: CitiesView { return view as! CitiesView }
	private let interactor: CitiesBusinessLogic

	// MARK: Inits

	init(interactor: CitiesBusinessLogic) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View lifecycle

	override func loadView() {
		view = CitiesView(frame: UIScreen.main.bounds)
		customView.delegate = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		interactor.initialState()
	}
}

// MARK: - Cities implementation

extension CitiesViewController: CitiesViewLogic {

	func display(viewState: Cities.State) {
		switch viewState {
		case .loading:
			print("loading...")
		case .stopLoading:
			print("stop loading...")
		case let .error(message):
			print("error \(message)")
		case let .result(model):
			print("result: \(model)")
			customView.configureCollectionView(cities: model)
		}
	}
}

extension CitiesViewController: CitiesViewDelegate {
	func onSelect(_ city: CityViewModelProtocol) {
		let config = WeatherBuilder.Config(cityViewModel: city)
		let builder = WeatherBuilder(config: config)
		let vc = builder.build()
		//TODO: make AppNavigationManager
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

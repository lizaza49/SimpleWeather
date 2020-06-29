//
//  Cities module
//  Created by Elizaveta Alekseeva on 28/06/2020.
//
import RxSwift

protocol CitiesBusinessLogic {
	func initialState()
}

final class CitiesInteractor: CitiesBusinessLogic {
	private let presenter: CitiesPresentLogic
	private let provider: CitiesProviderProtocol

	private let bag = DisposeBag()

	init(presenter: CitiesPresentLogic, provider: CitiesProviderProtocol = CitiesProvider()) {
		self.presenter = presenter
		self.provider = provider
		self.setupBindings()

	}

	// MARK: - CitiesBusinessLogic

	func initialState() {
		presenter.showLoadingIndicator()
		provider.fetchDataAndSave()
	}

	// MARK: - Private function

	private func setupBindings() {
		//TODO: add normal realm wrapper, Rx+Realm just for fun. Rewrite with completion closures
		provider.responce
			.asObservable()
			.observeOn(MainScheduler.instance)
			.skip(1).subscribe(onNext: { [weak self] responce in
			if let self = self {
				self.presenter.hideLoadingIndicator()
				self.presenter.present(response: responce)
			}
		}).disposed(by: bag)
	}
}

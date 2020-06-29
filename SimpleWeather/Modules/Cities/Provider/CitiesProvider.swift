//
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

protocol CitiesProviderProtocol {
	func fetchDataAndSave()
	var responce: PublishSubject<Cities.BaseLogic.Response> { get }
}

class CitiesProvider: CitiesProviderProtocol {

	var responce = PublishSubject<Cities.BaseLogic.Response>()

	private let bag = DisposeBag()

	init() {
		setupBindings()
	}

	func fetchDataAndSave() {
		DispatchQueue.init(label: "com.concurrent.realm", attributes: .concurrent).async { [unowned self] in
			if let cities = JSONFileReader().getArray(from: JSONFiles.cities, type: CityModel.self) {
				let realm = try! Realm()
				do {
					try realm.write {
						realm.add(cities)
					}
				}
				catch let error {
					self.responce.onNext(Cities.BaseLogic.Response(result: .failure(BaseError(description: "error saving to realm: \(error.localizedDescription)"))))
				}
			}
			else {
				self.responce.onNext(Cities.BaseLogic.Response(result: .failure(BaseError(description: "error read from json"))))
			}
		}
	}

	private func setupBindings() {
		//TODO: add normal realm wrapper, Rx+Realm just for fun. Rewrite with completion closures
		let realm = try! Realm()
		try! realm.write {
			realm.deleteAll()
		}
		let cities = realm.objects(CityModel.self)

		//synchronousStart required, look https://github.com/RxSwiftCommunity/RxRealm/issues/113
		Observable.array(from: cities, synchronousStart: false)
			.observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
			.subscribe(onNext: { [unowned self] results in
				self.responce.onNext(Cities.BaseLogic.Response(result: .success(results)))
			})
			.disposed(by: bag)
	}
}

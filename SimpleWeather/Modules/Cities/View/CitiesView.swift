//
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit
import SnapKit
import IVCollectionKit

protocol CitiesViewDelegate {
	func onSelect(_ city: CityViewModelProtocol)
}

extension CitiesView {
	struct Appearance {
		let exampleOffset: CGFloat = 10
	}
}

class CitiesView: UIView {
	let appearance = Appearance()
	var delegate: CitiesViewDelegate?

	fileprivate(set) lazy var customView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		return view
	}()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
		collection.alwaysBounceVertical = true
		collection.backgroundColor = UIColor.clear
		return collection
    }()

    lazy var director = CollectionDirector(colletionView: collectionView)
	let citiesSection = CollectionSection()

	override init(frame: CGRect = CGRect.zero) {
		super.init(frame: frame)
		addSubviews()
		makeConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func addSubviews(){
		addSubview(customView)
		customView.addSubview(collectionView)
	}

	func makeConstraints() {
		customView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}

		collectionView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
	}

	func configureCollectionView(cities: [CityViewModelProtocol]) {
        performCollectionViewConfiguration(with: cities)
        director.reload()
    }

    // Configures sections and adds them to the director

    private func performCollectionViewConfiguration(with cities: [CityViewModelProtocol]) {

        configureCitiesSection(with: cities)
        director+=citiesSection
    }

	private func configureCitiesSection(with cities: [CityViewModelProtocol]) {
		citiesSection.removeAll()
		for city in cities {
			let cityItem = CollectionItem<CityCollectionCell>(item: city)
			cityItem.onSelect = { _ in
				self.delegate?.onSelect(city)
			}
			citiesSection += cityItem
		}
	}
}

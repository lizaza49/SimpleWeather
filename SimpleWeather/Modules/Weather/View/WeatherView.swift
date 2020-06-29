//
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import UIKit
import IVCollectionKit

extension WeatherView {
	struct Appearance {
		static let loadingFont: UIFont = UIFont.systemFont(ofSize: 18)
		static let loadingColor: UIColor = .lightGray
	}
}

class WeatherView: UIView {
	let appearance = Appearance()

	private let loadingLabel = UILabel()

	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collection = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
		collection.isScrollEnabled = true
		collection.alwaysBounceVertical = true
		collection.backgroundColor = UIColor.clear
		return collection
	}()

	lazy var director = CollectionDirector(colletionView: collectionView)
	let weatherSection = CollectionSection()

	override init(frame: CGRect = CGRect.zero) {
		super.init(frame: frame)
		addSubviews()
		makeConstraints()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func addSubviews(){
		addSubview(collectionView)
	}

	func makeConstraints() {
		func makeConstraints() {

			collectionView.snp.makeConstraints { (make) in
				make.edges.equalToSuperview()
			}
		}
	}

	func configureCollectionView(weather: WeatherViewModel) {
		performCollectionViewConfiguration(with: weather)
		director.reload()
	}

	// Configures sections and adds them to the director

	private func performCollectionViewConfiguration(with weather: WeatherViewModel) {

		configureWeatherSection(with: weather)
		director+=weatherSection
	}

	private func configureWeatherSection(with weather: WeatherViewModel) {
		weatherSection.removeAll()
		for forecast in weather.forecasts {
			let cityItem = CollectionItem<WeatherCollectionCell>(item: forecast)
			weatherSection += cityItem
		}
	}
}

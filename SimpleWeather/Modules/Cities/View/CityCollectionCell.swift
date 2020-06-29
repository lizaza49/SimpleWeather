//
//  CityCollectionCell.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import IVCollectionKit
import UIKit

final class CityCollectionCell: UICollectionViewCell {

	private let cityLabel = UILabel()
	private let counryLabel = UILabel()
	private let separator = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)

		clipsToBounds = true

		cityLabel.font = UIConstants.cityFont
		cityLabel.textColor = UIConstants.cityTextColor
		cityLabel.textAlignment = .left
		addSubview(cityLabel)
		cityLabel.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(UIConstants.horizontalSpacing)
			make.top.equalTo(UIConstants.verticalSpacing)
		}

		counryLabel.font = UIConstants.countryFont
		counryLabel.textColor = UIConstants.countryColor
		counryLabel.textAlignment = .left
		addSubview(counryLabel)
		counryLabel.snp.makeConstraints { (make) in
			make.leading.trailing.equalTo(UIConstants.horizontalSpacing)
			make.bottom.equalTo(-UIConstants.verticalSpacing)
		}

		separator.backgroundColor = UIConstants.separatorColor.withAlphaComponent(0.2)
		addSubview(separator)
		separator.snp.makeConstraints { (make) in
			make.leading.equalTo(UIConstants.horizontalSpacing)
			make.trailing.equalToSuperview()
			make.height.equalTo(1)
			make.bottom.equalTo(0)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension CityCollectionCell : ConfigurableCollectionItem {

	static func estimatedSize(item: CityViewModelProtocol?, boundingSize: CGSize) -> CGSize {
		return CGSize(width: boundingSize.width, height: 70)
	}

	func configure(item: CityViewModelProtocol) {
		cityLabel.text = item.name
		counryLabel.text = item.country
	}
}

extension CityCollectionCell {
	struct UIConstants {
		static let horizontalSpacing: CGFloat = 16
		static let verticalSpacing: CGFloat = 16
		static let cityFont: UIFont = UIFont.systemFont(ofSize: 16)
		static let cityTextColor: UIColor = .black
		static let countryFont: UIFont = UIFont.systemFont(ofSize: 12)
		static let countryColor: UIColor = .lightGray
		static let separatorColor: UIColor = .lightGray
	}
}

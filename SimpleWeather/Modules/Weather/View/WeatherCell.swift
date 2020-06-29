//
//  WeatherCell.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 29.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation
import IVCollectionKit
import UIKit
import SDWebImage

final class WeatherCollectionCell: UICollectionViewCell {

	private var weatherImage = UIImageView()
	private let pressureLabel = UILabel()
	private let tempLabel = UILabel()
	private let weatherLabel = UILabel()
	private let dateLabel = UILabel()
	private let separator = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)

		clipsToBounds = true


		weatherImage.contentMode = .scaleAspectFit
		addSubview(weatherImage)
		weatherImage.snp.makeConstraints { (make) in
			make.leading.equalTo(UIConstants.horizontalSpacing)
			make.centerY.equalToSuperview()
			make.width.height.equalTo(UIConstants.imageSide)
		}

		weatherLabel.font = UIConstants.weatherFont
		weatherLabel.textColor = UIConstants.weatherColor
		weatherLabel.textAlignment = .left
		addSubview(weatherLabel)
		weatherLabel.snp.makeConstraints { (make) in
			make.left.equalTo(weatherImage.snp.right).offset(UIConstants.horizontalSpacing)
			make.top.equalTo(UIConstants.verticalSpacing/2)
		}

		dateLabel.font = UIConstants.dateFont
		dateLabel.textColor = UIConstants.dateTextColor
		dateLabel.textAlignment = .left
		addSubview(dateLabel)

		dateLabel.snp.makeConstraints { (make) in
			make.left.equalTo(weatherImage.snp.right).offset(UIConstants.horizontalSpacing)
			make.top.equalTo(weatherLabel.snp.bottom).offset(UIConstants.verticalSpacing/2)
		}

		tempLabel.font = UIConstants.dateFont
		tempLabel.textColor = UIConstants.dateTextColor
		tempLabel.textAlignment = .left
		addSubview(tempLabel)

		tempLabel.snp.makeConstraints { (make) in
			make.left.equalTo(weatherImage.snp.right).offset(UIConstants.horizontalSpacing)
			make.top.equalTo(dateLabel.snp.bottom).offset(UIConstants.verticalSpacing/2)
		}

		pressureLabel.font = UIConstants.dateFont
		pressureLabel.textColor = UIConstants.dateTextColor
		pressureLabel.textAlignment = .left
		addSubview(pressureLabel)

		pressureLabel.snp.makeConstraints { (make) in
			make.left.equalTo(weatherImage.snp.right).offset(UIConstants.horizontalSpacing)
			make.top.equalTo(tempLabel.snp.bottom).offset(UIConstants.verticalSpacing/2)
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

extension WeatherCollectionCell : ConfigurableCollectionItem {

	static func estimatedSize(item: ForecastModelProtocol?, boundingSize: CGSize) -> CGSize {
		return CGSize(width: boundingSize.width, height: 132)
	}

	func configure(item: ForecastModelProtocol) {
		if let imageLink = item.imageLink {
		weatherImage.sd_setImage(with: URL(string: imageLink), completed: nil)
		}
		weatherLabel.text = item.name
		dateLabel.text = item.dateText
		if let temp = item.temp {
           tempLabel.text = "\((temp)) °C"
        }
		if let pressure = item.pressure {
            pressureLabel.text = "\(pressure) Pa"
        }
	}
}

extension WeatherCollectionCell {
	struct UIConstants {
		static let horizontalSpacing: CGFloat = 16
		static let verticalSpacing: CGFloat = 16
		static let imageSide: CGFloat = 64
		static let dateFont: UIFont = UIFont.systemFont(ofSize: 16)
		static let dateTextColor: UIColor = .black
		static let weatherFont: UIFont = UIFont.systemFont(ofSize: 18)
		static let weatherColor: UIColor = .lightGray
		static let separatorColor: UIColor = .lightGray
	}
}


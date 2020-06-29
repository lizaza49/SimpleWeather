//
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

struct WeatherViewModel {
	let forecasts: [ForecastViewModel]

	init(model: WeatherModel) {
		self.forecasts = model.forecasts?.map() { forecast in
			return ForecastViewModel(model: forecast)
			} ?? []
	}
}

protocol ForecastModelProtocol {
	var name: String { get }
	var dateText: String? { get }
	var imageLink: String? { get }
	var pressure: Float? { get }
	var temp: Float? { get }
}

struct ForecastViewModel: ForecastModelProtocol {

	struct Constants {
		static let weatherIconsUrl = "https://openweathermap.org/img/w/"
	}

	var name: String
	var dateText: String?
	var imageLink: String?
	var pressure: Float?
	var temp: Float?

	init(model: Forecast) {
		self.name = model.weather?[0].description ?? ""
		self.dateText = model.dateText
		if let image =  model.weather?[0].icon {
			self.imageLink = Constants.weatherIconsUrl + "\(image).png"
		}
		self.pressure = model.pressure
		self.temp = model.temp
	}
}

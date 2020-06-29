//
//  Created by Elizaveta Alekseeva on 28/06/2020.
//
import Foundation
import ObjectMapper

public class WeatherModel: Mappable {
    var forecasts: [Forecast]?

    public required init?(map: Map) {
    }

    public func mapping(map: Map) {
        forecasts <- map["list"]
    }
}

public class Forecast: Mappable {

    var weather: [ForecastDetails]?
    var pressure: Float?
    var humidity: Int?
    var temp: Float?
    var wind: Float?
    var clouds: Int?
    var dateText: String?

	required public init?(map: Map) {
    }

	public func mapping(map: Map) {
        weather <- map["weather"]
        pressure <- map["main.pressure"]
        humidity <- map["main.humidity"]
        temp <- map["main.temp"]
        wind <- map["wind.speed"]
        clouds <- map["clouds.all"]
        dateText <- map["dt_txt"]
    }
}

public class ForecastDetails: Mappable {
    var main: String?
    var description: String?
    var icon: String?

    public required init?(map: Map) {

    }

    public func mapping(map: Map) {
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

public class WeatherErrorResponce: Mappable, Error {

    var errorCode: String?
    var errorMessage: String?

	required public init?(map: Map) {
    }

	public func mapping(map: Map) {
        errorCode <- map["cod"]
        errorMessage <- map["message"]
    }
}

//
//  Created by Elizaveta Alekseeva on 28/06/2020.
//

import RealmSwift

@objcMembers
final class CityModel: Object, Decodable {
	dynamic var id: Int = 0
	dynamic var name: String = ""
	dynamic var country: String = ""
	dynamic var latitude: Double = 0.0
	dynamic var longitude: Double = 0.0

	private enum CitiesCodingKeys: String, CodingKey {
		case id
		case name
		case country
		case latitude
		case longitude
	}

	convenience init(_ id: Int,
					 _ name: String,
					 _ country: String,
					 _ latitude: Double,
					 _ longitude: Double) {
		self.init()
		self.id = id
		self.name = name
		self.country = country
		self.latitude = latitude
		self.longitude = longitude
	}

	convenience required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CitiesCodingKeys.self)
		let id = try container.decode(Int.self, forKey: .id)
		let name = try container.decode(String.self, forKey: .name)
		let country = try container.decode(String.self, forKey: .country)
		let latitude = try container.decode(Double.self, forKey: .latitude)
		let longitude = try container.decode(Double.self, forKey: .longitude)
		self.init(id, name, country, latitude, longitude)
	}
}

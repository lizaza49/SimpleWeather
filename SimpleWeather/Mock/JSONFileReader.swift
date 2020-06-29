//
//  JSONFileReader.swift
//  SimpleWeather
//
//  Created by Elizaveta Alekseeva on 28.06.2020.
//  Copyright © 2020 Elizaveta Alekseeva. All rights reserved.
//

import Foundation

enum JSONFiles: String {
	case cities = "cities"

}

protocol JSONFileReaderProtocol {
	func getArray<T: Decodable>(from file: JSONFiles, type: T.Type) -> [T]?
	func getObject<T: Decodable>(from file: JSONFiles, type: T.Type) -> T?
}

class JSONFileReader: JSONFileReaderProtocol {
	func getArray<T: Decodable>(from file: JSONFiles, type: T.Type) -> [T]? {
		guard
			let path = Bundle.main.path(forResource: file.rawValue, ofType: "json"),
			let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
			let array = try? JSONDecoder().decode(Array<T>.self, from: data) else {
				return nil
		}

		return array
	}

	func getObject<T: Decodable>(from file: JSONFiles, type: T.Type) -> T? {
		guard
			let path = Bundle.main.path(forResource: file.rawValue, ofType: "json"),
			let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped),
			let object = try? JSONDecoder().decode(T.self, from: data) else {
				return nil
		}

		return object
	}
}


import Foundation

struct WeatherObject : Codable {
	let code : String?
	let message : Double?
	let cnt : Int?
	let list : [List]?
	let city : City?

	enum CodingKeys: String, CodingKey {

		case code = "cod"
		case message = "message"
		case cnt = "cnt"
		case list = "list"
		case city = "city"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		message = try values.decodeIfPresent(Double.self, forKey: .message)
		cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
		list = try values.decodeIfPresent([List].self, forKey: .list)
		city = try values.decodeIfPresent(City.self, forKey: .city)
	}

}

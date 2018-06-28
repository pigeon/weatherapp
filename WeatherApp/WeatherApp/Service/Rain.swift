

import Foundation
struct Rain : Codable {
	let w3h : Double?

	enum CodingKeys: String, CodingKey {

		case w3h = "3h"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		w3h = try values.decodeIfPresent(Double.self, forKey: .w3h)
	}

}


import Foundation
struct Wind: Codable {
    let speed: Double?
    let deg: Double?

    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try values.decodeIfPresent(Double.self, forKey: .deg)
    }
}

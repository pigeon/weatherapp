

import Foundation
struct Main: Codable {
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let sea_level: Double?
    let grnd_level: Double?
    let humidity: Int?
    let temp_kf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case temp_min
        case temp_max
        case pressure
        case sea_level
        case grnd_level
        case humidity
        case temp_kf
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
        temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
        pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
        sea_level = try values.decodeIfPresent(Double.self, forKey: .sea_level)
        grnd_level = try values.decodeIfPresent(Double.self, forKey: .grnd_level)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        temp_kf = try values.decodeIfPresent(Double.self, forKey: .temp_kf)
    }
}

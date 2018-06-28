
import Foundation
struct Sys: Codable {
    let pod: String?

    enum CodingKeys: String, CodingKey {
        case pod
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pod = try values.decodeIfPresent(String.self, forKey: .pod)
    }
}

struct City: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let population: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case population
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
    }
}

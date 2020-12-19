struct List: Codable {
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let dt_txt: String?

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case dt_txt
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt)
    }
}

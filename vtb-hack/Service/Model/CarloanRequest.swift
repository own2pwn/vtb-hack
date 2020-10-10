import Foundation

struct CarloanRequest: Codable {
    let comment: String
    let customerParty: CustomerParty
    let datetime: String
    let interestRate: Double
    let requestedAmount, requestedTerm: Int
    let tradeMark: String
    let vehicleCost: Int

    enum CodingKeys: String, CodingKey {
        case comment
        case customerParty = "customer_party"
        case datetime
        case interestRate = "interest_rate"
        case requestedAmount = "requested_amount"
        case requestedTerm = "requested_term"
        case tradeMark = "trade_mark"
        case vehicleCost = "vehicle_cost"
    }
}

extension CarloanRequest {
    // MARK: - CustomerParty

    struct CustomerParty: Codable {
        let email: String
        let incomeAmount: Int
        let person: Person
        let phone: String

        enum CodingKeys: String, CodingKey {
            case email
            case incomeAmount = "income_amount"
            case person, phone
        }
    }

    // MARK: - Person

    struct Person: Codable {
        let birthDateTime, birthPlace, familyName, firstName: String
        let gender, middleName, nationalityCountryCode: String

        enum CodingKeys: String, CodingKey {
            case birthDateTime = "birth_date_time"
            case birthPlace = "birth_place"
            case familyName = "family_name"
            case firstName = "first_name"
            case gender
            case middleName = "middle_name"
            case nationalityCountryCode = "nationality_country_code"
        }
    }
}

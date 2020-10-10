import Foundation

struct CalcSettingsResponse: Codable {
    let name, language: String
    let programs: [String]
    let clientTypes: [String]
    let specialConditions: [SpecialCondition]
    let variant: Variant
    let cost, initialFee: Int
    let openInNewTab: Bool
    let anchor: String?
    let kaskoDefaultValue: Int?
}

extension CalcSettingsResponse {
    // MARK: - SpecialCondition

    struct SpecialCondition: Codable {
        let name, language: String
        let excludingConditions: [String]
        let id: String
        let isChecked: Bool
    }

    // MARK: - Variant

    struct Variant: Codable {
        let id, name, language: String
    }
}

import Foundation

struct CalcCalculateRequest: Codable {
    let clientTypes: [String]
    let cost, initialFee, kaskoValue: Int
    let language: String
    let residualPayment: Double
    let settingsName: String
    let specialConditions: [String]
    let term: Int
}

// MARK: - CalcCalculateResponse

struct CalcCalculateResponse: Codable {
    let program: Program
    let ranges: Ranges
    let result: Result
}

extension CalcCalculateResponse {
    struct Program: Codable {
        let cost: Cost
        let id, programName, programURL, requestURL: String

        enum CodingKeys: String, CodingKey {
            case cost, id, programName
            case programURL = "programUrl"
            case requestURL = "requestUrl"
        }
    }

    // MARK: - Cost

    struct Cost: Codable {
        let filled: Bool
        let max, min: Int
    }

    // MARK: - Ranges

    struct Ranges: Codable {
        let cost, initialFee, residualPayment, term: Cost
    }

    // MARK: - Result

    struct Result: Codable {
        let contractRate: Double
        let kaskoCost: Int
        let lastPayment: Double
        let loanAmount, payment: Int
        let subsidy: Double
        let term: Int
    }
}

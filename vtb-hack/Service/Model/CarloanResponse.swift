import Foundation

struct CarloanResponse: Codable {
    let datetime: String
    let application: Application
}

extension CarloanResponse {
    // MARK: - Application

    struct Application: Codable {
        let vtbClientID: Int
        let decisionReport: DecisionReport

        enum CodingKeys: String, CodingKey {
            case vtbClientID = "VTB_client_ID"
            case decisionReport = "decision_report"
        }
    }

    // MARK: - DecisionReport

    struct DecisionReport: Codable {
        let applicationStatus, decisionDate, decisionEndDate, comment: String
        let monthlyPayment: Double

        enum CodingKeys: String, CodingKey {
            case applicationStatus = "application_status"
            case decisionDate = "decision_date"
            case decisionEndDate = "decision_end_date"
            case comment
            case monthlyPayment = "monthly_payment"
        }
    }
}

import Foundation

struct GroupedOffersRequest: Codable {
    // MARK: - CatalogFilter

    struct CatalogFilter: Codable {
        let mark, model: String
    }

    let hasImage: Bool
    let inStock: String
    // let creationDateTo: String
    let rid: [Int]
    let geoRadius: Int
    let withDiscount: Bool
    let catalogFilter: [CatalogFilter]
    let stateGroup, damageGroup, customsStateGroup: String
}

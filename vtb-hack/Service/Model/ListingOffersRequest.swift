import Foundation

struct ListingOffersRequest: Codable {
    let hasImage: Bool
    let inStock: String
    // let creationDateTo: String
    let rid: [Int]
    let geoRadius: Int
    let withDiscount: Bool
    let catalogFilter: [CatalogFilter]
    let stateGroup, damageGroup, customsStateGroup: String
}

extension ListingOffersRequest {
    // MARK: - CatalogFilter

    struct CatalogFilter: Codable {
        let mark, model, generation, configuration: String
    }
}

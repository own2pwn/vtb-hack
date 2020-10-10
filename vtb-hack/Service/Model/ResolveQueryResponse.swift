import Foundation

struct ResolveQueryResponse: Codable {
    let query: String
    let suggests: [Suggest]
    let queryID: String?

    enum CodingKeys: String, CodingKey {
        case query, suggests
        case queryID = "query_id"
    }
}

extension ResolveQueryResponse {
    // MARK: - Suggest

    struct Suggest: Codable {
        let tokens: [Token]?
        let params: Params?
        let view: View?
        let relevance: Double?
    }

    // MARK: - Params

    struct Params: Codable {
        let carsParams: CarsParams?
        let currency: String?
        let hasImage: Bool?
        let inStock, withDelivery: String?
        let catalogFilter: [CatalogFilter]?
        let onlyNDS: Bool?
        let stateGroup, exchangeGroup: String?
        let sellerGroup: [String]?
        let damageGroup, ownersCountGroup, owningTimeGroup, customsStateGroup: String?

        enum CodingKeys: String, CodingKey {
            case carsParams = "cars_params"
            case currency
            case hasImage = "has_image"
            case inStock = "in_stock"
            case withDelivery = "with_delivery"
            case catalogFilter = "catalog_filter"
            case onlyNDS = "only_nds"
            case stateGroup = "state_group"
            case exchangeGroup = "exchange_group"
            case sellerGroup = "seller_group"
            case damageGroup = "damage_group"
            case ownersCountGroup = "owners_count_group"
            case owningTimeGroup = "owning_time_group"
            case customsStateGroup = "customs_state_group"
        }
    }

    // MARK: - CarsParams

    struct CarsParams: Codable {
        let bodyTypeGroup: [String]?
        let seatsGroup: String?
        let engineGroup: [String]?

        enum CodingKeys: String, CodingKey {
            case bodyTypeGroup = "body_type_group"
            case seatsGroup = "seats_group"
            case engineGroup = "engine_group"
        }
    }

    // MARK: - CatalogFilter

    struct CatalogFilter: Codable {
        let mark, model: String?
    }

    // MARK: - Token

    struct Token: Codable {
        let startChar, endChar: Int?
        let type: String?

        enum CodingKeys: String, CodingKey {
            case startChar = "start_char"
            case endChar = "end_char"
            case type
        }
    }

    // MARK: - View

    struct View: Codable {
        let markModelNameplateGenViews: [MarkModelNameplateGenView]?
        let appliedFilterCount: Int?
        let appliedFilterFields: [String]?

        enum CodingKeys: String, CodingKey {
            case markModelNameplateGenViews = "mark_model_nameplate_gen_views"
            case appliedFilterCount = "applied_filter_count"
            case appliedFilterFields = "applied_filter_fields"
        }
    }

    // MARK: - MarkModelNameplateGenView

    struct MarkModelNameplateGenView: Codable {
        let mark: Mark?
        let model: Model?
    }

    // MARK: - Mark

    struct Mark: Codable {
        let code, name, ruName: String?
        let logo: Logo?

        enum CodingKeys: String, CodingKey {
            case code, name
            case ruName = "ru_name"
            case logo
        }
    }

    // MARK: - Logo

    struct Logo: Codable {
        let name: String?
        let sizes: Sizes?
    }

    // MARK: - Sizes

    struct Sizes: Codable {
        let logo, bigLogo: String?

        enum CodingKeys: String, CodingKey {
            case logo
            case bigLogo = "big-logo"
        }
    }

    // MARK: - Model

    struct Model: Codable {
        let code, name, ruName: String?

        enum CodingKeys: String, CodingKey {
            case code, name
            case ruName = "ru_name"
        }
    }
}

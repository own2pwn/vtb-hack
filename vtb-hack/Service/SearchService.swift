import Combine
import Foundation

enum SearchService {
    private static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        return d
    }()

    static func groupedOffers(by suggest: ResolveQueryResponse.Suggest) -> AnyPublisher<GroupedOffersResponse, Error> {
        let endpoint = "groupedOffers"

        let filter = GroupedOffersRequest.CatalogFilter(
            mark: suggest.view!.markModelNameplateGenViews![0].mark!.code!,
            model: suggest.view!.markModelNameplateGenViews![0].model!.code!
        )

        let request = GroupedOffersRequest(
            hasImage: true,
            inStock: "ANY_STOCK",
            // creationDateTo: <#T##String#>,
            rid: [213],
            geoRadius: 200,
            withDiscount: true,
            catalogFilter: [filter],
            stateGroup: "NEW",
            damageGroup: "ANY",
            customsStateGroup: "DOESNT_MATTER"
        )

        return Backend.post(endpoint: endpoint, body: request)
    }

    static func offers(by groupedOffer: GroupedOffersResponse.Offer) -> AnyPublisher<ListingOffersResponse, Error> {
        let endpoint = "offers-listing"

        let filter = ListingOffersRequest.CatalogFilter(
            mark: groupedOffer.carInfo.mark,
            model: groupedOffer.carInfo.model,
            generation: groupedOffer.carInfo.superGenID,
            configuration: groupedOffer.carInfo.configurationID
        )

        let request = ListingOffersRequest(
            hasImage: true,
            inStock: "ANY_STOCK",
            // creationDateTo: <#T##String#>,
            rid: [213],
            geoRadius: 200,
            withDiscount: true,
            catalogFilter: [filter],
            stateGroup: "NEW",
            damageGroup: "ANY",
            customsStateGroup: "DOESNT_MATTER"
        )

        return Backend.post(endpoint: endpoint, body: request)
    }
}

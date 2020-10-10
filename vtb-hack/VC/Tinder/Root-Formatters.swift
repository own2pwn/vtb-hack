import Foundation

extension GroupedOffersResponse {
    var minPrice: Int {
        return priceRange!.min!.rurPrice!
    }

    var maxPrice: Int {
        return priceRange!.max!.rurPrice!
    }
}

extension GroupedOffersResponse.Offer {
    var title: String {
        return [
            carInfo?.markInfo?.name,
            carInfo?.modelInfo?.name,
            carInfo?.superGen?.name
        ].compactMap { $0 }.joined(separator: " ")
    }

    var minPrice: Int {
        return grouppingInfo!.priceFrom!.rurPrice!
    }

    var maxPrice: Int {
        return grouppingInfo!.priceTo!.rurPrice!
    }

    var formattedPrice: String {
        if minPrice == maxPrice {
            return PriceFormatter.sharedInstance.string(from: maxPrice, currency: .russianRuble)
        }
        let from = PriceFormatter.sharedInstance.string(from: minPrice, currency: nil)
        let to = PriceFormatter.sharedInstance.string(from: maxPrice, currency: .russianRuble)

        return "\(from) - \(to)"
    }

    var imageURL: String {
        return state!.imageUrls![0].sizes!.full!
    }
}

extension ListingOffersResponse.Offer {
    var title: String {
        return "\(carInfo.markInfo.name) \(carInfo.modelInfo.name) \(carInfo.superGen.name)"
    }

    var price: Int {
        return priceInfo.rurPrice
    }

    var formattedPrice: String {
        return PriceFormatter.sharedInstance.string(from: price, currency: .russianRuble)
    }
}

protocol DefaultValueNullable {
    var nilIfDefault: Self? { get }
}

extension Int: DefaultValueNullable {
    var nilIfDefault: Int? {
        return self != 0 ? self : nil
    }
}

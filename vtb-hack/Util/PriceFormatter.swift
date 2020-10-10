import Foundation

// see: https://en.wikipedia.org/wiki/ISO_4217
public enum Currency: String {
    case russianRubleLegacy = "RUB"
    case russianRuble = "RUR"
    case euro = "EUR"
    case unitedStatesDollar = "USD"
}

public final class PriceFormatter {
    fileprivate static let nbsp = "\u{00a0}" // non-breaking space

    private struct CurrencyAttributes {
        let symbol: String
        let groupingSeparator: String

        init(symbol: String, groupingSeparator: String) {
            self.symbol = symbol
            self.groupingSeparator = groupingSeparator
        }
    }

    private let currencyAttributes: [String: CurrencyAttributes] = [
        "RUB": CurrencyAttributes(symbol: "\u{20bd}", groupingSeparator: PriceFormatter.nbsp),
        "RUR": CurrencyAttributes(symbol: "\u{20bd}", groupingSeparator: PriceFormatter.nbsp),
        "EUR": CurrencyAttributes(symbol: "\u{20ac}", groupingSeparator: PriceFormatter.nbsp),
        "USD": CurrencyAttributes(symbol: "\u{24}", groupingSeparator: PriceFormatter.nbsp),
        "EMPTY_CURRENCY": CurrencyAttributes(symbol: "", groupingSeparator: PriceFormatter.nbsp)
    ]

    private static let availableCurrencyCodes: Set<String> = Set(Locale.isoCurrencyCodes)
    private var cachedFormatters: [String: NumberFormatter] = [:]

    public static let sharedInstance: PriceFormatter = {
        return PriceFormatter()
    }()

    private init() {}

    // MARK: Public

    public func string(from price: Int, currency: Currency?) -> String {
        return string(from: Int64(price), currencyCode: currency?.rawValue)
    }

    public func string(from price: Int, currencyCode: String?) -> String {
        return string(from: Int64(price), currencyCode: currencyCode)
    }

    public func string(from price: Int64, currency: Currency?) -> String {
        return string(from: price, currencyCode: currency?.rawValue)
    }

    public func string(from price: Int64, currencyCode: String?) -> String {
        let formatter: NumberFormatter
        if let currencyCode = currencyCode {
            formatter = numberFormatter(for: currencyCode)
        } else {
            formatter = numberFormatter(for: "EMPTY_CURRENCY")
        }

        let result = formatter.string(from: NSNumber(value: price))
        return result?.trimmingCharacters(in: CharacterSet.whitespaces) ?? ""
    }

    public func symbol(for currencyCode: Currency) -> String? {
        guard let attributes = currencyAttributes[currencyCode.rawValue] else {
            return nil
        }

        return attributes.symbol
    }

    // MARK: Private

    private func numberFormatter(for currencyCode: String) -> NumberFormatter {
        if let formatter = cachedFormatters[currencyCode] {
            return formatter
        }

        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.numberStyle = .currency

        formatter.currencyCode = currencyCode
        formatter.maximumFractionDigits = 0

        if let attributes = currencyAttributes[currencyCode] {
            formatter.currencySymbol = attributes.symbol
            formatter.internationalCurrencySymbol = attributes.symbol
            formatter.currencyGroupingSeparator = attributes.groupingSeparator
        }

        cachedFormatters[currencyCode] = formatter
        return formatter
    }
}

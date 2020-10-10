import Foundation

struct GroupedOffersResponse: Codable {
    let offers: [Offer]?
    let priceRange: PriceRange?
    let pagination: Pagination?
    let sorting: Sorting?
    let responseFlags: ResponseFlags?
    let searchParameters: SearchParameters?
    let grouping: Grouping?
    let searchID, status: String?

    enum CodingKeys: String, CodingKey {
        case offers
        case priceRange = "price_range"
        case pagination, sorting
        case responseFlags = "response_flags"
        case searchParameters = "search_parameters"
        case grouping
        case searchID = "search_id"
        case status
    }
}

extension GroupedOffersResponse {
    // MARK: - Grouping

    struct Grouping: Codable {
        let singleOffersCount, groupsCount: Int?

        enum CodingKeys: String, CodingKey {
            case singleOffersCount = "single_offers_count"
            case groupsCount = "groups_count"
        }
    }

    // MARK: - Offer

    struct Offer: Codable {
        let carInfo: CarInfo?
        let url, mobileURL: String?
        let colorHex, status, category, section: String?
        let availability: String?
        let oldCategoryID: Int?
        let priceInfo: PriceInfo?
        let offerDescription: String?
        let documents: Documents?
        let state: State?
        let id: String?
        let additionalInfo: AdditionalInfo?
        let sellerType: String?
        let salon: Salon?
        let seller: Seller?
        let counters, recallInfo: Counters?
        let priceHistory: [PriceHistory]?
        let tags: [String]?
        let isFavorite: Bool?
        let created: String?
        let grouppingInfo: GrouppingInfo?
        let discountOptions: DiscountOptions?
        let deliveryInfo: Counters?

        enum CodingKeys: String, CodingKey {
            case carInfo = "car_info"
            case url
            case mobileURL = "mobile_url"
            case colorHex = "color_hex"
            case status, category, section, availability
            case oldCategoryID = "old_category_id"
            case priceInfo = "price_info"
            case offerDescription = "description"
            case documents, state, id
            case additionalInfo = "additional_info"
            case sellerType = "seller_type"
            case salon, seller, counters
            case recallInfo = "recall_info"
            case priceHistory = "price_history"
            case tags
            case isFavorite = "is_favorite"
            case created
            case grouppingInfo = "groupping_info"
            case discountOptions = "discount_options"
            case deliveryInfo = "delivery_info"
        }
    }

    // MARK: - AdditionalInfo

    struct AdditionalInfo: Codable {
        let hidden, isOnModeration: Bool?
        let updateDate, creationDate: String?
        let mobileAutoservicesURL: String?
        let hotInfo: HotInfo?
        let redemptionAvailable: Bool?
        let freshDate, countersStartDate: String?
        let chatOnly: Bool?
        let dealerCardPromo: String?
        let reviewSummary, priceStats, booking: Counters?

        enum CodingKeys: String, CodingKey {
            case hidden
            case isOnModeration = "is_on_moderation"
            case updateDate = "update_date"
            case creationDate = "creation_date"
            case mobileAutoservicesURL = "mobile_autoservices_url"
            case hotInfo = "hot_info"
            case redemptionAvailable = "redemption_available"
            case freshDate = "fresh_date"
            case countersStartDate = "counters_start_date"
            case chatOnly = "chat_only"
            case dealerCardPromo = "dealer_card_promo"
            case reviewSummary = "review_summary"
            case priceStats = "price_stats"
            case booking
        }
    }

    // MARK: - Counters

    struct Counters: Codable {}

    // MARK: - HotInfo

    struct HotInfo: Codable {
        let isHot: Bool?
        let startTime, endTime: String?

        enum CodingKeys: String, CodingKey {
            case isHot = "is_hot"
            case startTime = "start_time"
            case endTime = "end_time"
        }
    }

    // MARK: - CarInfo

    struct CarInfo: Codable {
        let armored: Bool?
        let bodyType, engineType, transmission, drive: String?
        let mark, model, superGenID, configurationID: String?
        let techParamID, complectationID: String?
        let wheelLeft: Bool?
        let horsePower: Int?
        let markInfo: MarkInfo?
        let modelInfo: ModelInfo?
        let superGen: SuperGen?
        let configuration: Configuration?
        let techParam: TechParam?
        let complectation: CarInfoComplectation?
        let vendor: String?
        let equipment: Equipment?
        let steeringWheel: String?

        enum CodingKeys: String, CodingKey {
            case armored
            case bodyType = "body_type"
            case engineType = "engine_type"
            case transmission, drive, mark, model
            case superGenID = "super_gen_id"
            case configurationID = "configuration_id"
            case techParamID = "tech_param_id"
            case complectationID = "complectation_id"
            case wheelLeft = "wheel_left"
            case horsePower = "horse_power"
            case markInfo = "mark_info"
            case modelInfo = "model_info"
            case superGen = "super_gen"
            case configuration
            case techParam = "tech_param"
            case complectation, vendor, equipment
            case steeringWheel = "steering_wheel"
        }
    }

    // MARK: - CarInfoComplectation

    struct CarInfoComplectation: Codable {
        let id, name: String?
        let availableOptions: [String]?
        let vendorColors: [VendorColor]?

        enum CodingKeys: String, CodingKey {
            case id, name
            case availableOptions = "available_options"
            case vendorColors = "vendor_colors"
        }
    }

    // MARK: - VendorColor

    struct VendorColor: Codable {
        let bodyColorID, markColorID: Int?
        let nameRu, colorType: String?
        let stockColor: StockColor?
        let photos: [Photo]?
        let mainColor: Bool?

        enum CodingKeys: String, CodingKey {
            case bodyColorID = "body_color_id"
            case markColorID = "mark_color_id"
            case nameRu = "name_ru"
            case colorType = "color_type"
            case stockColor = "stock_color"
            case photos
            case mainColor = "main_color"
        }
    }

    // MARK: - Photo

    struct Photo: Codable {
        let name: String?
        let sizes: PhotoSizes?
    }

    // MARK: - PhotoSizes

    struct PhotoSizes: Codable {
        let orig, wizardv3Mr, wizardv3, cattouch: String?
        let small, the320X240, the1200X900, the1200X900N: String?
        let thumbM, full, the832X624, the456X342: String?
        let the120X90, the92X69, islandoff, thumbS: String?
        let thumbS2X: String?

        enum CodingKeys: String, CodingKey {
            case orig
            case wizardv3Mr = "wizardv3mr"
            case wizardv3, cattouch, small
            case the320X240 = "320x240"
            case the1200X900 = "1200x900"
            case the1200X900N = "1200x900n"
            case thumbM = "thumb_m"
            case full
            case the832X624 = "832x624"
            case the456X342 = "456x342"
            case the120X90 = "120x90"
            case the92X69 = "92x69"
            case islandoff
            case thumbS = "thumb_s"
            case thumbS2X = "thumb_s_2x"
        }
    }

    // MARK: - StockColor

    struct StockColor: Codable {
        let hexCode, nameRu: String?

        enum CodingKeys: String, CodingKey {
            case hexCode = "hex_code"
            case nameRu = "name_ru"
        }
    }

    // MARK: - Configuration

    struct Configuration: Codable {
        let id, bodyType: String?
        let doorsCount: Int?
        let autoClass, humanName: String?
        let trunkVolumeMin: Int?
        let bodyTypeGroup: String?
        let mainPhoto: MainPhoto?
        let tags: [String]?

        enum CodingKeys: String, CodingKey {
            case id
            case bodyType = "body_type"
            case doorsCount = "doors_count"
            case autoClass = "auto_class"
            case humanName = "human_name"
            case trunkVolumeMin = "trunk_volume_min"
            case bodyTypeGroup = "body_type_group"
            case mainPhoto = "main_photo"
            case tags
        }
    }

    // MARK: - MainPhoto

    struct MainPhoto: Codable {
        let sizes: PurpleSizes?
    }

    // MARK: - PurpleSizes

    struct PurpleSizes: Codable {
        let orig, wizardv3Mr, cattouch: String?

        enum CodingKeys: String, CodingKey {
            case orig
            case wizardv3Mr = "wizardv3mr"
            case cattouch
        }
    }

    // MARK: - Equipment

    struct Equipment: Codable {
        let cruiseControl, esp, usb, multiWheel: Bool?
        let spareWheel, audiosystemTv, heatedWashSystem, airbagPassenger: Bool?
        let frontCentreArmrest, appleCarplay, lock, electroMirrors: Bool?
        let drl, electroWindowBack, driverSeatSupport, easyTrunkOpening: Bool?
        let mirrorsHeat, the17InchWheels, parkAssistF, rearSeatsHeat: Bool?
        let leather, wheelHeat, ledLights, parkAssistR: Bool?
        let kneeAirbag, glonass, wirelessCharger, airbagDriver: Bool?
        let isofix, electroWindowFront, driveModeSys, lightSensor: Bool?
        let hcc, airbagCurtain, vsm, computer: Bool?
        let keylessEntry, seatTransformation, androidAuto, passengerSeatElectric: Bool?
        let alloyWheelDisks, leatherGearStick, blindSpot, startButton: Bool?
        let ptf, rainSensor, airbagSide, tyrePressure: Bool?
        let remoteEngineStart, audiosystemCD, electroTrunk, frontSeatsHeat: Bool?
        let bluetooth, wheelLeather, climateControl2, windscreenHeat: Bool?
        let autoMirrors, the12VSocket, the360Camera: Bool?

        enum CodingKeys: String, CodingKey {
            case cruiseControl = "cruise-control"
            case esp, usb
            case multiWheel = "multi-wheel"
            case spareWheel = "spare-wheel"
            case audiosystemTv = "audiosystem-tv"
            case heatedWashSystem = "heated-wash-system"
            case airbagPassenger = "airbag-passenger"
            case frontCentreArmrest = "front-centre-armrest"
            case appleCarplay = "apple-carplay"
            case lock
            case electroMirrors = "electro-mirrors"
            case drl
            case electroWindowBack = "electro-window-back"
            case driverSeatSupport = "driver-seat-support"
            case easyTrunkOpening = "easy-trunk-opening"
            case mirrorsHeat = "mirrors-heat"
            case the17InchWheels = "17-inch-wheels"
            case parkAssistF = "park-assist-f"
            case rearSeatsHeat = "rear-seats-heat"
            case leather
            case wheelHeat = "wheel-heat"
            case ledLights = "led-lights"
            case parkAssistR = "park-assist-r"
            case kneeAirbag = "knee-airbag"
            case glonass
            case wirelessCharger = "wireless-charger"
            case airbagDriver = "airbag-driver"
            case isofix
            case electroWindowFront = "electro-window-front"
            case driveModeSys = "drive-mode-sys"
            case lightSensor = "light-sensor"
            case hcc
            case airbagCurtain = "airbag-curtain"
            case vsm, computer
            case keylessEntry = "keyless-entry"
            case seatTransformation = "seat-transformation"
            case androidAuto = "android-auto"
            case passengerSeatElectric = "passenger-seat-electric"
            case alloyWheelDisks = "alloy-wheel-disks"
            case leatherGearStick = "leather-gear-stick"
            case blindSpot = "blind-spot"
            case startButton = "start-button"
            case ptf
            case rainSensor = "rain-sensor"
            case airbagSide = "airbag-side"
            case tyrePressure = "tyre-pressure"
            case remoteEngineStart = "remote-engine-start"
            case audiosystemCD = "audiosystem-cd"
            case electroTrunk = "electro-trunk"
            case frontSeatsHeat = "front-seats-heat"
            case bluetooth
            case wheelLeather = "wheel-leather"
            case climateControl2 = "climate-control-2"
            case windscreenHeat = "windscreen-heat"
            case autoMirrors = "auto-mirrors"
            case the12VSocket = "12v-socket"
            case the360Camera = "360-camera"
        }
    }

    // MARK: - MarkInfo

    struct MarkInfo: Codable {
        let code, name, ruName: String?
        let logo: MarkInfoLogo?

        enum CodingKeys: String, CodingKey {
            case code, name
            case ruName = "ru_name"
            case logo
        }
    }

    // MARK: - MarkInfoLogo

    struct MarkInfoLogo: Codable {
        let name: String?
        let sizes: FluffySizes?
    }

    // MARK: - FluffySizes

    struct FluffySizes: Codable {
        let logo, bigLogo: String?

        enum CodingKeys: String, CodingKey {
            case logo
            case bigLogo = "big-logo"
        }
    }

    // MARK: - ModelInfo

    struct ModelInfo: Codable {
        let code, name, ruName: String?
        let morphology: Counters?
        let nameplate: Nameplate?

        enum CodingKeys: String, CodingKey {
            case code, name
            case ruName = "ru_name"
            case morphology, nameplate
        }
    }

    // MARK: - Nameplate

    struct Nameplate: Codable {
        let code, name, semanticURL: String?

        enum CodingKeys: String, CodingKey {
            case code, name
            case semanticURL = "semantic_url"
        }
    }

    // MARK: - SuperGen

    struct SuperGen: Codable {
        let id, name, ruName: String?
        let yearFrom: Int?
        let priceSegment: String?

        enum CodingKeys: String, CodingKey {
            case id, name
            case ruName = "ru_name"
            case yearFrom = "year_from"
            case priceSegment = "price_segment"
        }
    }

    // MARK: - TechParam

    struct TechParam: Codable {
        let id: String?
        let displacement: Int?
        let engineType, gearType, transmission: String?
        let power, powerKvt: Int?
        let humanName: String?
        let acceleration: Double?
        let clearanceMin: Int?

        enum CodingKeys: String, CodingKey {
            case id, displacement
            case engineType = "engine_type"
            case gearType = "gear_type"
            case transmission, power
            case powerKvt = "power_kvt"
            case humanName = "human_name"
            case acceleration
            case clearanceMin = "clearance_min"
        }
    }

    // MARK: - DiscountOptions

    struct DiscountOptions: Codable {
        let credit, maxDiscount: Int?

        enum CodingKeys: String, CodingKey {
            case credit
            case maxDiscount = "max_discount"
        }
    }

    // MARK: - Documents

    struct Documents: Codable {
        let ptsOriginal, customCleared: Bool?
        let year: Int?
        let vin, pts: String?

        enum CodingKeys: String, CodingKey {
            case ptsOriginal = "pts_original"
            case customCleared = "custom_cleared"
            case year, vin, pts
        }
    }

    // MARK: - GrouppingInfo

    struct GrouppingInfo: Codable {
        let grouppingParams: GrouppingParams?
        let size: Int?
        let priceFrom: Max?
        let uniqueColorsCount: Int?
        let priceTo: Max?
        let colors: [String]?
        let baseEquipmentCount: Int?
        let groupingID: String?
        let techParams: [TechParam]?
        let complectations: [ComplectationElement]?
        let offerCounter: OfferCounter?
        let productionYears: ProductionYears?

        enum CodingKeys: String, CodingKey {
            case grouppingParams = "groupping_params"
            case size
            case priceFrom = "price_from"
            case uniqueColorsCount = "unique_colors_count"
            case priceTo = "price_to"
            case colors
            case baseEquipmentCount = "base_equipment_count"
            case groupingID = "grouping_id"
            case techParams = "tech_params"
            case complectations
            case offerCounter = "offer_counter"
            case productionYears = "production_years"
        }
    }

    // MARK: - ComplectationElement

    struct ComplectationElement: Codable {
        let id, name: String?
    }

    // MARK: - GrouppingParams

    struct GrouppingParams: Codable {
        let configurationID: String?

        enum CodingKeys: String, CodingKey {
            case configurationID = "configuration_id"
        }
    }

    // MARK: - OfferCounter

    struct OfferCounter: Codable {
        let newCars: String?

        enum CodingKeys: String, CodingKey {
            case newCars = "new_cars"
        }
    }

    // MARK: - Max

    struct Max: Codable {
        let price: Int?
        let currency: String?
        let rurPrice, usdPrice, eurPrice, dprice: Int?
        let rurDprice, usdDprice, eurDprice: Int?

        enum CodingKeys: String, CodingKey {
            case price, currency
            case rurPrice = "rur_price"
            case usdPrice = "usd_price"
            case eurPrice = "eur_price"
            case dprice
            case rurDprice = "rur_dprice"
            case usdDprice = "usd_dprice"
            case eurDprice = "eur_dprice"
        }
    }

    // MARK: - ProductionYears

    struct ProductionYears: Codable {
        let minYear, maxYear: Int?

        enum CodingKeys: String, CodingKey {
            case minYear = "min_year"
            case maxYear = "max_year"
        }
    }

    // MARK: - OsagoInsurance

    struct OsagoInsurance: Codable {
        let insuranceCompany: String?
        let price: Int?

        enum CodingKeys: String, CodingKey {
            case insuranceCompany = "insurance_company"
            case price
        }
    }

    // MARK: - TransportTax

    struct TransportTax: Codable {
        let taxByYear, year, rid, rate: Int?
        let horsePower, holdingPeriodMonth, boost: Double?

        enum CodingKeys: String, CodingKey {
            case taxByYear = "tax_by_year"
            case year, rid, rate
            case horsePower = "horse_power"
            case holdingPeriodMonth = "holding_period_month"
            case boost
        }
    }

    // MARK: - PriceHistory

    struct PriceHistory: Codable {
        let price: Int?
        let currency, createTimestamp: String?
        let rurPrice, usdPrice, eurPrice: Int?
        let withNDS: Bool?
        let dprice, rurDprice, usdDprice, eurDprice: Int?

        enum CodingKeys: String, CodingKey {
            case price, currency
            case createTimestamp = "create_timestamp"
            case rurPrice = "rur_price"
            case usdPrice = "usd_price"
            case eurPrice = "eur_price"
            case withNDS = "with_nds"
            case dprice
            case rurDprice = "rur_dprice"
            case usdDprice = "usd_dprice"
            case eurDprice = "eur_dprice"
        }
    }

    // MARK: - PriceInfo

    struct PriceInfo: Codable {
        let price: Int?
        let currency: String?
        let rurPrice, usdPrice, eurPrice: Int?
        let withNDS: Bool?
        let dprice, rurDprice, usdDprice, eurDprice: Int?

        enum CodingKeys: String, CodingKey {
            case price, currency
            case rurPrice = "rur_price"
            case usdPrice = "usd_price"
            case eurPrice = "eur_price"
            case withNDS = "with_nds"
            case dprice
            case rurDprice = "rur_dprice"
            case usdDprice = "usd_dprice"
            case eurDprice = "eur_dprice"
        }
    }

    // MARK: - Salon

    struct Salon: Codable {
        let salonID, name: String?
        let isOficial: Bool?
        let place: Place?
        let offersCount: Int?
        let editContact, editAddress: Bool?
        let code, registrationDate, salonHash, dealerID: String?
        let clientID, logoURL: String?
        let actualStock, loyaltyProgram: Bool?
        let clientIDS: [String]?
        let openHours: String?
        let carMarks: [CarMark]?
        let logo, mainPhoto: LogoElement?
        let dealerGallery: [LogoElement]?
        let offerCounters: OfferCounters?
        let category: [String]?
        let net: Net?

        enum CodingKeys: String, CodingKey {
            case salonID = "salon_id"
            case name
            case isOficial = "is_oficial"
            case place
            case offersCount = "offers_count"
            case editContact = "edit_contact"
            case editAddress = "edit_address"
            case code
            case registrationDate = "registration_date"
            case salonHash = "salon_hash"
            case dealerID = "dealer_id"
            case clientID = "client_id"
            case logoURL = "logo_url"
            case actualStock = "actual_stock"
            case loyaltyProgram = "loyalty_program"
            case clientIDS = "client_ids"
            case openHours = "open_hours"
            case carMarks = "car_marks"
            case logo
            case mainPhoto = "main_photo"
            case dealerGallery = "dealer_gallery"
            case offerCounters = "offer_counters"
            case category, net
        }
    }

    // MARK: - CarMark

    struct CarMark: Codable {
        let code, name, ruName: String?
        let logo: CarMarkLogo?

        enum CodingKeys: String, CodingKey {
            case code, name
            case ruName = "ru_name"
            case logo
        }
    }

    // MARK: - CarMarkLogo

    struct CarMarkLogo: Codable {
        let name: String?
        let sizes: TentacledSizes?
    }

    // MARK: - TentacledSizes

    struct TentacledSizes: Codable {
        let logo: String?
    }

    // MARK: - LogoElement

    struct LogoElement: Codable {
        let name: String?
        let sizes: DealerGallerySizes?
    }

    // MARK: - DealerGallerySizes

    struct DealerGallerySizes: Codable {
        let thumbM2X, offertouchret, gallery, wizardv3Mr: String?
        let cattouchret, cattouch: String?

        enum CodingKeys: String, CodingKey {
            case thumbM2X = "thumb_m_2x"
            case offertouchret, gallery
            case wizardv3Mr = "wizardv3mr"
            case cattouchret, cattouch
        }
    }

    // MARK: - Net

    struct Net: Codable {
        let id: Int?
        let name, semanticURL: String?

        enum CodingKeys: String, CodingKey {
            case id, name
            case semanticURL = "semantic_url"
        }
    }

    // MARK: - OfferCounters

    struct OfferCounters: Codable {
        let carsAll: Int?

        enum CodingKeys: String, CodingKey {
            case carsAll = "cars_all"
        }
    }

    // MARK: - Place

    struct Place: Codable {
        let address: String?
        let coord: Coord?
        let geobaseID: String?
        let regionInfo: PlaceRegionInfo?
        let metro: [Metro]?

        enum CodingKeys: String, CodingKey {
            case address, coord
            case geobaseID = "geobase_id"
            case regionInfo = "region_info"
            case metro
        }
    }

    // MARK: - Coord

    struct Coord: Codable {
        let latitude, longitude: Double?
    }

    // MARK: - Metro

    struct Metro: Codable {
        let rid, name: String?
        let distance: Double?
        let location: Coord?
        let lines: [Line]?
    }

    // MARK: - Line

    struct Line: Codable {
        let name, color: String?
    }

    // MARK: - PlaceRegionInfo

    struct PlaceRegionInfo: Codable {
        let id, name, genitive, dative: String?
        let accusative, prepositional, preposition: String?
        let latitude, longitude: Double?
        let parentIDS: [String]?

        enum CodingKeys: String, CodingKey {
            case id, name, genitive, dative, accusative, prepositional, preposition, latitude, longitude
            case parentIDS = "parent_ids"
        }
    }

    // MARK: - Seller

    struct Seller: Codable {
        let name: String?
        let phones: [Phone]?
        let location: Location?
        let redirectPhones, chatsEnabled: Bool?

        enum CodingKeys: String, CodingKey {
            case name, phones, location
            case redirectPhones = "redirect_phones"
            case chatsEnabled = "chats_enabled"
        }
    }

    // MARK: - Location

    struct Location: Codable {
        let address: String?
        let coord: Coord?
        let geobaseID: String?
        let regionInfo: PlaceRegionInfo?
        let metro: [Metro]?
        let distanceToSelectedGeo: [DistanceToSelectedGeo]?

        enum CodingKeys: String, CodingKey {
            case address, coord
            case geobaseID = "geobase_id"
            case regionInfo = "region_info"
            case metro
            case distanceToSelectedGeo = "distance_to_selected_geo"
        }
    }

    // MARK: - DistanceToSelectedGeo

    struct DistanceToSelectedGeo: Codable {
        let coord: Coord?
        let geobaseID: String?
        let regionInfo: DistanceToSelectedGeoRegionInfo?

        enum CodingKeys: String, CodingKey {
            case coord
            case geobaseID = "geobase_id"
            case regionInfo = "region_info"
        }
    }

    // MARK: - DistanceToSelectedGeoRegionInfo

    struct DistanceToSelectedGeoRegionInfo: Codable {
        let id, name, genitive, dative: String?
        let accusative, prepositional, preposition: String?
        let latitude, longitude: Double?
        let supportsGeoRadius: Bool?

        enum CodingKeys: String, CodingKey {
            case id, name, genitive, dative, accusative, prepositional, preposition, latitude, longitude
            case supportsGeoRadius = "supports_geo_radius"
        }
    }

    // MARK: - Phone

    struct Phone: Codable {
        let callHourStart, callHourEnd: Int?
        let mask: String?

        enum CodingKeys: String, CodingKey {
            case callHourStart = "call_hour_start"
            case callHourEnd = "call_hour_end"
            case mask
        }
    }

    // MARK: - State

    struct State: Codable {
        let stateNotBeaten: Bool?
        let imageUrls: [ImageURL]?
        let condition: String?

        enum CodingKeys: String, CodingKey {
            case stateNotBeaten = "state_not_beaten"
            case imageUrls = "image_urls"
            case condition
        }
    }

    // MARK: - ImageURL

    struct ImageURL: Codable {
        let name: String?
        let sizes: ImageURLSizes?
        let preview: Preview?
    }

    // MARK: - Preview

    struct Preview: Codable {
        let version, width, height: Int?
        let data: String?
    }

    // MARK: - ImageURLSizes

    struct ImageURLSizes: Codable {
        let the456X342N, small, the1200X900N, the120X90: String?
        let the1200X900, the92X69, thumbM, the832X624: String?
        let the456X342, the320X240, full: String?

        enum CodingKeys: String, CodingKey {
            case the456X342N = "456x342n"
            case small
            case the1200X900N = "1200x900n"
            case the120X90 = "120x90"
            case the1200X900 = "1200x900"
            case the92X69 = "92x69"
            case thumbM = "thumb_m"
            case the832X624 = "832x624"
            case the456X342 = "456x342"
            case the320X240 = "320x240"
            case full
        }
    }

    // MARK: - Pagination

    struct Pagination: Codable {
        let page, pageSize, totalOffersCount, totalPageCount: Int?

        enum CodingKeys: String, CodingKey {
            case page
            case pageSize = "page_size"
            case totalOffersCount = "total_offers_count"
            case totalPageCount = "total_page_count"
        }
    }

    // MARK: - PriceRange

    struct PriceRange: Codable {
        let min, max: Max?
    }

    // MARK: - ResponseFlags

    struct ResponseFlags: Codable {
        let showMatchApplicationForm: Bool?

        enum CodingKeys: String, CodingKey {
            case showMatchApplicationForm = "show_match_application_form"
        }
    }

    // MARK: - SearchParameters

    struct SearchParameters: Codable {
        let carsParams: CarsParams?
        let currency: String?
        let hasImage: Bool?
        let inStock: String?
        let rid: [Int]?
        let geoRadius: Int?
        let withDiscount: Bool?
        let withDelivery: String?
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
            case rid
            case geoRadius = "geo_radius"
            case withDiscount = "with_discount"
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

    // MARK: - Sorting

    struct Sorting: Codable {
        let name: String?
        let desc: Bool?
    }
}

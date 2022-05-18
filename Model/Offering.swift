// 
//  Offering.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  

import Foundation

struct Offering: Hashable {
    enum `Type`: String, Codable {
        case venue = "VENUE"
        case exhibition = "EXHIBITION"
    }
    
    var type: `Type`
    var id: String
    var name: String
    var imageURL: URL
    var priceCurrencyCode: String
    var price: String

    // Venue only
    var starsRating: Double?

    // Exhibition only
    var location: String?
    var startDate: Date?
    var endDate: Date?
}


// MARK: - View

extension Offering {
    var formattedPrice: String {
        let currencyFormatter = Self.currencyFormatter
        currencyFormatter.currencyCode = priceCurrencyCode
        guard let number = Self.numberFormatter.number(from: price) else { assertionFailure(); return "" }
        guard let price = currencyFormatter.string(from: number) else { assertionFailure(); return "" }
        return price
    }
    
    var formattedStarRating: String? {
        guard let starsRating = starsRating else { return nil }
        return Self.starsFormatter.string(from: NSNumber(value: starsRating))
    }
    
    var formattedDateInterval: String? {
        guard let startDate = startDate, let endDate = endDate else { return nil }
        return Self.dateIntervalFormatter.string(from: DateInterval(start: startDate, end: endDate))
    }
    
    // MARK: Formatters
    
    private static var numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.decimalSeparator = "."
        return f
    }()
    
    private static var starsFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.minimumFractionDigits = 1
        f.maximumFractionDigits = 1
        return f
    }()
    
    private static var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f
    }()
    
    private static var dateIntervalFormatter: DateIntervalFormatter = {
        let f = DateIntervalFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()
}


// MARK: - Parsing

extension Offering: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case name
        case imageURL = "image"
        case priceCurrencyCode
        case price
        case starsRating
        case location
        case startDate
        case endDate
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}

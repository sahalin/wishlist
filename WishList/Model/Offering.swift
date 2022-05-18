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


// MARK: - JSON parsing

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

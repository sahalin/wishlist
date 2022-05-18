// 
//  NetworkManager.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  

import Foundation

class NetworkManager {
    func fetchOfferings() async throws -> [Offering] {
        let request = URLRequest(url: Bundle.main.url(forResource: "offerings", withExtension: "json")!)
        let (data, _) = try await URLSession.shared.data(for: request)
        let offerings = try! Offering.decoder.decode(Dictionary<String, [Offering]>.self, from: data)
        return offerings["items"]!
    }
}

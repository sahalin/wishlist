// 
//  NetworkManager.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  

import Foundation
import UIKit

class NetworkManager {
    private let imageCache = NSCache<NSURL, UIImage>()
    
    func fetchOfferings() async throws -> [Offering] {
        let request = URLRequest(url: Bundle.main.url(forResource: "offerings", withExtension: "json")!)
        // Not checking for correct response here as using a local url does not produce an HTTPURLResponse.
        let (data, _) = try await URLSession.shared.data(for: request)
        let offerings = try! Offering.decoder.decode(Dictionary<String, [Offering]>.self, from: data)
        return offerings["items"]!
    }
    
    func loadImage(at url: URL) async throws -> UIImage {
        if let image = imageCache.object(forKey: url as NSURL) {
            return image
        }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw RuntimeError("Fetch error") }
        guard let image = UIImage(data: data) else { throw RuntimeError("Image error") }
        imageCache.setObject(image, forKey: url as NSURL)
        return image
    }
}

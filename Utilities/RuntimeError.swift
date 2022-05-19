// 
//  RuntimeError.swift
//  WishList
//
//  Created by Alexander on 19.05.2022.
//  

import Foundation

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        message
    }
}

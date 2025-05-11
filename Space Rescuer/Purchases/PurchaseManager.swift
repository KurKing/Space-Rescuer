//
//  PurchaseManager.swift
//  Space Rescuer
//
//  Created by Oleksii on 11.05.2025.
//

import Foundation
import StoreKit

enum PurchaseManagerError: Error {
    case unknown
}

protocol PurchaseManager {
    
    func getProducts() async -> [Product] 
    func purchase(_ product: Product) async throws
}

class StoreKitPurchaseManager: PurchaseManager {
    
    private let productIds = ["very.first", "very.first.subscription"]
    
    private var products = [Product]()
    private var productsLoaded = false
    
    func getProducts() async -> [Product] {
        
        guard !productsLoaded else {
            return products
        }

        products = (try? await Product.products(for: productIds)) ?? []
        productsLoaded = true
        
        return products
    }
    
    func purchase(_ product: Product) async throws {
        
        guard let result = try? await product.purchase(),
              case let .success(.verified(transaction)) = result else {
            throw PurchaseManagerError.unknown
        }
        
        await transaction.finish()
    }
}

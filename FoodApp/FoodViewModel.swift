//
//  FoodViewModel.swift
//  FoodApp
//
//  Created by MacBook Air on 27.05.24.
//

import Foundation

class FoodViewModel: ObservableObject {
    @Published var products: [Food] = [
        Food(productName: "ვაშლი", price: 1.50, imageName: "apple"),
        Food(productName: "ატამი", price: 2.70, imageName: "peach"),
        Food(productName: "ნესვი", price: 6.30, imageName: "melon"),
        Food(productName: "ავოკადო", price: 9.20, imageName: "avocado"),
        Food(productName: "ვარია", price: 35.50, imageName: "chicken"),
        Food(productName: "ბრინჯი", price: 2.30, imageName: "rice"),
        Food(productName: "კრევეტი", price: 50.50, imageName: "shrimp"),
        Food(productName: "რიბაკი ბიჭების თევზები", price: 1200, imageName: "ribaki")
    ]
    
    var totalItems: Int {
        return products.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        return products.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    func resetAllItems() {
        for i in 0..<products.count {
            products[i].quantity = 0
        }
    }
    
    func incrementQuantity(for product: Food) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].quantity += 1
        }
    }
    
    func decrementQuantity(for product: Food) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            if products[index].quantity > 0 {
                products[index].quantity -= 1
            }
        }
    }
}

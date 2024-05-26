//
//  ContentView.swift
//  FoodApp
//
//  Created by MacBook Air on 25.05.24.
//

import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    let productName: String
    let price: Double
    let imageName: String
    var quantity: Int = 0
}

struct ContentView: View {
    @State private var products = [
        Food(productName: "ვაშლი", price: 1.50, imageName: "apple"),
        Food(productName: "ატამი", price: 2.70, imageName: "peach"),
        Food(productName: "ნესვი", price: 6.30, imageName: "melon"),
        Food(productName: "ავოკადო", price: 9.20, imageName: "avocado"),
        Food(productName: "ვარია", price: 35.50, imageName: "chicken"),
        Food(productName: "ბრინჯი", price: 2.30, imageName: "rice"),
        Food(productName: "კრევეტი", price: 50.50, imageName: "shrimp"),
        Food(productName: "რიბაკი ბიჭების თევზები", price: 1200, imageName: "ribaki")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("გლდანის")
                    .font(.title)
                Image("bazari")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("ბაზარი")
                    .font(.title)
            }
            .padding()
            
            ScrollView {
                VStack {
                    ForEach($products) { $product in
                        ProductsRow(food: $product)
                            .padding(.horizontal)
                    }
                }
            }
            
            Footer(totalPrice: calculateTotalPrice(), totalItems: calculateTotalItems())
        }
    }
    
    func calculateTotalItems() -> Int {
        return products.reduce(0) { $0 + $1.quantity }
    }
    
    func calculateTotalPrice() -> Double {
        return products.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
}

struct ProductsRow: View {
    @Binding var food: Food
    
    var body: some View {
        HStack {
            Image(food.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(food.productName)
                    .font(.headline)
                Text(String(format: "%.2f ლარი", food.price))
                    .font(.subheadline)
            }
            Spacer()
            
            HStack {
                Button(action: {
                    if food.quantity > 0 {
                        food.quantity -= 1
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.red)
                }
                Text("\(food.quantity)")
                Button(action: {
                    food.quantity += 1
                }) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

struct Footer: View {
    var totalPrice: Double
    var totalItems: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Items: \(totalItems)")
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Total Price: \(String(format: "%.2f ლარი", totalPrice))")
                        .font(.subheadline)
                }
            }
            .padding()
            
            Button(action: {
                // Pay action
            }) {
                Text("Pay")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

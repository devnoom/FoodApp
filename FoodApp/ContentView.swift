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
    @StateObject private var viewModel = FoodViewModel()
    
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
                    ForEach(viewModel.products) { product in
                        ProductsRow(food: product, viewModel: viewModel)
                            .padding(.horizontal)
                    }
                }
            }
            
            Footer(totalPrice: viewModel.totalPrice, totalItems: viewModel.totalItems, resetAction: viewModel.resetAllItems)
        }
    }
}

struct ProductsRow: View {
    let food: Food
    @ObservedObject var viewModel: FoodViewModel
    
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
                    viewModel.decrementQuantity(for: food)
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.red)
                }
                Text("\(food.quantity)")
                Button(action: {
                    viewModel.incrementQuantity(for: food)
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
    var resetAction: () -> Void
    
    @Environment(\.openURL) var openURL
    
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
                openURL(URL(string: "https://www.google.com")!)
            }) {
                Text("Pay")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            
            Button(action: {
                resetAction()
            }) {
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

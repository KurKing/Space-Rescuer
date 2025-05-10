//
//  InfoView.swift
//  Space Rescuer
//
//  Created by Oleksii on 01.03.2025.
//

import SwiftUI
import StoreKit

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let productIds = ["very.first", "very.first.subscription"]
    @State private var products: [Product] = []
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 5) {
            
            ZStack {
                
                Text("Space Rescuer")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .padding(.vertical, 10)
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Image("x-button")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                    .padding(.trailing, 20)
                }//:HStack
            } //:ZStack
            .padding(.top, 10)
            
            Form {
                
                Section() {
                    
                    HStack {
                        Text("Product").foregroundColor(.gray)
                        Spacer()
                        Text("Space Rescuer")
                    }//:HStack
                    
                    HStack {
                        Text("Compatibility").foregroundColor(.gray)
                        Spacer()
                        Text("iPhone")
                    }//:HStack
                    
                    HStack {
                        Text("GitHub nick").foregroundColor(.gray)
                        Spacer()
                        Text("KurKing")
                    }//:HStack
                    
                    HStack {
                        
                        let appVersion = Bundle.main
                            .infoDictionary?["CFBundleShortVersionString"] as? String
                        
                        Text("Version").foregroundColor(.gray)
                        Spacer()
                        Text(appVersion ?? "1.0")
                    }//:HStack
                }//:Section #1
                
                Section() {
                    
                    HStack {
                        
                        Text("Max count").foregroundColor(.gray)
                        Spacer()
                        
                        Text("\(MaxCountStorage().count)")
                        
                        Image("astronaut")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.horizontal, 4)
                    }//:HStack
                }//:Section #2
                
                Section("Products") {
                    
                    ForEach(products) { product in
                        
                        Button {
                            
                            print("Buy!!!")
                        } label: {
                            
                            HStack {
                                Text(product.displayName).foregroundColor(.gray)
                                Spacer()
                                Text(product.displayPrice)
                            }//:HStack
                        } //:Button
                    }//:ForEach
                }//:Section #3
            }//:Form
        }//:VStack
        .frame(maxWidth: 640)
        .task {
            try? await self.loadProducts()
        }
    }//:Body
    
    private func loadProducts() async throws {
        products = try await Product.products(for: productIds)
    }
}

struct InfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        InfoView()
    }
}

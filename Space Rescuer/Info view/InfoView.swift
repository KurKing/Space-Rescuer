//
//  InfoView.swift
//  Space Rescuer
//
//  Created by Oleksii on 01.03.2025.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
            }//:Form
        }//:VStack
        .frame(maxWidth: 640)
    }//:Body
}

struct InfoView_Previews: PreviewProvider {
    
    static var previews: some View {
        InfoView()
    }
}

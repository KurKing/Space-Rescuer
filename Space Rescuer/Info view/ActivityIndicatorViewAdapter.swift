//
//  ActivityIndicatorViewAdapter.swift
//  Space Rescuer
//
//  Created by Oleksii on 11.05.2025.
//

import SwiftUI

struct ActivityIndicatorViewAdapter: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorViewAdapter>)
    -> UIActivityIndicatorView {
        .init(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: UIViewRepresentableContext<ActivityIndicatorViewAdapter>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

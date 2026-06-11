//
//  LoadingView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct LoadingView: View {
    let tint: Color

    var body: some View {
        VStack(spacing: 18) {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(tint)
                .scaleEffect(1.5)
            
            Text("Updating weather stats…")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundStyle(tint.opacity(0.8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

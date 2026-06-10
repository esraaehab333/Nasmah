//
//  ErrorView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct ErrorView: View {

    let message: String
    let textColor: Color
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "wifi.slash")
                .font(.system(size: 48))
                .foregroundStyle(textColor.opacity(0.7))

            Text("Something went wrong")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(textColor)

            Text(message)
                .font(.system(size: 14))
                .foregroundStyle(textColor.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Button(action: onRetry) {
                Text("Try Again")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color(hex: "#2d5a27"))
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(.white)
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

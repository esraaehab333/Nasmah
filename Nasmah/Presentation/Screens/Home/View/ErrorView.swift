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
        VStack(spacing: 24) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 54, weight: .light))
                .foregroundStyle(textColor.opacity(0.6))

            VStack(spacing: 8) {
                Text("Connection Interrupted")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(textColor)

                Text(message)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(textColor.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            Button(action: onRetry) {
                Text("Try Again")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(hex: "#2D5A27"))
                    .padding(.horizontal, 36)
                    .padding(.vertical, 14)
                    .background(.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

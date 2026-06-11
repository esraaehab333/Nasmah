//
//  SearchBar.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search for a city…"
    var accentColor: Color = Color(hex: "#A8D5A2")

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(accentColor.opacity(0.8))
                .font(.system(size: 16, weight: .medium))

            TextField("", text: $text, prompt:
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.35))
                    .font(.system(size: 15, design: .rounded))
            )
            .foregroundStyle(.white)
            .font(.system(size: 15, design: .rounded))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .submitLabel(.search)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.white.opacity(0.4))
                        .font(.system(size: 16))
                }
                .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.white.opacity(0.10))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(text.isEmpty ? Color.clear : accentColor.opacity(0.4), lineWidth: 1)
                )
        )
        .animation(.easeInOut(duration: 0.2), value: text.isEmpty)
    }
}

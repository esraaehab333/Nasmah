//
//  HomeToolBarButtns.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct HomeToolbarButtons: View {
    let primaryColor: Color
    let onFavorites: () -> Void
    let onSearch: () -> Void

    var body: some View {
        HStack(spacing: 18) {
            Button(action: onFavorites) {
                Image(systemName: "heart.fill")
                    .foregroundStyle(Color(hex: "#A8D5A2"))
                    .font(.system(size: 20, weight: .medium))
            }
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(primaryColor)
                    .font(.system(size: 20, weight: .medium))
            }
        }
    }
}

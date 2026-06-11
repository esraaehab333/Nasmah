//
//  FavoritesEmptyView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct FavoritesEmptyView: View {
    let vm: SearchViewModel

    var body: some View {
        VStack(spacing: 18) {
            ZStack {
                Circle()
                    .fill(vm.primaryTextColor.opacity(0.07))
                    .frame(width: 84, height: 84)

                Image(systemName: "heart.slash.fill")
                    .font(.system(size: 34, weight: .light))
                    .foregroundStyle(
                        vm.primaryTextColor.opacity(0.3)
                    )
            }

            VStack(spacing: 6) {
                Text("No favorites yet")
                    .font(.system(size: 19,
                                  weight: .bold,
                                  design: .rounded))
                    .foregroundStyle(vm.primaryTextColor)

                Text("Search for a city and tap ♥\nto save it here.")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(
                        vm.secondaryTextColor.opacity(0.6)
                    )
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .padding(.bottom, 60)
    }
}

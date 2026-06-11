//
//  FavoriteLocationRow.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct FavoriteLocationRow: View {
    let location: SavedLocation
    let vm: SearchViewModel
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {

                ZStack {
                    Circle()
                        .fill(vm.accentColor.opacity(0.18))
                        .frame(width: 38, height: 38)

                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(vm.accentColor)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(location.name)
                        .font(.system(size: 16,
                                      weight: .semibold,
                                      design: .rounded))
                        .foregroundStyle(vm.primaryTextColor)

                    Text("\(location.region), \(location.country)")
                        .font(.system(size: 13, design: .rounded))
                        .foregroundStyle(vm.secondaryTextColor)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(
                        vm.primaryTextColor.opacity(0.25)
                    )
            }
            .padding(16)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .fill(vm.cardBackground)
            )
        }
        .buttonStyle(.plain)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

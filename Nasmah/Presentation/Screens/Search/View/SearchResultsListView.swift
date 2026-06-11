//
//  SearchResultsListView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct SearchResultsListView: View {

    @ObservedObject var vm: SearchViewModel
    @Binding var selectedCity: String

    var body: some View {

        List(vm.searchResults, id: \.id) { result in

            Button {
                selectedCity = "\(result.lat),\(result.lon)"
            } label: {

                HStack(spacing: 14) {

                    ZStack {
                        Circle()
                            .fill(vm.accentColor.opacity(0.18))
                            .frame(width: 36, height: 36)

                        Image(systemName: "location.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(vm.accentColor)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text(result.name)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundStyle(vm.primaryTextColor)

                        Text("\(result.region), \(result.country)")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundStyle(vm.secondaryTextColor)
                    }

                    Spacer()

                    Button {
                        vm.saveLocation(result)
                    } label: {
                        Image(
                            systemName: vm.isSaved(result)
                            ? "checkmark.circle.fill"
                            : "plus.circle"
                        )
                        .font(.system(size: 22))
                        .foregroundStyle(
                            vm.isSaved(result)
                            ? vm.accentColor
                            : vm.primaryTextColor.opacity(0.35)
                        )
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 5)
            }
            .listRowBackground(vm.cardBackground)
            .listRowSeparatorTint(vm.primaryTextColor.opacity(0.1))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

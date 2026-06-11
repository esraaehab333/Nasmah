//
//  SearchSavedListView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct SearchSavedListView: View {

    @ObservedObject var vm: SearchViewModel
    @Binding var selectedCity: String

    var body: some View {

        Group {

            if vm.savedLocations.isEmpty {

                SearchSavedEmptyView(vm: vm)

            } else {

                List {

                    Section {

                        ForEach(vm.savedLocations, id: \.name) { location in

                            Button {
                                selectedCity = "\(location.latitude),\(location.longitude)"
                            } label: {

                                HStack(spacing: 14) {

                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundStyle(vm.accentColor)

                                    VStack(alignment: .leading) {
                                        Text(location.name)
                                            .foregroundStyle(vm.primaryTextColor)

                                        Text("\(location.region), \(location.country)")
                                            .foregroundStyle(vm.secondaryTextColor)
                                    }

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                }
                            }
                            .listRowBackground(vm.cardBackground)
                        }
                        .onDelete { vm.deleteLocation(at: $0) }

                    } header: {
                        Text("Saved Locations")
                            .foregroundStyle(vm.secondaryTextColor)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}

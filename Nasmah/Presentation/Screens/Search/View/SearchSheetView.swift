//
//  SearchSheetView.swift
//  Nasmah
//
//  Created by Nemo on 10/06/2026.
//

import SwiftUI

struct SearchSheetView: View {
    @StateObject private var vm: SearchViewModel
    @Environment(\.dismiss) private var dismiss
    let onCitySelected: (String) -> Void
 
    init(conditionCode: Int? = nil, onCitySelected: @escaping (String) -> Void) {
        _vm = StateObject(wrappedValue: SearchViewModel(conditionCode: conditionCode))
        self.onCitySelected = onCitySelected
    }
 
    var body: some View {
        NavigationStack {
            ZStack {
                vm.backgroundColor.ignoresSafeArea()
 
                VStack(spacing: 0) {
                    SearchBar(text: $vm.query, accentColor: vm.accentColor)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
 
                    Divider().background(.white.opacity(0.12))
 
                    ZStack {
                        if vm.isSearching {
                            loadingState
                        } else if let error = vm.errorMessage {
                            errorState(message: error)
                        } else if vm.showSavedLocations {
                            hintState
                        } else if vm.searchResults.isEmpty && vm.query.count >= 2 {
                            emptyResults
                        } else {
                            resultsList
                        }
                    }
                    .animation(.easeInOut(duration: 0.2), value: vm.isSearching)
                    .animation(.easeInOut(duration: 0.2), value: vm.searchResults.count)
                }
            }
            .toolbarBackground(vm.backgroundColor, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(vm.primaryTextColor.opacity(0.8))
                        .fontWeight(.medium)
                }
            }
            .onAppear { vm.loadSavedLocations() }
        }
    }
 
    private var loadingState: some View {
        VStack(spacing: 14) {
            ProgressView().tint(vm.accentColor).scaleEffect(1.2)
            Text("Searching…")
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
 
    private var resultsList: some View {
        List(vm.searchResults, id: \.id) { result in
            Button { onCitySelected("\(result.lat),\(result.lon)") } label: {
                HStack(spacing: 14) {
                    ZStack {
                        Circle().fill(vm.accentColor.opacity(0.18)).frame(width: 36, height: 36)
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
                    Button { vm.saveLocation(result) } label: {
                        Image(systemName: vm.isSaved(result) ? "heart.fill" : "heart")
                            .font(.system(size: 20))
                            .foregroundStyle(vm.isSaved(result) ? vm.accentColor : vm.primaryTextColor.opacity(0.4))
                            .scaleEffect(vm.isSaved(result) ? 1.1 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: vm.isSaved(result))
                    }
                    .buttonStyle(.plain)
                }
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(vm.cardBackground))
            }
            .buttonStyle(.plain)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
 
    private var hintState: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().fill(vm.primaryTextColor.opacity(0.07)).frame(width: 72, height: 72)
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 30, weight: .light))
                    .foregroundStyle(vm.primaryTextColor.opacity(0.35))
            }
            Text("Search for a city")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(vm.primaryTextColor.opacity(0.7))
            Text("Type at least 2 characters to get results.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor.opacity(0.5))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 60)
    }
 
    private var emptyResults: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().fill(vm.primaryTextColor.opacity(0.07)).frame(width: 72, height: 72)
                Image(systemName: "location.slash.fill")
                    .font(.system(size: 28, weight: .light))
                    .foregroundStyle(vm.primaryTextColor.opacity(0.4))
            }
            Text("No results found")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(vm.primaryTextColor.opacity(0.8))
            Text("No cities matched \"\(vm.query)\".\nTry a different spelling.")
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor.opacity(0.6))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 60)
    }
 
    private func errorState(message: String) -> some View {
        VStack(spacing: 16) {
            ZStack {
                Circle().fill(vm.primaryTextColor.opacity(0.07)).frame(width: 72, height: 72)
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 28, weight: .light))
                    .foregroundStyle(vm.primaryTextColor.opacity(0.5))
            }
            Text("Search unavailable")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundStyle(vm.primaryTextColor)
            Text(message)
                .font(.system(size: 13, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 60)
    }
}

//
//  SearchResultRow.swift
//  Nasmah
//
//  Created by Nemo on 13/06/2026.
//

import SwiftUI

struct SearchResultRow: View {
    let result: SearchResult
    let vm: SearchViewModel
 
    var body: some View {
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
                Image(systemName: vm.isSaved(result) ? "checkmark.circle.fill" : "plus.circle")
                    .font(.system(size: 22))
                    .foregroundStyle(vm.isSaved(result) ? vm.accentColor : vm.primaryTextColor.opacity(0.35))
                    .scaleEffect(vm.isSaved(result) ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: vm.isSaved(result))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 5)
    }
}
 

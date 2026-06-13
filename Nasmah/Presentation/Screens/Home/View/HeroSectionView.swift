//
//  HeroSectionView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//

import SwiftUI

struct HeroSectionView: View {
    @ObservedObject var vm: HomeViewModel
    let heroHeight: CGFloat
 
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Spacer().frame(height: 110)
 
            Text(vm.cityName)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(vm.primaryTextColor)
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
 
            Text("\(vm.tempInt)°")
                .font(.system(size: 96, weight: .ultraLight, design: .rounded))
                .foregroundStyle(vm.primaryTextColor)
                .padding(.vertical, -10)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
 
            Text(vm.condition)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundStyle(vm.secondaryTextColor)
 
            Spacer().frame(height: 110)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: heroHeight - 100, alignment: .leading)
        .padding(.horizontal, 24)
    }
}

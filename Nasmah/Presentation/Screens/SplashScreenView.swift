//
//  SplashScreenView.swift
//  Nasmah
//
//  Created by Nemo on 11/06/2026.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var opacity: Double = 0
    @State private var isFinished = false

    var body: some View {
        if isFinished {
            HomeView()
        } else {
            ZStack {
                AppTheme().backgroundColor
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 28, style: .continuous)
                            .fill(.white.opacity(0.12))
                            .frame(width: 100, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 28, style: .continuous)
                                    .stroke(.white.opacity(0.2), lineWidth: 1)
                            )
                        Image(systemName: "wind")
                            .font(.system(size: 44, weight: .light))
                            .foregroundStyle(.white)
                    }

                    Text("Nasmah")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                }
                .opacity(opacity)
            }
            .onAppear {
                withAnimation(.easeIn(duration: 0.6)) {
                    opacity = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        opacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isFinished = true
                    }
                }
            }
        }
    }
}

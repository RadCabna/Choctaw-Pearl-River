//
//  Loading.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 09.04.2025.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var loadingProgress: CGFloat = 1
    @State private var logoOpacity: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                ZStack {
                    Image("loadingBG")
                        .resizable()
                        .scaledToFill()
//                        .ignoresSafeArea()
                        .frame(width: height*1.12, height: width*1.1)
                    VStack {
                       Image("loadingLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: width*0.25)
                            .opacity(logoOpacity)
                        Spacer()
                        Image("loadingText")
                             .resizable()
                             .scaledToFit()
                             .frame(height: width*0.04)
                             .padding(.bottom)
                             .opacity(logoOpacity)
                        ZStack {
                            Image("loadBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(height: width*0.05)
                            Image("loadBarFront")
                                .resizable()
                                .scaledToFit()
                                .frame(height: width*0.029)
                                .offset(x: -height*0.75*loadingProgress)
                                .mask(
                                    Image("loadBarFront")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: width*0.029)
                                )
                        }
                        .opacity(logoOpacity)
                    }
                    .padding(.vertical, width*0.08)
                }
                .rotationEffect(Angle(degrees: 90))
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                ZStack {
                    Image("loadingBG")
                        .resizable()
                        .ignoresSafeArea()
                    VStack {
                       Image("loadingLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: height*0.25)
                            .opacity(logoOpacity)
                        Spacer()
                        Image("loadingText")
                             .resizable()
                             .scaledToFit()
                             .frame(height: height*0.04)
                             .padding(.bottom)
                             .opacity(logoOpacity)
                        ZStack {
                            Image("loadBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height*0.05)
                            Image("loadBarFront")
                                .resizable()
                                .scaledToFit()
                                .frame(height: height*0.029)
                                .offset(x: -width*0.75*loadingProgress)
                                .mask(
                                    Image("loadBarFront")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: height*0.029)
                                )
                        }
                        .opacity(logoOpacity)
                    }
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        .onAppear{
            loadingAnimation()
        }
        
    }
    
    func loadingAnimation() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            logoOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.easeInOut(duration: 3)) {
                loadingProgress = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            coordinator.navigate(to: .mainMenu)
        }
    }
    
}

#Preview {
    Loading()
}

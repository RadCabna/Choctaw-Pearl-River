//
//  Achievements.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 16.04.2025.
//

import SwiftUI

struct Achievements: View {
    @AppStorage("count") var count = 0
    @Binding var showAchievements: Bool
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0,0,0,0,0,0]
    var body: some View {
        ZStack {
            Image("settingsBack")
                .resizable()
                .ignoresSafeArea()
            HStack {
                Image("arrowBack")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.07)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading)
                    .onTapGesture {
                        showAchievements.toggle()
                    }
                Image("countFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.08)
                    .scaleEffect(x: -1)
                    .overlay(
                        Text("\(count)")
                            .font(Font.custom("PassionOne-Black", size: screenHeight*0.03))
                            .foregroundColor(Color("numberColor"))
                            .shadow(color: .black, radius: 3, x: -2, y: 2)
                            .offset(x: -screenHeight*0.026)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.trailing)
            }
            ScrollView(showsIndicators: false) {
                VStack {
                    Image("basicText")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.025)
                        .padding(.bottom)
                    HStack(spacing: screenWidth*0.08) {
                        Image("acieve1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[0] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                        Image("acieve2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[1] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                    }
                    HStack(spacing: screenWidth*0.08) {
                        Image("acieve3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[2] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                        Image("acieve4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[3] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                    }
                    Image("acieve5")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenHeight*0.15)
                        .overlay(
                            ZStack {
                                if achievementsData[4] == 1 {
                                    Image("achiveDone")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.05)
                                        .offset(y: screenHeight*0.06)
                                }
                            }
                        )
                    Image("trialsText")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.025)
                        .padding(.vertical)
                    HStack(spacing: screenWidth*0.08) {
                        Image("acieve6")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[5] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                        Image("acieve7")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[6] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                    }
                    HStack(spacing: screenWidth*0.08) {
                        Image("acieve8")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[7] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                        Image("acieve9")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.15)
                            .overlay(
                                ZStack {
                                    if achievementsData[8] == 1 {
                                        Image("achiveDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.05)
                                            .offset(y: screenHeight*0.06)
                                    }
                                }
                            )
                    }
                    Image("acieve10")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenHeight*0.15)
                        .overlay(
                            ZStack {
                                if achievementsData[9] == 1 {
                                    Image("achiveDone")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.05)
                                        .offset(y: screenHeight*0.06)
                                }
                            }
                        )
                }
                .padding(.bottom, screenHeight*0.2)
            }
            .offset(y: screenHeight*0.19)
            Image("achievementsText")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.075)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, screenHeight*0.1)
           
        }
    }
}

#Preview {
    Achievements(showAchievements: .constant(true))
}

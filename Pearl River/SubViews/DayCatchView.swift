//
//  DayCatchView.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 10.04.2025.
//

import SwiftUI

struct DayCatchView: View {
    @AppStorage("dayNumber") var dayNumber = 0
    @Binding var showCatchDay: Bool
    var body: some View {
        ZStack {
            Image("settingsBack")
                .resizable()
                .ignoresSafeArea()
            Image("arrowBack")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.07)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    showCatchDay.toggle()
                }
            VStack {
                Image("catchDayLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.25)
                Image("catchDayFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.45)
                    .overlay(
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: screenHeight*0.015) {
                            ForEach(0..<25, id: \.self) { index in
                                if index+1 <= dayNumber {
                                    ZStack {
                                        Image("activeCatchFrame")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.055)
                                            .overlay(
                                                Text("\(index+1)")
                                                    .font(Font.custom("PassionOne-Black", size: screenHeight*0.03))
                                                    .foregroundColor(Color("numberColor"))
                                            )
                                        Image("dayCatchDone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.035)
                                            .offset(y: screenHeight*0.02)
                                    }
                                } else {
                                    Image("disactiveCatchFrame")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.055)
                                        .overlay(
                                        Text("\(index+1)")
                                            .font(Font.custom("PassionOne-Black", size: screenHeight*0.03))
                                            .foregroundColor(Color("numberColor"))
                                        )
                                }
                            }
                        }
                            .offset(y: screenHeight*0.025)
                            .padding(.horizontal)
                    )
                    .offset(y:-screenHeight*0.1)
            }
        }
        
        .onAppear{
            if dayNumber < 25 {
                dayNumber += 1
            }
        }
        
    }
}

#Preview {
    DayCatchView(showCatchDay: .constant(true))
}

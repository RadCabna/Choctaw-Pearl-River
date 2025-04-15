//
//  DailyQuest.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 11.04.2025.
//

import SwiftUI

struct DailyQuest: View {
    @AppStorage("count") var count = 0
    @Binding var showQuest: Bool
    @State private var questData = UserDefaults.standard.array(forKey: "questData") as? [Int] ?? [0,0,0,0,0]
    @State private var questArray = Arrays.questsArray
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
                        showQuest.toggle()
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
                    .onTapGesture {
                        count += 100
                    }
            }
            Image("questFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.6)
                .overlay(
                    VStack(spacing: screenHeight*0.015) {
                        ForEach(0..<questArray.count, id: \.self) { item in
                            HStack {
                                Image("questLongFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.058)
                                    .overlay(
                                        Text(questArray[item].name)
                                            .font(Font.custom("PassionOne-Black", size: screenHeight*0.021))
                                            .foregroundColor(Color.blue)
                                            .shadow(color: .white, radius: 3, x: -2, y: 2)
                                            .multilineTextAlignment(.center)
                                    )
                                Image("questShortFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.058)
                                    .overlay(
                                        ZStack {
                                            if questData[item] >= questArray[item].target {
                                             Image("dayCatchDone")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.045)
                                            } else {
                                                Text("\(questData[item]) \\ \(questArray[item].target)")
                                                    .font(Font.custom("PassionOne-Black", size: item == 0 ? screenHeight*0.02 : item == 4 ? screenHeight*0.013 : screenHeight*0.023))
                                                    .foregroundColor(Color.red)
                                                    .shadow(color: .white, radius: 3, x: -2, y: 2)
                                            }
                                        }
                                    )
                            }
                        }
                    }
                        .offset(y: screenHeight*0.07)
                )
        }
    }
}

#Preview {
    DailyQuest(showQuest: .constant(true))
}

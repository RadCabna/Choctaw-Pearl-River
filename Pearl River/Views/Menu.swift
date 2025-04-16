//
//  Menu.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 09.04.2025.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("count") var count = 0
    @AppStorage("fishCount") var fishCount = 0
    @AppStorage("sound") var sound = true
    @AppStorage("vibration") var vibration = true
    @AppStorage("music") var music = true
    @State private var showCatchDay = false
    @State private var showSettings = false
    @State private var showShop = false
    @State private var showDaily = false
    @State private var showAchievements = false
    @State private var remainingTime: TimeInterval = 24 * 60 * 60
    @State private var isButtonActive = false
    @State private var timer: Timer?
    private let savedRemainingTimeKey = "savedRemainingTime"
    private let lastSaveTimestampKey = "lastSaveTimestamp"
    var body: some View {
        ZStack {
            Image("menuBG")
                .resizable()
                .ignoresSafeArea()
            Image("menuLogo1")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.12)
                .offset(y: -screenHeight*0.22)
            VStack {
                Spacer()
                Image("playButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.14)
                    .padding(.bottom)
                    .onTapGesture {
                        SoundManager.instance.stopAllSounds()
                        coordinator.navigate(to: .game)
                    }
                HStack {
                    Image("achievementsButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.12)
                        .offset(y: screenHeight*0.02)
                        .onTapGesture {
                            showAchievements.toggle()
                        }
                    Spacer()
                    Image("shopButton")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.16)
                        .onTapGesture {
                            showShop.toggle()
                        }
                }
                .padding(.horizontal)
            }
            VStack(alignment: .leading) {
                Image("countFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.08)
                    .overlay(
                    Text("\(count)")
                        .font(Font.custom("PassionOne-Black", size: screenHeight*0.03))
                        .foregroundColor(Color("numberColor"))
                        .shadow(color: .black, radius: 3, x: -2, y: 2)
                        .offset(x: screenHeight*0.026)
                    )
                Image("fishCountButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.07)
                    .overlay(
                    Text("\(fishCount)")
                        .font(Font.custom("PassionOne-Black", size: screenHeight*0.025))
                        .foregroundColor(Color("numberColor"))
                        .shadow(color: .black, radius: 3, x: -2, y: 2)
                        .offset(x: screenHeight*0.035)
                    )
                Image("dailyButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.12)
                    .onTapGesture {
                        showDaily.toggle()
                    }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
            .padding(.leading)
            VStack(alignment: .trailing) {
                Image("settingsButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.08)
                    .onTapGesture {
                        showSettings.toggle()
                    }
                Image("calendrButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.1)
                    .overlay(
//                    Text(buttonText)
//                        .font(Font.custom("PassionOne-Black", size: screenHeight*0.01))
//                        .foregroundColor(Color.red)
//                        .offset(y: screenHeight*0.036)
                    ZStack {
                        if isButtonActive {
                            Text("OPEN")
                                .font(Font.custom("PassionOne-Black", size: screenHeight*0.01))
                                .foregroundColor(Color.red)
                        } else {
                            Text(buttonText)
                                .font(Font.custom("PassionOne-Black", size: screenHeight*0.01))
                                .foregroundColor(Color.red)
                        }
                    }
                        .offset(y: screenHeight*0.036)
                    )
                    .onTapGesture {
                        showCatchDay.toggle()
                        resetTimer()
                    }
                    .disabled(!isButtonActive)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing)
            
            if showSettings {
                Settings(showSettings: $showSettings)
            }
            if showCatchDay {
                DayCatchView(showCatchDay: $showCatchDay)
            }
            if showDaily {
                DailyQuest(showQuest: $showDaily)
            }
            if showShop {
                Shop(showShop: $showShop)
            }
            if showAchievements {
               Achievements(showAchievements: $showAchievements)
            }
        }
        
        .onAppear {
            loadTimerState()
            if music {
                SoundManager.instance.playSound(sound: "riverSoundMain")
            }
        }
        .onDisappear {
                    saveTimerState()
                }
        
    }
    
    private func loadTimerState() {
        let savedRemainingTime = UserDefaults.standard.double(forKey: savedRemainingTimeKey)
        let lastSaveTimestamp = UserDefaults.standard.double(forKey: lastSaveTimestampKey)
        
        if savedRemainingTime > 0 {
            let currentTime = Date().timeIntervalSince1970
            let timePassed = currentTime - lastSaveTimestamp
            
            remainingTime = max(savedRemainingTime - timePassed, 0)
            
            if remainingTime <= 0 {
                isButtonActive = true
                return
            }
        }
        
        startTimer()
    }
    
    private var buttonText: String {
            if isButtonActive {
                return "MENU"
            } else {
                let hours = Int(remainingTime) / 3600
                let minutes = (Int(remainingTime) % 3600) / 60
                let seconds = Int(remainingTime) % 60
                return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
    
    private func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                isButtonActive = true
            }
        }
    }
    
    private func resetTimer() {
        isButtonActive = false
        remainingTime = 24 * 60 * 60
        startTimer()
    }
    
    private func saveTimerState() {
        UserDefaults.standard.set(remainingTime, forKey: savedRemainingTimeKey)
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: lastSaveTimestampKey)
        
        timer?.invalidate()
    }
    
}

#Preview {
    Menu()
}

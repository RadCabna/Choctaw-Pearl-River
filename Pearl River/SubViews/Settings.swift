//
//  Settings.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 10.04.2025.
//

import SwiftUI

struct Settings: View {
    @AppStorage("sound") var sound = true
    @AppStorage("vibration") var vibration = true
    @AppStorage("music") var music = true
    @Binding var showSettings: Bool
    var body: some View {
        ZStack {
            Image("settingsBack")
                .resizable()
                .ignoresSafeArea()
            Image("settingsFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.55)
                .overlay(
                    VStack(spacing: screenHeight*0.02) {
                        HStack {
                            VStack {
                                Image("soundText")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.02)
                                Image("sound")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.08)
                            }
                            Spacer()
                            Toggle("", isOn: $sound)
                                .toggleStyle(CustomToggle())
                                .offset(y:screenHeight*0.015)
                        }
                        .padding(.horizontal, screenHeight*0.05)
                        HStack {
                            VStack {
                                Image("musicText")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.02)
                                Image("music")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.08)
                            }
                            Spacer()
                            Toggle("", isOn: $music)
                                .toggleStyle(CustomToggle())
                                .offset(y:screenHeight*0.015)
                        }
                        .padding(.horizontal, screenHeight*0.05)
                        HStack {
                            VStack {
                                Image("vibraText")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.02)
                                Image("vibration")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.08)
                            }
                            Spacer()
                            Toggle("", isOn: $vibration)
                                .toggleStyle(CustomToggle())
                                .offset(y:screenHeight*0.015)
                        }
                        .padding(.horizontal, screenHeight*0.05)
                    }
                        .offset(y: -screenHeight*0.02)
                )
            Image("rateUsButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.17)
                .offset(y: screenHeight*0.28)
                .onTapGesture {
                    openAppStoreForRating()
                }
            Image("arrowBack")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.07)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    showSettings.toggle()
                }
        }
        
        .onChange(of: music) { _ in
            if !music {
                SoundManager.instance.stopAllSounds()
            } else {
                SoundManager.instance.stopAllSounds()
                SoundManager.instance.playSound(sound: "riverSoundMain")
            }
        }
        
    }
    
    func openAppStoreForRating() {
        guard let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id6744639152?action=write-review") else {
            return
        }
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
}

#Preview {
    Settings(showSettings: .constant(true))
}

struct CustomToggle: ToggleStyle {
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack {
               Image("toggleBack")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenWidth * 0.15)
                VStack {
                    Image(configuration.isOn ? "on" : "off")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.02)
                    .offset(x: configuration.isOn ? screenWidth * 0.05 : -screenWidth * 0.05)
                    Image(configuration.isOn ? "toggle" : "toggle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenWidth*0.16)
                        .offset(x: configuration.isOn ? screenWidth * 0.05 : -screenWidth * 0.05)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                    
                }
                .offset(y: -screenHeight*0.015)
            }
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

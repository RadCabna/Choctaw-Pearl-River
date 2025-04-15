//
//  GameFinish.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 16.04.2025.
//

import SwiftUI

struct GameFinish: View {
    @EnvironmentObject var coordinator: Coordinator
    @Binding var gameCount: Int
    @Binding var gameFinish: Bool
    var body: some View {
        ZStack {
            Image("gameFinishBG")
                .resizable()
                .ignoresSafeArea()
            Text("+ \(gameCount)")
                .font(Font.custom("PassionOne-Black", size: screenHeight*0.05))
                .foregroundColor(Color("numberColor"))
                .shadow(color: .black, radius: 3, x: -2, y: 2)
                .offset(x: screenHeight*0.085, y: -screenHeight*0.116)
            VStack {
                Image("finishButtonNext")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.1)
                    .onTapGesture {
                        gameFinish.toggle()
                    }
                Image("finishButtonHome")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.1)
                    .onTapGesture {
                        coordinator.navigate(to: .mainMenu)
                    }
            }
            .offset(x: screenWidth*0.14, y: screenHeight*0.04)
        }
    }
}

#Preview {
    GameFinish(gameCount: .constant(100), gameFinish: .constant(true))
}

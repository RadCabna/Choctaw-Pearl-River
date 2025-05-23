//
//  Game.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 09.04.2025.
//

import SwiftUI

struct Game: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("count") var count = 0
    @AppStorage("fishCount") var fishCount = 0
    @AppStorage("enableFishCount") var enableFishCount = 1
    @AppStorage("menNumber") var menNumber = 1
    @AppStorage("sound") var sound = true
    @AppStorage("vibration") var vibration = true
    @AppStorage("music") var music = true
    @State private var bgName = "gameBG1"
    @State private var menName = "men1"
    @State private var lineSize: CGFloat = 0
    @State private var lineOffsetY: CGFloat = 0
    @State private var menOffsetX: CGFloat = 0
    @State private var countInSet = 0
    @State private var enableFishCountInARow = 1
    @State private var isFishCaught = false
    @State private var diveDepth: CGFloat = 0
    @State private var isDiving = false
    @State private var isGoingUp = false
    @State private var fishArray = Arrays.fishArray
    @State private var startFishArray = Arrays.fishArray
    @State private var fishHorizontallOffset: CGFloat = -50
    @State private var fishVerticalOffset: CGFloat = 0
    @State private var fishRotation: CGFloat = 0
    @State private var fishMirror: CGFloat = 1
    @State private var timer: Timer? = nil
    @State private var deepTimer: Timer? = nil
    @State private var fishTimer: Timer? = nil
    @State private var catchFishNameArray: [SwimingFish] = []
    @State private var gameFinish = false
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0,0,0,0,0,0]
    private var totalImageHeight: CGFloat {
        screenHeight * 3
    }
    private var maxDiveDepth: CGFloat {
        screenHeight * 2
    }
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    ZStack {
                        Image(bgName)
                            .resizable()
                            .frame(width: geometry.size.width,
                                   height: self.totalImageHeight)
                    }
                    .offset(y: -self.diveDepth)
                    ZStack{
                        Rectangle()
                            .frame(width: 2, height:self.diveDepth+lineSize)
                            .foregroundColor(.white)
                            .offset(x: screenWidth*0.69, y:lineOffsetY - self.diveDepth*0.5)
                        Image("hook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight*0.025)
                            .offset(x: screenWidth*0.7, y:screenHeight*0.34)
                        ForEach(0..<catchFishNameArray.count, id: \.self) { item in
                            Image(catchFishNameArray[item].name)
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*catchFishNameArray[item].size)
                                .rotationEffect(Angle(degrees: catchFishNameArray[item].side < 0 ? 90 : -90))
                                .offset(x: screenWidth*0.7, y:screenHeight*0.34)
                            }
                    }
                    .position(x: 0,
                              y: geometry.size.height / 2)
                    ZStack {
                        Image("boat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.6)
                            .offset(x: screenWidth*0.3, y: screenHeight*0.3 - self.diveDepth)
                        
                        Image(menName)
                            .resizable()
                            .frame(width: screenWidth*0.55, height: screenHeight*0.17)
                            .offset(x: screenWidth*0.42, y: screenHeight*0.216 - self.diveDepth)
                        
                    }
                    .position(x: 0,
                              y: geometry.size.height / 2)
                    
                    VStack {
                        HStack {
                            Image("arrowBack")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.07)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading)
                                .onTapGesture {
                                    coordinator.navigate(to: .mainMenu)
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
                        .padding(.top, screenHeight*0.06)
                    }
                    ZStack {
                        ForEach(0..<10, id: \.self) { item in
                            Image(fishArray[item].name)
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*fishArray[item].size)
                                .scaleEffect(x: fishArray[item].mirror)
                                .rotationEffect(Angle(degrees: fishArray[item].rotation))
                                .offset(
                                    x: fishArray[item].horizontalOffset*screenWidth,
                                    y: fishArray[item].verticalOffset*screenHeight - diveDepth
                                )
                                .opacity(fishArray[item].opacity)
                        }
                    }
                    .position(x: 0,
                              y: geometry.size.height / 2)
                    ZStack {
                        HStack {
                            Button(action: {
                                self.handleButtonAction()
                            }) {
                                Image("dropHookButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.1)
                            }
                            .disabled(catchFishNameArray.count != 0)
                            Image("fishCountGameButton")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.094)
                                .overlay(
                                    Text("\(enableFishCountInARow)")
                                        .font(Font.custom("PassionOne-Black", size: screenHeight*0.03))
                                        .foregroundColor(Color("numberColor"))
                                        .offset(x: screenHeight*0.02, y: screenHeight*0.02)
                                )
                        }
                    }
                    .position(x: geometry.size.width / 2,
                              y: geometry.size.height / 2)
                    .offset(x: -screenWidth*0.2, y: screenHeight*0.4)
                    ZStack {
                        if gameFinish {
                            GameFinish(gameCount: $countInSet, gameFinish: $gameFinish)
                        }
                           
                    }
                    .position(x: geometry.size.width / 2,
                              y: geometry.size.height / 2)
                    .frame(maxHeight: screenHeight)
                }
                
                
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        
        .onChange(of: isFishCaught) { _ in
            if isFishCaught {
                fishTimer?.invalidate()
                fishTimer = nil
            }
        }
        
        .onChange(of: diveDepth) { _ in
                checkFishInHook()
        }
        
        .onChange(of: gameFinish) { _ in
            if !gameFinish {
                resetGame()
            }
        }
        
        .onAppear {
            enableFishCountInARow = enableFishCount
            menUpdate()
            fishArray.shuffle()
            startFishArray = fishArray
            startTimer()
            print(screenWidth)
            print(screenHeight)
        }
    }
    
    func menUpdate() {
        switch menNumber {
        case 1:
            bgName = "gameBG1"
            menName = "men1"
        lineSize = screenHeight*0.085
        lineOffsetY = screenHeight*0.28
        case 2:
            bgName = "gameBG2"
            menName = "men2"
            lineSize = screenHeight*0.17
            lineOffsetY = screenHeight*0.232
        case 3:
            bgName = "gameBG3"
            menName = "men3"
            lineSize = screenHeight*0.135
            lineOffsetY = screenHeight*0.255
        case 4:
            bgName = "gameBG4"
            menName = "men4"
            lineSize = screenHeight*0.165
            lineOffsetY = screenHeight*0.24
        case 5:
            bgName = "gameBG1"
            menName = "men5"
            lineSize = screenHeight*0.17
            lineOffsetY = screenHeight*0.23
        case 6:
            bgName = "gameBG2"
            menName = "men6"
            lineSize = screenHeight*0.18
            lineOffsetY = screenHeight*0.226
        default:
            bgName = "gameBG1"
            menName = "men1"
            lineSize = screenHeight*0.085
            lineOffsetY = screenHeight*0.28
        }
    }
    
    func resetGame() {
        stopTimer()
        countInSet = 0
        fishArray = Arrays.fishArray
        fishArray.shuffle()
        startFishArray = fishArray
        startTimer()
    }
    
    func checkFishOnHook() {
        if !isDiving && !isGoingUp && catchFishNameArray.count != 0 {
            for i in 0..<catchFishNameArray.count {
                count += catchFishNameArray[i].cost
                countInSet += catchFishNameArray[i].cost
                fishCount += 1
                achievementsData[0] = 1
                achievementsData[1] = 1
                UserDefaults.standard.setValue(achievementsData, forKey: "achievementsData")
            }
            catchFishNameArray.removeAll()
            enableFishCountInARow = enableFishCount
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameFinish.toggle()
            }
        }
    }
    
    func checkFishInHook() {
        for i in 0..<10 {
            if !fishArray[i].fishCatch && fishArray[i].horizontalOffset > 0.65 && fishArray[i].horizontalOffset < 0.75 &&
                fishArray[i].verticalOffset > 0.3 + (diveDepth/screenHeight) && fishArray[i].verticalOffset < 0.4 + (diveDepth/screenHeight) && enableFishCountInARow > 0 {
                fishArray[i].fishCatch = true
                catchFishNameArray.append(startFishArray[i])
                stopMoving()
                goingUp()
                enableFishCountInARow -= 1
                fishArray[i].opacity = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    fishArray[i].opacity = 1
                    fishArray[i].fishCatch = false
//                    fishArray.removeAll()
                }
            }
        }
    }
    
    func fishSwimingAnimation() {
        fishArray = Arrays.fishArray
        fishArray.shuffle()
        startFishArray = fishArray
        for i in 0..<10 {
            if !fishArray[i].fishCatch {
                if fishArray[i].horizontalOffset <= -0.3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + fishArray[i].delay) {
                        fishArray[i].timer = Timer.scheduledTimer(withTimeInterval: 0.02 + fishArray[i].speed, repeats: true) { _ in
                            if fishArray[i].horizontalOffset <= 1.3 {
                                fishArray[i].horizontalOffset += 1.3*0.005
                            } else {
                                fishArray[i].timer?.invalidate()
                                fishArray[i].timer = nil
                                fishArray[i].mirror *= -1
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + fishArray[i].delay) {
                        fishArray[i].timer = Timer.scheduledTimer(withTimeInterval: 0.02 + fishArray[i].speed, repeats: true) { _ in
                            if fishArray[i].horizontalOffset >= -0.3 {
                                fishArray[i].horizontalOffset -= 1.3*0.005
                            } else {
                                fishArray[i].timer?.invalidate()
                                fishArray[i].timer = nil
                                fishArray[i].mirror *= -1
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            fishSwimingAnimation()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func handleButtonAction() {
        if !isDiving && !isGoingUp {
            if sound {
                SoundManager.instance.playSound(sound: "dropSound")
                SoundManager.instance.playSound(sound: "dropWaterSound")
            }
            if vibration {
                generateImpactFeedback(style: .medium)
            }
            goingDown()
            isDiving = true
        } else if isDiving && !isGoingUp {
            stopMoving()
            goingUp()
            if sound {
                SoundManager.instance.stopAllSounds()
                SoundManager.instance.playSound(sound: "catchSound")
            }
            isDiving = false
            isGoingUp = true
            
        }
        
    }
    
    func goingDown() {
        deepTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if diveDepth < maxDiveDepth-10 {
                diveDepth += maxDiveDepth/700
            } else {
                if sound {
                    SoundManager.instance.stopAllSounds()
                    SoundManager.instance.playSound(sound: "catchSound")
                }
                if vibration {
                    generateImpactFeedback(style: .heavy)
                }
                stopMoving()
                goingUp()
                achievementsData[3] = 1
                UserDefaults.standard.setValue(achievementsData, forKey: "achievementsData")
            }
        }
    }
    
    func goingUp() {
        deepTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if diveDepth > 10 {
                diveDepth -= maxDiveDepth/700
            } else {
                stopMoving()
                SoundManager.instance.stopAllSounds()
                self.isDiving = false
                self.isGoingUp = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    checkFishOnHook()
                }
            }
        }
    }
    
    func stopMoving() {
        deepTimer?.invalidate()
        deepTimer = nil
    }
    
    private func startDescent() {
        self.isDiving = true
        self.isGoingUp = false
        
        goingDown()
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            if !self.isGoingUp {
                self.startAscent()
            }
        }
    }
    
    private func startAscent() {
        self.isGoingUp = true
        
        deepTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if diveDepth > 10 {
                diveDepth -= maxDiveDepth/700
            } else {
                stopMoving()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            self.isDiving = false
            self.isGoingUp = false
        }
    }
    
    func generateImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        if vibration {
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
}

#Preview {
    Game()
}

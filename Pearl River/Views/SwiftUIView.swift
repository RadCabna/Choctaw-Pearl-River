//
//  SwiftUIView.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 14.04.2025.
//

import SwiftUI

struct OceanView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var isScrolling = false
    private let oceanHeight: CGFloat = UIScreen.main.bounds.height * 3
    
    // Рыбы с фиксированными глубинами (относительно фона)
    @State private var fishes: [Fish] = [
        Fish(depth: 0.3, direction: .right, xOffset: 0), // depth - относительная позиция (0-1)
        Fish(depth: 0.6, direction: .left, xOffset: 100),
        Fish(depth: 0.9, direction: .right, xOffset: 200)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Фон океана
                Image("gameBG1")
                    .resizable()
                    .frame(width: geometry.size.width, height: oceanHeight)
                    .offset(y: -scrollOffset)
                
                // Рыбы
                ForEach($fishes) { $fish in
                    FishView(direction: fish.direction)
                        .offset(x: fish.xOffset, y: fish.depth * oceanHeight - scrollOffset)
                }
                
                // Кнопка управления
                VStack {
                    Button(action: toggleScrolling) {
                        Text(isScrolling ? "Стоп" : "Начать погружение")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }
            }
            .frame(width: geometry.size.width)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            startFishAnimations()
        }
    }
    
    func startFishAnimations() {
        // Запускаем анимацию для каждой рыбы
        for index in fishes.indices {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                DispatchQueue.main.async {
                    let screenWidth = UIScreen.main.bounds.width
                    let speed: CGFloat = 2.0
                    
                    withAnimation(.linear(duration: 0.05)) {
                        switch fishes[index].direction {
                        case .right:
                            fishes[index].xOffset += speed
                            if fishes[index].xOffset > screenWidth {
                                fishes[index].xOffset = -60
                            }
                        case .left:
                            fishes[index].xOffset -= speed
                            if fishes[index].xOffset < -60 {
                                fishes[index].xOffset = screenWidth
                            }
                        }
                    }
                }
            }
        }
    }
    
    func toggleScrolling() {
        isScrolling.toggle()
        
        withAnimation(.linear(duration: 10)) {
            scrollOffset = isScrolling ?
                oceanHeight - UIScreen.main.bounds.height :
                0
        }
    }
}

struct Fish: Identifiable {
    let id = UUID()
    let depth: CGFloat // Относительная глубина (0-1)
    let direction: Direction
    var xOffset: CGFloat
    
    enum Direction {
        case left, right
    }
}

struct FishView: View {
    let direction: Fish.Direction
    
    var body: some View {
        Image("fish3")
            .resizable()
            .scaledToFit()
            .frame(width: 60)
            .scaleEffect(x: direction == .right ? 1 : -1)
    }
}

#Preview {
    OceanView()
}

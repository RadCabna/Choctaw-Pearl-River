//
//  Model.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 09.04.2025.
//

import Foundation
import SwiftUI

struct ShopItem: Equatable {
    var name: String
    var itemPrice: Int
}

struct Quest {
    var name: String
    var target: Int
}

struct SwimingFish {
    var name: String
    var horizontalOffset: CGFloat
    var verticalOffset: CGFloat
    var rotation: CGFloat = 0
    var mirror: CGFloat = 1
    var timer: Timer? = nil
    var isItTrash = false
    var fishCatch = false
    var delay: TimeInterval = 0
    var speed: TimeInterval = 0
    var side: CGFloat = 1
    var opacity: CGFloat = 1
    var cost: Int
    var size: CGFloat
}



class Arrays {
    
    
    static var fishArray: [SwimingFish] = [
        SwimingFish(name: "fish1", horizontalOffset: -0.3, verticalOffset: 0.8, delay: 1.5, speed: -0.001, side: 1, cost: 5, size: 0.05),
        SwimingFish(name: "fish2", horizontalOffset: -0.3, verticalOffset: 0.9, delay: 2.1, speed: -0.007, side: 1, cost: 5, size: 0.05),
        SwimingFish(name: "fish3", horizontalOffset: -0.3, verticalOffset: 1, delay: 0.9, speed: -0.002, side: 1, cost: 5, size: 0.05),
        SwimingFish(name: "fish4", horizontalOffset: 1.3, verticalOffset: 1.1, delay: 0.3, speed: -0.008, side: -1, cost: 5, size: 0.05),
        SwimingFish(name: "fish5", horizontalOffset: 1.3, verticalOffset: 1.2, delay: 1.5, speed: -0.009, side: -1, cost: 10, size: 0.06),
        SwimingFish(name: "fish6", horizontalOffset: 1.3, verticalOffset: 1.15, delay: 2.6, speed: -0.01, side: -1, cost: 10, size: 0.05),
        SwimingFish(name: "fish7", horizontalOffset: 1.3, verticalOffset: 1.25, delay: 1.8, speed: -0.005, side: -1, cost: 10, size: 0.06),
        SwimingFish(name: "fish8", horizontalOffset: 1.3, verticalOffset: 1.3, delay: 2.3, speed: -0.003, side: -1, cost: 10, size: 0.06),
        SwimingFish(name: "fish9", horizontalOffset: 1.3, verticalOffset: 1.35, delay: 1.4, speed: -0.01, side: -1, cost: 15, size: 0.07),
        SwimingFish(name: "fish10", horizontalOffset: 1.3, verticalOffset: 1.4, delay: 3.3, speed: -0.004, side: -1, cost: 15, size: 0.07),
        SwimingFish(name: "fish11", horizontalOffset: 1.3, verticalOffset: 1.45, delay: 2.3, speed: -0.005, side: -1, cost: 15, size: 0.07),
        SwimingFish(name: "fish12", horizontalOffset: 1.3, verticalOffset: 1.5, delay: 1, speed: -0.002, side: -1, cost: 15, size: 0.07),
        SwimingFish(name: "fish13", horizontalOffset: -0.3, verticalOffset: 1.55, delay: 1.1, speed: -0.001, side: 1, cost: 20, size: 0.08),
        SwimingFish(name: "fish14", horizontalOffset: 1.3, verticalOffset: 1.6, delay: 2.1, speed: -0.006, side: -1, cost: 20, size: 0.08),
        SwimingFish(name: "fish15", horizontalOffset: 1.3, verticalOffset: 1.65, delay: 2.4, speed: -0.001, side: -1, cost: 20, size: 0.08),
        SwimingFish(name: "fish16", horizontalOffset: -0.3, verticalOffset: 1.7, delay: 3.2, speed: -0.003, side: 1, cost: 20, size: 0.08),
        SwimingFish(name: "fish17", horizontalOffset: -0.3, verticalOffset: 1.75, delay: 0.3, speed: -0.014, side: 1, cost: 25, size: 0.09),
        SwimingFish(name: "fish18", horizontalOffset: 1.3, verticalOffset: 1.8, delay: 0.8, speed: -0.012, side: -1, cost: 25, size: 0.09),
        SwimingFish(name: "fish19", horizontalOffset: 1.3, verticalOffset: 1.85, delay: 0.7, speed: -0.004, side: -1, cost: 25, size: 0.09),
        SwimingFish(name: "fish20", horizontalOffset: -0.3, verticalOffset: 1.9, delay: 2.0, speed: -0.008, side: 1, cost: 25, size: 0.09),
        SwimingFish(name: "fish21", horizontalOffset: -0.3, verticalOffset: 0.95, delay: 2.3, speed: -0.001, side: 1, cost: 0, size: 0.05),
        SwimingFish(name: "fish22", horizontalOffset: -0.2, verticalOffset: 0.9, delay: 3.1, speed: -0.001, side: 1, cost: 0, size: 0.05),
        SwimingFish(name: "fish23", horizontalOffset: -0.2, verticalOffset: 1.1, delay: 4.0, speed: -0.001, side: 1, cost: 0, size: 0.05),
        SwimingFish(name: "fish24", horizontalOffset: -0.2, verticalOffset: 1.2, delay: 1.1, speed: -0.001, side: 1, cost: 0, size: 0.05)
    ]
    
    static var questsArray: [Quest] = [
        Quest(name: "CATCH 10 FISH IN A DAY", target: 10),
        Quest(name: "CATCH ONLY BIG FISH \n5 TIMES IN A ROW", target: 5),
        Quest(name: "USE A DEEP CAST 3 TIMES", target: 3),
        Quest(name: "IMPROVE THE GEAR IN \nTHE STORE 5 TIMES", target: 5),
        Quest(name: "COLLECT 500 COINS", target: 500),
    ]
    
    static var shopFishArray: [ShopItem] = [
        ShopItem(name: "shopFish1", itemPrice: 1),
        ShopItem(name: "shopFish2", itemPrice: 300),
        ShopItem(name: "shopFish3", itemPrice: 500),
        ShopItem(name: "shopFish4", itemPrice: 800),
        ShopItem(name: "shopFish5", itemPrice: 1000),
        ShopItem(name: "shopFish6", itemPrice: 1200),
        ShopItem(name: "shopFish7", itemPrice: 1500),
        ShopItem(name: "shopFish8", itemPrice: 2000)
    ]
    
    static var shopMenArray: [ShopItem] = [
        ShopItem(name: "shopMen1", itemPrice: 1),
        ShopItem(name: "shopMen2", itemPrice: 300),
        ShopItem(name: "shopMen3", itemPrice: 500),
        ShopItem(name: "shopMen4", itemPrice: 1000),
        ShopItem(name: "shopMen5", itemPrice: 1500),
        ShopItem(name: "shopMen6", itemPrice: 2000),
    ]
}

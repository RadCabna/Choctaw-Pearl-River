//
//  Shop.swift
//  Pearl River
//
//  Created by Алкександр Степанов on 11.04.2025.
//

import SwiftUI

struct Shop: View {
    @AppStorage("count") var count = 0
    @AppStorage("enableFishCount") var enableFishCount = 1
    @AppStorage("menNumber") var menNumber = 1
    @Binding var showShop: Bool
    @State private var fishSelected = false
    @State private var fishArray = Arrays.shopFishArray
    @State private var fishData = UserDefaults.standard.array(forKey: "fishData") as? [Int] ?? [3,1,0,0,0,0,0,0]
    @State private var menData = UserDefaults.standard.array(forKey: "menData") as? [Int] ?? [3,1,0,0,0,0]
    @State private var menArray = Arrays.shopMenArray
    
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
                        showShop.toggle()
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
            HStack {
                Image(fishSelected ? "shopFishOn" : "shopFishOff")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        fishSelected.toggle()
                    }
                    .disabled(fishSelected)
                Spacer()
                    .frame(width: screenHeight*0.05)
                Image(!fishSelected ? "shopMenOn" : "shopMenOff")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.15)
                    .onTapGesture {
                        fishSelected.toggle()
                    }
                    .disabled(!fishSelected)
            }
            .offset(y: -screenHeight*0.28)
            Image("shopFrame")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.65)
                .overlay(
                    VStack {
                        if fishSelected {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: screenHeight*0.03) {
                                ForEach(0..<fishArray.count, id: \.self) { index in
                                    ZStack {
                                        Image("shopFishUnlock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.12)
                                        if fishData[index] == 3 {
                                            Image(fishArray[index].name)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.045)
                                                .frame(maxWidth: screenHeight*0.1)
                                            Image("boughtShopItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.045)
                                                .offset(y: screenHeight*0.045)
                                        }
                                        if fishData[index] == 2 {
                                            Group {
                                                Image(fishArray[index].name)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.045)
                                                    .frame(maxWidth: screenHeight*0.1)
                                                Image("shopGetItem")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.039)
                                                    .offset(y: screenHeight*0.048)
                                            }
                                            .onTapGesture {
                                                getItem(dataArray: &fishData, dataArrayName: "fishData", item: index, shopItem: &enableFishCount)
                                            }
                                        }
                                        if fishData[index] == 1 {
                                            Group {
                                                Image("lockShopFish")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.083)
                                                    .offset(y:-screenHeight*0.002)
                                                Image("buyItem")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.038)
                                                    .overlay(
                                                        Text("\(fishArray[index].itemPrice)")
                                                            .font(Font.custom("PassionOne-Black", size: screenHeight*0.02))
                                                            .foregroundColor(Color("numberColor"))
                                                            .shadow(color: .black, radius: 2, x: -2, y: 2)
                                                            .offset(x: screenHeight*0.01)
                                                    )
                                                    .offset(y: screenHeight*0.047)
                                            }
                                            .onTapGesture {
                                                buyItem(shopArray: fishArray, dataArray: &fishData, dataArrayName: "fishData", item: index)
                                            }
                                        }
                                        if fishData[index] == 0 {
                                            Image("lockShopFish")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.083)
                                                .offset(y:-screenHeight*0.002)
                                            Image("lockItem")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.038)
                                                .offset(y: screenHeight*0.047)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: screenHeight*0.015) {
                                    ForEach(0..<menArray.count, id: \.self) { index in
                                        ZStack {
                                            Image("shopMenFrame")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.2)
                                            if menData[index] == 3 {
                                                Image(menArray[index].name)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.168)
                                                Image("boughtShopItem")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.047)
                                                    .offset(y: screenHeight*0.087)
                                                
                                            }
                                            if menData[index] == 2 {
                                                Group{
                                                    Image(menArray[index].name)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.168)
                                                    Image("shopGetItem")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.04)
                                                        .offset(y: screenHeight*0.09)
                                                }
                                                .onTapGesture {
                                                    getItem(dataArray: &menData, dataArrayName: "menData", item: index, shopItem: &menNumber)
                                                }
                                            }
                                            if menData[index] == 1 {
                                                Group {
                                                    Image("lockShopMen")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.168)
                                                    Image("buyItem")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.04)
                                                        .overlay(
                                                            Text("\(fishArray[index].itemPrice)")
                                                                .font(Font.custom("PassionOne-Black", size: screenHeight*0.02))
                                                                .foregroundColor(Color("numberColor"))
                                                                .shadow(color: .black, radius: 2, x: -2, y: 2)
                                                                .offset(x: screenHeight*0.01)
                                                        )
                                                        .offset(y: screenHeight*0.089)
                                                }
                                                .onTapGesture {
                                                    buyItem(shopArray: menArray, dataArray: &menData, dataArrayName: "menData", item: index)
                                                }
                                            }
                                            if menData[index] == 0 {
                                                Image("lockShopMen")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.168)
                                                Image("lockItem")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: screenHeight*0.04)
                                                    .offset(y: screenHeight*0.089)
                                            }
                                        }
                                    }
                                }
                                .padding(.vertical, screenHeight*0.04)
                                .padding(.horizontal)
                            }
                            .mask(
                                Image("shopFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.62)
                            )
                        }
                    }
                )
                .offset(y: screenHeight*0.05)
        }
        
    }
    
    func buyItem(shopArray: [ShopItem], dataArray: inout [Int], dataArrayName: String, item: Int) {
        if shopArray[item].itemPrice <= count {
            count -= shopArray[item].itemPrice
            dataArray[item] = 2
            if item+1 < dataArray.count {
                dataArray[item+1] = 1
            }
            UserDefaults.standard.setValue(dataArray, forKey: dataArrayName)
        }
    }
    
    func getItem(dataArray: inout [Int], dataArrayName: String, item: Int, shopItem: inout Int) {
        for i in 0..<dataArray.count {
            if dataArray[i] == 3 {
                dataArray[i] = 2
            }
        }
        dataArray[item] = 3
        shopItem = item+1
        UserDefaults.standard.setValue(dataArray, forKey: dataArrayName)
    }
    
}

#Preview {
    Shop(showShop: .constant(true))
}

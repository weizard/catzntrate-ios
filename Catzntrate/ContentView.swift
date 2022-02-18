//
//  ContentView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/16.
//

import SwiftUI
import PopupView

let pet1 = Pet(id: 0, status: [10,20,4,95,98,0], attrs: [10,10,10,10], imageUrl: "bufficorn")
let pet2 = Pet(id: 1, status: [1,0,0,100,100,1], attrs: [6,4,9,2], imageUrl: "cat")

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}

struct ContentView: View {
    
    @State public var latestUsingPet = "0x" // latest user using pet's id
    @State public var pets:[Pet] = []
    @State public var currentPetIndex = 0 // current pet user use
    
    enum Tab {
        case CatWorking
        case CatAttribute
        case MarketPlace
        case Breed
    }
    
    var body: some View {
        TabView{
            CatWorkingView(pets: $pets, currentPetIndex: $currentPetIndex).tabItem{
                Label("Work",systemImage: "star").tag(Tab.CatWorking)
            }
            CatStatusView(pets: $pets, currentPetIndex: $currentPetIndex).tabItem{
                Label("Cat Status",systemImage: "star").tag(Tab.CatWorking)
            }
            ComingSoonView().tabItem{
                Label("Market Place",systemImage: "star").tag(Tab.CatWorking)
            }
            ComingSoonView().tabItem{
                Label("Breed",systemImage: "star").tag(Tab.CatWorking)
            }
        }.onAppear(){
            self.pets = [pet1,pet2]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

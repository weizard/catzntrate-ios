//
//  ContentView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/16.
//

import SwiftUI
import PopupView
import web3
import BigInt

let pet1 = Pet(id: 0, status: [10,20,4,35,98,0], attrs: [10,10,10,10], imageUrl: "bufficorn")
let pet2 = Pet(id: 1, status: [1,0,0,50,100,1], attrs: [6,4,9,2], imageUrl: "cat")



extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}

struct ContentView: View {
    
    @State public var userAccount:EthereumAccount
    
    @State public var latestUsingPet = "0x" // latest user using pet's id
    @State public var pets:[Pet] = []
    @State public var currentPetIndex = 0 // current pet user use
    @State public var userBalaces:[BigUInt] = [BigUInt(0),BigUInt(0),BigUInt(0),BigUInt(0)] // [food, CFT, CGT, MATIC]
    
    @State var counter = 0
    
    init(){
        let keyStorage = EthereumKeyLocalStorage()
        let account:EthereumAccount
        do{
            account = try EthereumAccount(keyStorage: keyStorage, keystorePassword: "PASSWORD_FOR_DEMO")
        }catch{
            account = try! EthereumAccount.create(keyStorage: keyStorage, keystorePassword: "PASSWORD_FOR_DEMO")
        }
        self.userAccount = account
    }
    
    enum Tab {
        case CatWorking
        case CatAttribute
        case MarketPlace
        case Breed
    }
    
    
    
    func getBalance() async ->Void{
        do{
            userBalaces[3] =  try await ethClient.eth_getBalance(address: userAccount.address, block: EthereumBlock(rawValue: "latsst"))
        }catch{
            print(error)
        }
    }
    
    var body: some View {
        TabView{
            CatWorkingView(pets: $pets, currentPetIndex: $currentPetIndex,userAccount: $userAccount,userBalances: $userBalaces).tabItem{
                Label("Work",systemImage: "text.bubble").tag(Tab.CatWorking)
            }
            CatStatusView(pets: $pets, currentPetIndex: $currentPetIndex,userAccount: $userAccount,userBalances: $userBalaces).tabItem{
                Label("Cat Status",systemImage: "ellipsis.circle.fill").tag(Tab.CatWorking)
            }
            MarketplaceView(userAccount: $userAccount,userBalances: $userBalaces).tabItem{
                Label("Market Place",systemImage: "cart.fill").tag(Tab.CatWorking)
            }
            BreedView(userAccount: $userAccount,userBalances: $userBalaces).tabItem{
                Label("Breed",systemImage: "smiley").tag(Tab.CatWorking)
            }
        }.onAppear(){
            self.pets = [pet1,pet2]
        }.task {
//            while(true){
//                do{
//                    // food
//                    userBalaces[0] = try await erc20Instance.balanceOf(tokenContract: CatzFoodAddress, address: userAccount.address)
//                    // CFT
//                    userBalaces[1] = try await erc20Instance.balanceOf(tokenContract: CFTAddress, address: userAccount.address)
//                    // CGT
//                    userBalaces[2] = try await erc20Instance.balanceOf(tokenContract: CGTAddress, address: userAccount.address)
//                    // MATIC
//                    userBalaces[3] = try await ethClient.eth_getBalance(address: userAccount.address, block: .Latest)
//                    sleep(5)
//                }catch{print(error)}
//            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

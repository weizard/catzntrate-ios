//
//  MarketplaceView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/18.
//

import SwiftUI
import PopupView
import web3

enum PurchaseKind:String {
    case none
    case food
}

struct MarketplaceView: View {
    
    // ==========================
    // ===      Binding       ===
    // ==========================
    
    @Binding var userAccount: EthereumAccount
    
    // ==========================
    // ===       State        ===
    // ==========================
    
    @State private var showPurchasePopup = false
    @State private var showComingSoonPopup = false
    @State private var showWalletPopup = false
    @State private var popupKind = "comingSoon"
    @State private var purchaseKind:PurchaseKind = PurchaseKind.food
    
    var columns: [GridItem] =
    Array(repeating: .init(.flexible()), count: 2)
    
    func purchaseAction(kind: String)->()->(){
        return{
            switch kind {
            case "food":
                self.purchaseKind = PurchaseKind.food
            default:
                print("This stuff should not at here")
                return
            }
            self.popupKind = "purchase"
            self.showPurchasePopup = true
        }
    }
    
    var body: some View {
        ZStack{
            Image("forest_bg").resizable().opacity(0.2)
            VStack{
                CatzntrateHeaderBar(showComingSoonPopup: $showComingSoonPopup, showWalletPopup: $showWalletPopup)
                GeometryReader{
                    geometry in
                    ScrollView{
                        LazyVGrid(columns: columns){
                            Button(action:self.purchaseAction(kind: "food")){
                                VStack{
                                    Image("cat_food").resizable().scaledToFit()
                                    Text("1 CFT")
                                }
                                
                            }.frame(width:geometry.size.width*0.4).border(Color.black)
                            
                        }.padding(EdgeInsets(top: 40, leading: 15, bottom: 10, trailing: 15))
                    }.background(Color.white).opacity(0.8).frame(height:geometry.size.height*0.9).border(Color.black, width: 3)
                }
            }.popup(isPresented:$showPurchasePopup , closeOnTapOutside: true){
                PurchaseView(purchaseKind: $purchaseKind)
            }.popup(isPresented: $showComingSoonPopup , closeOnTapOutside: true){
                ComingSoonView()
            }.popup(isPresented:$showWalletPopup, closeOnTap:false, closeOnTapOutside: true){WalletPopupView(userAccount: $userAccount)}
        }
    }
}

struct MarketplaceView_Previews: PreviewProvider {
    static var previews: some View {
        let keyStorage = EthereumKeyLocalStorage()
        MarketplaceView(userAccount: .constant(try! EthereumAccount(keyStorage: keyStorage)))
    }
}

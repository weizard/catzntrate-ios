//
//  CatzntrateHeaderBar.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/17.
//

import SwiftUI
import PopupView
import BigInt

struct CatzntrateHeaderBar: View {
    @Binding var showComingSoonPopup:Bool
    @Binding var showWalletPopup:Bool
    @Binding var userBalances:[BigUInt]
    
    func showAction(){
        self.showComingSoonPopup = true
    }
    
    func showWalletAction(){
        self.showWalletPopup = true
    }
    
    var body: some View {

        HStack(spacing:1){
            Image("cat_food").resizable().scaledToFit().frame(width:50)
            Text(":" + formatBigUint(amount: userBalances[0])).fontWeight(.bold).padding([.trailing],10)
            Image("CFT").resizable().scaledToFit().frame(width:20)
            Text(":" + formatBigUint(amount: userBalances[1])).fontWeight(.bold).padding([.trailing],10)
            Image("CGT").resizable().scaledToFit().frame(width:20)
            Text(":" + formatBigUint(amount: userBalances[2])).fontWeight(.bold).padding([.trailing],10)
            Image("matic").resizable().scaledToFit().frame(width:20)
            Text(":" + formatBigUint(amount: userBalances[3])).fontWeight(.bold).padding([.trailing],20)
            Button(action:showAction){
                Label("",systemImage: "archivebox.fill").scaledToFit()
            }
            Button(action:showWalletAction){
                Image("wallet").resizable().scaledToFit().frame(width:30)
            }
            
        }

    }
    
    
}

struct CatzntrateHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        CatzntrateHeaderBar(showComingSoonPopup: .constant(false),showWalletPopup: .constant(false), userBalances: .constant([]))
    }
}

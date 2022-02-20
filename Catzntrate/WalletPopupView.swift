//
//  WalletPopupView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/19.
//

import SwiftUI
import web3

struct WalletPopupView: View {
    @Binding var userAccount:EthereumAccount
    
    func copyAddress()->Void{
        UIPasteboard.general.string = userAccount.address.value
    }
    
    var body: some View {
        HStack{
        Text(userAccount.address.value).foregroundColor(.black)
        Button(action:copyAddress){
            Label("",systemImage:"doc.on.clipboard.fill")
        }}.padding(10).frame(width: 300, height: 150).background(.white).cornerRadius(30)
    }
}

struct WalletPopupView_Previews: PreviewProvider {
    static var previews: some View {
        let keyStorage = EthereumKeyLocalStorage()
        WalletPopupView(userAccount: .constant(try! EthereumAccount(keyStorage: keyStorage)))
    }
}

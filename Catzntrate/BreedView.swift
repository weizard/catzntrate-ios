//
//  BreedView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/19.
//

import SwiftUI
import PopupView
import web3

struct BreedView: View {
    
    // ==========================
    // ===      Binding       ===
    // ==========================
    
    @Binding var userAccount: EthereumAccount
    
    // ==========================
    // ===       State        ===
    // ==========================
    
    @State private var showChild = false
    @State private var showComingSoonPopup = false
    
    func breedAction()->Void{
        self.showChild = true
        print("breed")
    }
    
    var body: some View {
        ZStack{
            Image("forest_bg").resizable().opacity(0.2)
            
            VStack{
                CatzntrateHeaderBar(showComingSoonPopup: $showComingSoonPopup)
                
                Spacer().frame(height:150)
                // parents
                HStack(spacing: 10){
                    VStack{
                        Image("bufficorn").resizable().scaledToFit().frame(width:100)
                        Text(String(format:"#%05d",0)).foregroundColor(.black)
                    }.padding(20).background(Color.white).cornerRadius(20).overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    
                    VStack{
                        Image("Love").resizable().scaledToFit().frame(width:50)
                    }
                    
                    VStack{
                        Image("cat").resizable().scaledToFit().frame(width:100)
                        Text(String(format:"#%05d",1)).foregroundColor(.black)
                    }.padding(20).background(Color.white).cornerRadius(20).overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 1)
                    )
                }.padding([.bottom],50)
                

                
                // breed button
                CatzntrateButton(action:breedAction, text: "Breed")
                Spacer()
            }.popup(isPresented: $showChild,closeOnTapOutside: true){
                Image("bufficorn").resizable().scaledToFit().frame(width:100).padding(EdgeInsets(top: 20, leading: 80, bottom: 20, trailing: 80)).background(Color.white).cornerRadius(20).overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
            }.popup(isPresented: $showComingSoonPopup,closeOnTapOutside: true){
                ComingSoonView()
            }
        }
    }
}

struct BreedView_Previews: PreviewProvider {
    static var previews: some View {
        let keyStorage = EthereumKeyLocalStorage()
        BreedView(userAccount: .constant(try! EthereumAccount(keyStorage: keyStorage)))
    }
}

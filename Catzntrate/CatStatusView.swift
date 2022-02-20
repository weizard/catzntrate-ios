//
//  CatStatusView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/17.
//

import SwiftUI
import PopupView
import ACarousel
import web3

enum CatAttribute:String , CaseIterable{
    case Effciency
    case Curiosity
    case Luck
    case Vitality
}

struct CatStatusView: View {
    
    // ==========================
    // ===      Binding       ===
    // ==========================
    
    @Binding var pets:[Pet]
    @Binding var currentPetIndex:Int
    @Binding var userAccount: EthereumAccount
    
    // ==========================
    // ===       State        ===
    // ==========================
    
    @State public var showComingSoonPopup = false
    @State public var showSkillPointPopup = false
    @State private var showWalletPopup = false
    
    func feedAction()->Void {
        print("feed")
    }
    
    func levelUpAction()->Void{}
    
    func increaseAttributeAction() -> Void{
        self.showSkillPointPopup = true
    }
    
    func equipmentAction(num: Int)->()->() {
        return{
            // coming soon
            self.showComingSoonPopup = true
        }
    }
    
    var body: some View {
        
        ZStack{
            // background
            Image("forest_bg").resizable().opacity(0.2)
            // content
            VStack(spacing: 30){
                CatzntrateHeaderBar(showComingSoonPopup:$showComingSoonPopup,showWalletPopup: $showWalletPopup)
                // 1st section: feed, equipment
                HStack(spacing:15){
                    Button(action: feedAction){
                        Image("feed").resizable().scaledToFit().frame(width:60)

                    }
                    ForEach(0..<4){ i in
                        Button(action: self.equipmentAction(num:i)){
                            Image(systemName: "lock.shield").resizable().scaledToFit().frame( height: 40)}
                    }
                }
                
                // 2nd section: cat status
                HStack(spacing:0){
                    // sn, sexial, hp
                    VStack(alignment: .leading){
                        Image("sn").resizable().scaledToFit().frame(width:50)
                        Text("# "+String(format:"%06d",pets[currentPetIndex].id)).fontWeight(.bold).font(.system(size: 18)).padding([.leading],10)
                        Image("gender").resizable().scaledToFit().frame(width:50, alignment: .trailing)
                        Text(pets[currentPetIndex].status[5] != 0 ? "Male" : "Female").fontWeight(.bold).font(.system(size: 18)).padding([.leading],10)
                        Image("hp").resizable().scaledToFit().frame(width:35)
                        Text(formateStatus(current:pets[currentPetIndex].status[3], upbound: 50,statusTitle:"HP")).fontWeight(.bold).font(.system(size: 18))
                    }
                    // cat
                    ACarousel(pets.indices, id:\.self, index: $currentPetIndex){
                        _petIndex in
                        Image(pets[_petIndex].imageUrl).resizable().scaledToFit().frame(height: 200)
                    }.frame(height: 200)
                    // lv, exp, sp
                    VStack(alignment:.leading){
                        Image("level").resizable().scaledToFit().frame(width:50)
                        Text("LV: "+String(pets[currentPetIndex].status[0]+1)).fontWeight(.bold).font(.system(size: 18))
                        Image("exp").resizable().scaledToFit().frame(width:40)
                        Text(formateStatus(current:pets[currentPetIndex].status[1], upbound: pets[currentPetIndex].status[0]*10+100,statusTitle:"EXP")).fontWeight(.bold).font(.system(size: 18))
                        Image("sp").resizable().scaledToFit().frame(width:35)
                        Text(formateStatus(current:pets[currentPetIndex].status[4], upbound: 100,statusTitle:"SP")).fontWeight(.bold).font(.system(size: 18))
                    }
                }
                
                // 3rd section: cat attribute
                VStack{
                    // attribute header
                    HStack{
                        Text("Attributes")
                        Spacer()
                        Button(action: levelUpAction){
                            Text("Level Up").padding(EdgeInsets(top:3,leading:10, bottom:3, trailing:10)).frame(width:80).font(.system(size: 12)).foregroundColor(Color.white).background(.blue)
                        }.border(Color.blue, width: 4).cornerRadius(30).hidden(pets[currentPetIndex].status[1] != 100)
                        Text("Point(+):"+String(pets[currentPetIndex].status[2]))
                        Button(action:increaseAttributeAction){
                            Image(systemName: "plus.circle")
                        }
                    }.padding(5)
                    // attributes
                    VStack(spacing:3){
                        ForEach(Array(CatAttribute.allCases.enumerated()), id:\.element){index, attr in
                            HStack{
                                Text(attr.rawValue)
                                Spacer()
                                Text(String(pets[currentPetIndex].attrs[index]))
                            }
                        }
                    }.padding([.leading,.bottom],10)
                }.padding([.leading,.trailing],30).padding().background(Color.white).cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 4)
                    )
                Spacer()
            }.popup(isPresented:$showComingSoonPopup, closeOnTapOutside: true){
                ComingSoonView()
            }.popup(isPresented:$showSkillPointPopup, closeOnTap: false, closeOnTapOutside: true){
                SkillPointPopupView(pets:$pets, currentPetIndex: $currentPetIndex,showSkillPointPopup: $showSkillPointPopup)
            }.popup(isPresented:$showWalletPopup, closeOnTap:false, closeOnTapOutside: true){WalletPopupView(userAccount: $userAccount)}
        }
    }
}

struct CatStatusView_Previews: PreviewProvider {
    static var previews: some View {
        let keyStorage = EthereumKeyLocalStorage()
        CatStatusView(pets: .constant([]), currentPetIndex: .constant(0), userAccount: .constant(try! EthereumAccount(keyStorage: keyStorage)))
    }
}

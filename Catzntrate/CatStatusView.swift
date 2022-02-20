//
//  CatStatusView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/17.
//

import SwiftUI
import PopupView
import ACarousel

enum CatAttribute:String , CaseIterable{
    case Effciency
    case Curiosity
    case Luck
    case Vitality
}

struct CatStatusView: View {
    @State public var showComingSoonPopup = false
    @State public var showSkillPointPopup = false
    
    @Binding var pets:[Pet]
    @Binding var currentPetIndex:Int
    
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
                CatzntrateHeaderBar(showComingSoonPopup:$showComingSoonPopup)
                // 1st section: feed, equipment
                HStack(spacing:15){
                    Button(action: feedAction){
                        Text("Feed").font(.system(size: 20)).padding(5)
                    }.border(Color.black,width: 3)
                    ForEach(0..<4){ i in
                        Button(action: self.equipmentAction(num:i)){
                            Image(systemName: "lock.shield").resizable().scaledToFit().frame( height: 40)}
                    }
                }
                
                // 2nd section: cat status
                HStack(spacing:15){
                    // sn, sexial, hp
                    VStack(alignment: .leading){
                        Text("# "+String(format:"%06d",pets[currentPetIndex].id)).font(.system(size: 18))
                        Text(pets[currentPetIndex].status[5] != 0 ? "Male" : "Female").font(.system(size: 18))
                        Text("HP: "+String(pets[currentPetIndex].status[3])+"/100").font(.system(size: 18))
                    }
                    // cat
                    ACarousel(pets.indices, id:\.self, index: $currentPetIndex){
                        _petIndex in
                        Image(pets[_petIndex].imageUrl).resizable().scaledToFit().frame(height: 200)
                    }.frame(height: 200)
                    // lv, exp, sp
                    VStack(alignment:.leading){
                        Text("LV: "+String(pets[currentPetIndex].status[0])).font(.system(size: 18))
                        Text("Exp: "+String(pets[currentPetIndex].status[1])+"/40").font(.system(size: 18))
                        Text("SP: "+String(pets[currentPetIndex].status[4])+"/100").font(.system(size: 18))
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
                }.padding([.leading,.trailing],30)
                Spacer()
            }.popup(isPresented:$showComingSoonPopup, closeOnTapOutside: true){
                ComingSoonView()
            }.popup(isPresented:$showSkillPointPopup, closeOnTap: false, closeOnTapOutside: false){
                SkillPointPopupView(pets:$pets, currentPetIndex: $currentPetIndex,showSkillPointPopup: $showSkillPointPopup)
            }
        }
    }
}

struct CatStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CatStatusView(pets: .constant([]), currentPetIndex: .constant(0))
    }
}

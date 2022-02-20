//
//  SkillPointPopupView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/19.
//

import SwiftUI

struct SkillPointPopupView: View {
    
    @Binding var pets:[Pet]
    @Binding var currentPetIndex:Int
    @Binding var showSkillPointPopup: Bool
    
    @State private var remainSkillPoints: Int = 0
    @State private var allocatedPoint:[Int] = [0,0,0,0]
    
    func increaseAttributeAction(petIndex:Int, attr: String) ->()->(){
        return{
            if self.remainSkillPoints == 0 {
                return
            }
            switch attr {
            case CatAttribute.Effciency.rawValue.lowercased():
                allocatedPoint[0] += 1
            case CatAttribute.Curiosity.rawValue.lowercased():
                allocatedPoint[1] += 1
            case CatAttribute.Luck.rawValue.lowercased():
                allocatedPoint[2] += 1
            case CatAttribute.Vitality.rawValue.lowercased():
                allocatedPoint[3] += 1
            default:
                print(attr)
                return
            }
            self.remainSkillPoints -= 1
        }
    }
    
    func decreaseAttributeAction(petIndex:Int, attr: String) ->()->(){
        return{
            if self.remainSkillPoints >= pets[currentPetIndex].status[2] {
                return
            }
            switch attr {
            case CatAttribute.Effciency.rawValue.lowercased():
                if allocatedPoint[0] > 0 {allocatedPoint[0] -= 1}else{return}
            case CatAttribute.Curiosity.rawValue.lowercased():
                if allocatedPoint[1] > 0 {allocatedPoint[1] -= 1}else{return}
            case CatAttribute.Luck.rawValue.lowercased():
                if allocatedPoint[2] > 0{allocatedPoint[2] -= 1}else{return}
            case CatAttribute.Vitality.rawValue.lowercased():
                if allocatedPoint[3] > 0 {allocatedPoint[3] -= 1}else{return}
            default:
                print(attr)
                return
            }
            self.remainSkillPoints += 1
        }
    }
    
    func cancelAction()->Void{
        self.remainSkillPoints = pets[currentPetIndex].status[2]
        self.allocatedPoint = [0,0,0,0]
        showSkillPointPopup = false
        print("cancel")
    }
    
    func confirmAction()->Void{
        pets[currentPetIndex].attrs[0] += allocatedPoint[0]
        pets[currentPetIndex].attrs[1] += allocatedPoint[1]
        pets[currentPetIndex].attrs[2] += allocatedPoint[2]
        pets[currentPetIndex].attrs[3] += allocatedPoint[3]
        pets[currentPetIndex].status[2] = self.remainSkillPoints
        self.allocatedPoint = [0,0,0,0]
        showSkillPointPopup = false
        print("confirm")
    }
    
    
    var body: some View {
        VStack{
            Text("Allocate your skill point").padding([.top], 20).foregroundColor(Color.black).font(.system(size:30))
            // attribute header
            HStack{
                Text("Attributes")
                Spacer()
                Text("Remain Point:"+String(self.remainSkillPoints))
            }.padding(5)
            // attributes
            VStack(spacing:3){
                ForEach(Array(CatAttribute.allCases.enumerated()), id:\.element){index, attr in
                    HStack{
                        Text(attr.rawValue)
                        Spacer()
                        Button(action:self.decreaseAttributeAction(petIndex: currentPetIndex, attr: attr.rawValue.lowercased())){
                            Image(systemName: "minus.circle")
                        }.padding([.bottom],3)
                        Text(String(pets[currentPetIndex].attrs[index]+allocatedPoint[index])).frame(width: 30)
                        Button(action:self.increaseAttributeAction(petIndex: currentPetIndex, attr: attr.rawValue.lowercased())){
                            Image(systemName: "plus.circle")
                        }.padding([.bottom],3)
                    }
                }.padding([.leading, .trailing], 15)
                HStack(spacing: 10){
                    CatzntrateButton(action: cancelAction, text: "Cancel", systemName:"xmark.seal")
                    CatzntrateButton(action: confirmAction, text: "Confirm", systemName:"checkmark.seal")
                }.padding([.top, .bottom], 30)
            }.padding([.leading,.bottom],10)
        }.padding([.leading,.trailing],10).background(Color.white).cornerRadius(20).overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1)
        ).padding([.leading,.trailing],30)
            .onAppear(){
                self.remainSkillPoints = pets[currentPetIndex].status[2]
            }
    }
}

struct SkillPointPopupView_Previews: PreviewProvider {
    static var previews: some View {
        SkillPointPopupView(pets: .constant([]), currentPetIndex: .constant(0), showSkillPointPopup: .constant(false))
    }
}

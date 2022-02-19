//
//  PurchaseView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/19.
//

import SwiftUI

struct PurchaseView: View {
    
    @Binding var purchaseKind:PurchaseKind
    
    func cancelAction()->Void{
        print("cancel")
    }
    
    // TODO: only handler purchase kind is `food` for now
    func comfirmAction(kind:String) ->()->(){
        return{
            print("purchase")
        }
    }
    
    var body: some View {
        VStack{
            Text("Cost 1 CFT to get").foregroundColor(.black).padding(20).overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 3)
            ).padding([.top],30)
            HStack (spacing:20){
                CatzntrateButton(action:cancelAction, text: "Cancel")
                CatzntrateButton(action:self.comfirmAction(kind: purchaseKind.rawValue), text: "Comfirm")
            }.padding(20)
        }.background(.white).cornerRadius(15).overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView(purchaseKind: .constant(PurchaseKind.food))
    }
}

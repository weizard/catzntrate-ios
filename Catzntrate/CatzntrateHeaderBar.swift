//
//  CatzntrateHeaderBar.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/17.
//

import SwiftUI
import PopupView

struct CatzntrateHeaderBar: View {
    @Binding var showComingSoonPopup:Bool
    
    func showAction(){
        self.showComingSoonPopup = true
    }
    
    var body: some View {
        HStack{
            Text("food: 10")
            Text("CFT: 10")
            Text("CGT: 10")
            Button(action:showAction){
                Text("items")
            }
        }
        .border(Color.black).padding(EdgeInsets(top: 20, leading: 0, bottom: 50, trailing: 0))
    }
}

struct CatzntrateHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        CatzntrateHeaderBar(showComingSoonPopup: .constant(false))
    }
}

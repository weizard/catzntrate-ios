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

        HStack(spacing:1){
            Image("cat_food").resizable().scaledToFit().frame(width:50)
            Text(":10   ").fontWeight(.bold)
            Image("CFT").resizable().scaledToFit().frame(width:30)
            Text(":10   ").fontWeight(.bold)
            Image("CGT").resizable().scaledToFit().frame(width:30)
            Text(":10   ").fontWeight(.bold)
            Image("matic").resizable().scaledToFit().frame(width:30)
            Text(":10      ").fontWeight(.bold)
            Button(action:showAction){
                Label("",systemImage: "archivebox.fill").scaledToFit()
            }
            Button(action:showAction){
                Image("wallet").resizable().scaledToFit().frame(width:30)
            }
            
        }

    }
    
    
}

struct CatzntrateHeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        CatzntrateHeaderBar(showComingSoonPopup: .constant(false))
    }
}

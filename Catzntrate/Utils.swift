//
//  Utils.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/16.
//

import Foundation
import SwiftUI

struct Pet {
    var id:Int
    var status:[Int] // [lv, exp, skillPoint, energy, saturation, gender]
    var attrs:[Int]  // [efficency, curiousity, luck, vitaity]
    var imageUrl: String // img link
}

let ethClient = "https://rpc-mumbai.matic.today"

struct CatzntrateButton:View{
    let action: () -> Void
    let text:String
    let systemName:String
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemName)
                .font(.title)
                Text(text).fontWeight(.semibold)
            }.padding().foregroundColor(.white).background(Color.blue).cornerRadius(40)
        }
    }
}

func formateTimer(seconds: Int) -> String {
    let min = seconds/60
    let sec = seconds % 60
    
    if min >= 60 {
        let _min = min%60
        let _hr = min/60
        return String(format: "%d:%02d:%02d", _hr, _min, sec)
    }
    
    return String(format: "%02d:%02d", min, sec)
}

func formateStatus(current: Int, upbound: Int, statusTitle: String = "") -> String{
    if (statusTitle.count != 0) {return statusTitle + String(format: ": %d / %d", current, upbound)}
    return String(format: "%d / %d", current, upbound)
}

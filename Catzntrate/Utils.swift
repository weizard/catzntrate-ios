//
//  Utils.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/16.
//

import Foundation
import SwiftUI
import BigInt
import web3

// web3
let ethClient = EthereumClient(url: URL(string: ethClientUrl)!)
let erc20Instance = ERC20.init(client: ethClient)

// timer trigger
let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

// component
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

struct Pet {
    var id:Int
    var status:[Int] // [lv, exp, skillPoint, energy, saturation, gender]
    var attrs:[Int]  // [efficency, curiousity, luck, vitaity]
    var imageUrl: String // img link
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

func formatBigUint(amount: BigUInt, decimal: Int = 18, display:Int=1) -> String {
    let base = BigUInt(10).power(decimal)
    let result = amount.quotientAndRemainder(dividingBy: base)
    let subBase = BigUInt(10).power(decimal-display)
    let subResult = result.remainder.quotientAndRemainder(dividingBy: subBase)
    return result.quotient.formatted() + "." + subResult.quotient.formatted()
}

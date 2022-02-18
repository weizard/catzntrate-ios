//
//  Utils.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/16.
//

import Foundation


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

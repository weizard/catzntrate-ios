//
//  TimerView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/18.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var timeRemaining:Int
    
    // timer trigger
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack{
            Image(systemName: "alarm.fill").padding(0)
            Text(formateTimer(seconds:  timeRemaining))
                .font(.system(size: 25)).padding([.top,.bottom, .trailing],3)
        }.frame(width: 150).border(Color.black, width: 2).cornerRadius(5)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: .constant(10))
    }
}
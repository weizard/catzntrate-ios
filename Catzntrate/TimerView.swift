//
//  TimerView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/18.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var timeRemaining:Int
    
    var body: some View {
        HStack{
            Image(systemName: "alarm.fill").padding(0).foregroundColor(.black)
            Text(formateTimer(seconds:  timeRemaining))
                .font(.system(size: 25)).foregroundColor(.black).padding([.top,.bottom, .trailing],3)
        }.frame(width: 150).background(.white).border(Color.black, width: 2).cornerRadius(5)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeRemaining: .constant(10))
    }
}

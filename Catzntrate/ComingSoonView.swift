//
//  ComingSoonView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/17.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        Text("Coming Soon!").foregroundColor(.black).frame(width: 300, height: 150).background(.white).cornerRadius(30)
    }
}

struct ComingSoonView_Previews: PreviewProvider {
    static var previews: some View {
        ComingSoonView()
    }
}

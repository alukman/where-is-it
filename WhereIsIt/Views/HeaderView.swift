//
//  HeaderView.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack{
            Image("buzz")
                .resizable()
                .scaledToFit()
                .frame(width: 75, height:75, alignment: .center)
                
            Text("Where Is It?")
                .font(.system(size: 40, weight: .light, design: .rounded))
                .scaledToFit()
                .foregroundColor(.white)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}

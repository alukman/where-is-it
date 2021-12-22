//
//  BackgroundGradientView.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("Navy Blue"), Color("Main Gradient 2"), Color("Navy Blue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
}

struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
    }
}

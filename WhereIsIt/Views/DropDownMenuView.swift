//
//  DropDownMenuView.swift
//  WhereIsIt
//
//  Created by Green T
//

import Foundation
import UIKit
import SwiftUI
import FirebaseFirestore
import DropDown

struct DropDownMenuView: View {
    @Binding var allItems: [String]
    @State private var expanded: Bool = false
    @State public var selectedItem = "Item"
    var db = Firestore.firestore()
    typealias UIViewType = UIView
    var body: some View {
        VStack{
            DisclosureGroup("   \(self.selectedItem)", isExpanded: $expanded){
                ScrollView{
                    VStack{
                        ForEach(allItems, id: \.self){ item in
                            Text(item)
                                .padding(.all)
                                .onTapGesture {
                                    self.selectedItem = item
                                    withAnimation(){
                                    self.expanded.toggle()
                                }
                            }
                        }
                    }
                }
            }.background(Color("Tech Gold"))
                .foregroundColor(.white)
                .padding(.all)
            .accentColor(.white)
            .cornerRadius(8)

        }.padding(.trailing)
    }
   
}

struct DropDownMenuView_Previews: PreviewProvider {
    @State static var items = ["1","2","3"]
    static var previews: some View {
        DropDownMenuView(allItems: $items)
    }
}

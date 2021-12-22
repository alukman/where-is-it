//
//  ItemLocationDescriptionPage.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI

struct ItemLocationDescriptionPage: View {
    @Binding var selectedEntity: String
    @Binding var selectedBuilding: String?
    @Binding var entityLocationDescription: String?
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Text("\(selectedEntity)s at \(selectedBuilding!)")
                Spacer()
                Text("\(entityLocationDescription!)")
                Button("Close") {
                    self.isPresented = false;
                }
                .foregroundColor(.white)
                .padding()
                .background(Color("Navy Blue"))
                .cornerRadius(10)
                Spacer()
            }
        }
        
    }
}

struct ItemLocationDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemLocationDescriptionPage(selectedEntity: .constant("selectedEntity"),
                                    selectedBuilding: .constant("Building Name"),
                                    entityLocationDescription: .constant("Building Name"),
                                    isPresented: .constant(true))
    }
}

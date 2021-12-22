//
//  ChosenEntityPage.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ChosenEntityPage: View {
    @Binding var isPresented: Bool
    @Binding var selectedEntity: String
    
    @State private var selectedBuilding: String?
    @State private var entityLocationDescription: String?
    
    @State var showingItemLocationDescriptionView = false
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradientView()
                VStack{
                    Spacer().frame(height: 50)
                    HeaderView()
                    Text(selectedEntity.uppercased())
                    Spacer().frame(height: 25)
                    MapView(selectedEntity: $selectedEntity,
                            selectedBuilding: $selectedBuilding,
                            entityLocationDescription: $entityLocationDescription,
                            showingBuildingDescription: $showingItemLocationDescriptionView)
                        .frame(width: 350, height: 450, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer().frame(height: 25)
                    Button("Close") {
                        self.isPresented = false;
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Navy Blue"))
                    .cornerRadius(10)
                    Spacer()
                }.sheet(isPresented: $showingItemLocationDescriptionView){
                    ItemLocationDescriptionPage(selectedEntity: $selectedEntity,
                                                selectedBuilding: $selectedBuilding,
                                                entityLocationDescription: $entityLocationDescription,
                                                isPresented: $showingItemLocationDescriptionView)
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text("Home"))
            .edgesIgnoringSafeArea([.top, .bottom])
        }
        .statusBar(hidden: true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ChosenEntityPage_Previews: PreviewProvider {
    @State static var previewIsPresented = false
    @State static var previewSelectedEntity = "test"
    static var previews: some View {
        ChosenEntityPage(isPresented: $previewIsPresented, selectedEntity: $previewSelectedEntity)
    }
}

//
//  ContentView.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI

struct LoginPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundGradientView()
                VStack{
                    Spacer().frame(height: 50)
                    HeaderView()
                    Spacer()
                    Text("Before Adding - Login REQUIRED\nLogin Page\nFuture Implementation")
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        AddButton()
                        Spacer()
                        Button("Cancel",
                            action: {
                                self.presentationMode.wrappedValue.dismiss()
                            })
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("New Horizon"))
                        .cornerRadius(10)
                        Spacer()
                    }
                    Spacer()
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


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
            .preferredColorScheme(.none)
    }
}

struct AddButton: View {
    var body: some View {
        NavigationLink(
            destination: AddItemPage()) {
            Text("Add")
        }
        .foregroundColor(.white)
        .padding()
        .background(Color("Navy Blue"))
        .cornerRadius(10)
    }
}

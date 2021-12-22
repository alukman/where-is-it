//
//  ContentView.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI
import UIKit
import Firebase
import FirebaseFirestore

struct HomePage: View {
    
    @StateObject private var keyboardHandler = KeyboardHandler()
    
    @State var text: String = ""
    @State private var showingEntityPage = false
    @State private var showingDeveloperPage = false
    var body: some View {
        
        NavigationView {
            ZStack {
                BackgroundGradientView()
                VStack{
                    Spacer().frame(height: 50)
                    HeaderView()
                    MainSearchView()
                        .padding(.horizontal)
                    Spacer()
                    Text("Found a new item? Add it to our database!").foregroundColor(.white)
                    NavigationLink(
                        //todo: add login page
                        destination: AddItemPage()) {
                        //destination: LoginPage()) {
                            Text("Add Item").foregroundColor(.black)                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Tech Gold"))
                    .cornerRadius(10)
                    
                    /*
                    Group{
                        Text("Developer Button:")
                        Button("Show item list") {
                            self.showingDeveloperPage.toggle()
                        }.sheet(isPresented: $showingDeveloperPage){
                            DeveloperPage(isPresented: $showingDeveloperPage)
                        }
                    }
                     */
                    Spacer()
                }
                .padding(.bottom, keyboardHandler.keyboardHeight)
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text("Home"))
            .edgesIgnoringSafeArea([.top, .bottom])
            .onTapGesture {
                self.hideKeyboard()
            }
        }
        .statusBar(hidden: true)
        .navigationBarBackButtonHidden(true)
    }
}

struct DeveloperPage: View {
    @Binding var isPresented: Bool
    
    var body: some View{
        Text(entityNameList.description)
        Button("Close") {
            self.isPresented = false;
        }
        .foregroundColor(.white)
        .padding()
        .background(Color("Navy Blue"))
        .cornerRadius(10)
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .preferredColorScheme(.none)
    }
}

//
//  MainSearchBar.swift
//  WhereIsIt
//
//  Created by Green T
//

import Foundation
import SwiftUI

struct CustomizedSearchBar: UIViewRepresentable {
    @Binding var text: String
    var color: UIColor? = nil
    
    
    func makeUIView(context: UIViewRepresentableContext<CustomizedSearchBar>) -> UISearchBar {
        let searchbar = UISearchBar(frame: .zero)
        searchbar.autocapitalizationType = .none
        searchbar.delegate = context.coordinator
        if(color != nil){
            searchbar.barTintColor = color!
            searchbar.tintColor = UIColor.white
        }
        
        return searchbar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<CustomizedSearchBar>) {
        uiView.text = text
    }
    
    func makeCoordinator() -> CustomizedSearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
    }
}

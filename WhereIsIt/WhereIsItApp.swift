//
//  WhereIsItApp.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI
import Firebase
import FirebaseFirestore

public var entityNameList = [String]()
public var buildingList = [Building]()
public var chosenEntityLocations = [Building]()

@main
struct WhereIsItApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            HomePage()
                .preferredColorScheme(.none)
        }
    }
}

struct WhereIsItApp_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

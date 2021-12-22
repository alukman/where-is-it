//
//  AppDelegate.swift
//  WhereIsIt
//
//  Created by Green T
//

import UIKit
import Firebase



class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch
        FirebaseApp.configure()
        Firestore.firestore().collection("List").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if entityNameList.isEmpty {
                    for document in querySnapshot!.documents {
                        entityNameList.append(document.documentID)
                    }
                }
                if buildingList.isEmpty {
                    Api().getPosts { (buildings) in
                        buildingList = buildings
                    }
                }
            }
        }
        Firestore.firestore().collection("List").addSnapshotListener{ (querySnapshot, error) in
            entityNameList.removeAll()
            for document in querySnapshot!.documents{
                entityNameList.append(document.documentID)
            }
        }
        return true
    }
}

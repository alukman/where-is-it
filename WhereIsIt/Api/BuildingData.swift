//
//  BuildingData.swift
//  WhereIsIt
//
//  Created by Green T
//

import SwiftUI
import CoreLocation

struct Response: Codable {
    var children: Children
}

struct Children: Codable {
    var locations: [Building]
}

public struct Building: Codable, Identifiable {
    public let id = UUID()
    var name: String
    var lat: Double
    var lng: Double
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
}

class Api {
    func getPosts(completion: @escaping ([Building]) -> ()) {
        guard let url = URL(string: "https://api.concept3d.com/categories/870?map=82&batch&children&key=0001085cc708b9cef47080f064612ca5") else {
            print("FAILED TO LOAD URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let response = try! JSONDecoder().decode(Response.self, from: data!)
            DispatchQueue.main.async {
                completion(response.children.locations)
            }
        }
        .resume()
    }
}

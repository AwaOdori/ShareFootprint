//
//  GetFootprint.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/04/08.
//

import Foundation
import FirebaseFirestore

struct GottenFootprint: Identifiable{
    var id: String = UUID().uuidString
    var title:String
    var description:String
    var tag:String
    var how:String
    var date:Date
    var latitude:[Double]
    var longitude:[Double]
    
}

class GetFootprints: ObservableObject {
    @Published var gottenFooprint = [GottenFootprint]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("footprint").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.gottenFooprint = querySnapshot?.documents.compactMap { document in
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let how = data["how"] as? String ?? ""
                    let tag = data["tag"] as? String ?? ""
                    let date = (data["date"] as? Timestamp)?.dateValue() ?? Date()
                    let latitude = data["latitude"] as? [Double] ?? []
                    let longitude = data["longitude"] as? [Double] ?? []
                    return GottenFootprint(title: title, description: description, tag: tag, how: how, date: date, latitude: latitude, longitude: longitude)
                } ?? []
            }
        }
    }
}

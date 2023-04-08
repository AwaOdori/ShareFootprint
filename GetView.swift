//
//  GetView.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/04/08.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct GetView: View {
    @ObservedObject var getFootprint = GetFootprints()
    var body: some View {
        NavigationView{
            VStack{
                List(getFootprint.gottenFooprint) { footprint in
                    VStack(alignment: .leading) {
                        Text(footprint.title).font(.title)
                        Text(footprint.description)
                        Text(footprint.how)
                        Text("投稿時刻\(footprint.date)")
                        NavigationLink(destination:DrowFootprintView( latitude: footprint.latitude, longitude: footprint.longitude)){
                            Text("道を見る")
                        }
                    }
                }
            }.onAppear(){
                self.getFootprint.fetchData()
            }
        }
    }
}

struct GetView_Previews: PreviewProvider {
    static var previews: some View {
        GetView()
    }
}

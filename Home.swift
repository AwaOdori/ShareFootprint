//
//  Home.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/03/28.
//

import SwiftUI
import MapKit

struct Home: View {
    @ObservedObject var manager = LocationManager()
    
    @State var trackingMode = MapUserTrackingMode.follow
    var body: some View {
        NavigationView{
            VStack{
                Text("Home")
                NavigationLink(destination: MakeRoadView(manager: manager)){
                    Text("道を作成")
                }
                NavigationLink(destination: GetView()){
                    Text("道を見る")
                }
                Map(coordinateRegion: $manager.region,
                    showsUserLocation: true,
                    userTrackingMode: $trackingMode
                ).edgesIgnoringSafeArea(.bottom)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

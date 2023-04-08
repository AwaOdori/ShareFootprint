//
//  MakeRoadView.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/04/04.
//

import SwiftUI
import MapKit
import Combine

struct MapView: UIViewRepresentable {
    @ObservedObject var manager : LocationManager

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        context.coordinator.updatePolyline(for: view)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(manager: manager)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var manager: LocationManager
        private var cancellables: Set<AnyCancellable> = []

        init(manager: LocationManager) {
            self.manager = manager
            super.init()
            manager.objectWillChange.sink { [weak self] _ in
                self?.updatePolyline()
            }.store(in: &cancellables)
        }

        weak var mapView: MKMapView?

        func updatePolyline(for mapView: MKMapView? = nil) {
            if let mapView = mapView {
                self.mapView = mapView
            }
            guard let mapView = self.mapView else { return }
            mapView.removeOverlays(mapView.overlays)
            let polyline = MKPolyline(coordinates: manager.locationInfos.locations, count: manager.locationInfos.locations.count)
            mapView.addOverlay(polyline)
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .black
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

struct MakeRoadView: View {
    @ObservedObject var manager: LocationManager
    //@State private var isPostViewActive = false
    
    var body: some View {
        NavigationView{
            VStack{
                MapView(manager: manager)
                    .edgesIgnoringSafeArea(.all)
                Text("\($manager.locationInfos.longitude.count)")
                NavigationLink(destination: PostView(latitude: manager.locationInfos.latitude, longitude: manager.locationInfos.longitude)){
                    Text("投稿画面へ")
                }
            }
        }    }
}

//struct MakeRoadView_Previews: PreviewProvider {
//    static var previews: some View {
//        MakeRoadView()
//    }
//}

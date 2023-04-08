//
//  DrowFootprintView.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/04/08.
//

import SwiftUI
import MapKit

struct MapViews: UIViewRepresentable {
    @Binding var locations: [CLLocationCoordinate2D]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        updateRoute(for: view)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateRoute(for mapView: MKMapView) {
        mapView.removeOverlays(mapView.overlays)
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline)
        mapView.setVisibleMapRect(polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), animated: true)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViews

        init(_ parent: MapViews) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 3
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

struct DrowFootprintView: View {
    @State private var locations: [CLLocationCoordinate2D]=[]
    let latitude:[Double]
    let longitude:[Double]
    var body: some View {
        NavigationView{
            VStack{
                MapViews(locations: $locations)
                    .edgesIgnoringSafeArea(.all)
            }.onAppear(){
                locations = zip(self.latitude, self.longitude).map { CLLocationCoordinate2D(latitude: $0, longitude: $1) }
            }
        }
    }
}

//struct DrowFootprintView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrowFootprintView()
//    }
//}

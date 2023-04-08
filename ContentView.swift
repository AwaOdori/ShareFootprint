//
//  ContentView.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/03/23.
//

import SwiftUI
import MapKit
import FirebaseAuth


struct ContentView: View {
    @State var isActiveHome = false
    @State var isActiveLogin = false
    var body: some View {
        NavigationView{
            VStack{
                Text("ログイン状態確認中...\nMaking sure of Statement of Login...")
                Image(systemName:"dot.radiowaves.left.and.right")
                    .aspectRatio(contentMode: .fill)
                NavigationLink(destination:Home(),isActive: $isActiveHome){EmptyView()}
                NavigationLink(destination:Login(),isActive: $isActiveLogin){Text("画面遷移がなされない場合はこちら")}
            }.onAppear{
                if Auth.auth().currentUser != nil {
                    print("メイン画面へ")
                    self.isActiveHome=true
                    self.isActiveLogin=false
                } else {
                    print("ログイン画面へ")
                    self.isActiveHome=false
                    self.isActiveLogin=true
                   print(isActiveHome,isActiveLogin)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

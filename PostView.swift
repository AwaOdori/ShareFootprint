//
//  PostView.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/04/06.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct PostView: View {
    let latitude:[Double]
    let longitude:[Double]
    @State var title = ""
    @State var description = ""
    @State var tag = ""
    @State var how = ""
    @State var selectedHowsIndex :Int = 0
    let hows = ["徒歩","自転車","バイク","自動車","その他"]
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        Text("Latitude count: \(latitude.count)")
                        Text("Longitude count: \(longitude.count)")
                        TextField("タイトル",text: $title)
                        TextField("説明",text: $description,axis: .vertical)
                        Picker("なにで？", selection: $selectedHowsIndex){
                            ForEach(0 ..< hows.count){
                                Text(self.hows[$0])
                            }
                        }
                        TextField("タグ",text: $tag)
                    }
                    Button(action:{
                        print("投稿\(longitude)")
                        let dt : Date = Date()
                        let db = Firestore.firestore()
                        db.collection("footprint").document().setData([
                            "title":title,
                            "description":description,
                            "tag":tag,
                            "how":hows[selectedHowsIndex],
                            "date":dt,
                            "latitude":latitude,
                            "longitude":longitude
                        ])
                    }){
                        Text("投稿")
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView()
//    }
//}

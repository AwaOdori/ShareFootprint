//
//  SwiftUIView.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/03/24.
//

import SwiftUI
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


struct Login: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isActive = false
    @State var emailError = false
    @State var passwordError = false
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    if emailError{
                        Text("emailアドレスが正しくありません")
                        .foregroundColor(Color.red)}
                    if passwordError{
                        Text("パスワードが正しくありません")
                        .foregroundColor(Color.red)}
                    
                    Section{
                        TextField("e-mail address",text: $email).padding()
                        SecureField("password",text: $password).padding()
                    }
                    Section{
                        Button(action:{
                            Auth.auth().signIn(withEmail: email, password: password)
                            
                            if Auth.auth().currentUser != nil {
                                // User is signed in.
                                isActive = true
                            } else {
                                // No user is signed in.
                                if email == ""{
                                    emailError = true
                                }
                                if password == ""{
                                    passwordError = true
                                }
                            }
                        }){
                            Text("Login")
                        }
                        Button(action:{//サインイン
                            let email_signin:String = email
                            let password_singin:String = password
                            Auth.auth().createUser(withEmail: email_signin, password: password_singin)
                            if Auth.auth().currentUser != nil {
                                isActive = true
                                // User is signed in.
                            } else {
                                // No user is signed in
                                if email == ""{
                                    emailError = true
                                }
                                if password == ""{
                                    passwordError = true
                                }
                                Text("サインインすることができません")
                            }
                            
                        }){
                            Text("Signin")
                        }
                    }
                    NavigationLink(destination: Home(),isActive: $isActive){Text("画面が遷移されない場合はこちら")}
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

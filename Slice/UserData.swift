//
//  UserData.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-26.
//

import Foundation

struct User {
    var name: String
    var hcp: Int
    var email: String
    var image: String
}
class UserViewModel: ObservableObject {
    @Published var user: User
    
    init() {
        self.user = User (name: "Max", hcp: 16, email:"max.eidet@gmail.com", image: "profile")
    }
}

//
//  Influencer.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 08/01/2023.
//

import Foundation

struct User : Codable {
    let uid : String
    let email: String
    let instaHandle : String
    let accountname: String
    let accountNumberString : String
    let bankName : String
    var isAdmin : Bool
    
    init(userId uid : String, email : String, instaHandle : String) {
        self.uid = uid
        self.email = email
        self.instaHandle = instaHandle
        accountname = ""
        accountNumberString = ""
        bankName = ""
        isAdmin = false
    }
}

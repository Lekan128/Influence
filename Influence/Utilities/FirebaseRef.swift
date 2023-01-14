//
//  FirebaseRef.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 09/01/2023.
//

import Foundation
import Firebase

struct FirebaseRef {
    static func getUserReference(userId uid : String) -> DocumentReference {
        return Firestore.firestore().document("\(k.col.userCollection)/\(uid)")
    }
    
    static func getSongReference() -> CollectionReference {
        return Firestore.firestore().collection(k.col.songCollection)
    }
    
    static func getSongReferenceWithId(songId : String ) -> DocumentReference{
        return getSongReference().document(songId)
    }
    
}

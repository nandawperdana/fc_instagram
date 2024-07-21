//
//  FirebaseReference.swift
//  InstagramClone
//
//  Created by nandawperdana on 17/07/24.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Follower
    case Following
}

struct FirebaseReference {
    static func getReference(_ collectionReference: FCollectionReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
    }
}

//
//  SharingMix.swift
//  HooMi
//
//  Created by Родион on 15.01.2018.
//  Copyright © 2018 Rodion Kuskov. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
class Mix {
    var MixName: String!
    var MixDesc: String!
    var imageUrl: String!
    var image: UIImage!
    var mixBowl: String!
    var mixStrength: String!
    init (image: UIImage, MixName: String, MixDesc: String, mixBowl: String, mixStrength: String) {
        self.image = image
        self.MixDesc = MixDesc
        self.MixName = MixName
        self.mixBowl = mixBowl
        self.mixStrength = mixStrength
    }
    
    init (snapshot: DataSnapshot) {
        let json = JSON(snapshot.value ?? "")
        self.imageUrl = json["imageUrl"].stringValue
        self.MixName = json["MixName"].stringValue
        self.MixDesc = json["MixDesc"].stringValue
        self.mixBowl = json["mixBowl"].stringValue
        self.mixStrength = json["mixStrength"].stringValue
    }
    
    func saveIntoDatabase() {
        let mixRef = Database.database().reference().child("Mix").childByAutoId()
        let mixKey = mixRef.key
        let imageStorageRef = Storage.storage().reference().child("Images")
        let newImageRef = imageStorageRef.child(mixKey)
        
        if let imageData = UIImageJPEGRepresentation(self.image, 0.5) {
            newImageRef.putData(imageData).observe(.success, handler: { (snapshot) in
                self.imageUrl = snapshot.metadata?.downloadURL()?.absoluteString
                let newMixDict = ["imageUrl" : self.imageUrl, "MixName" : self.MixName, "MixDesc" : self.MixDesc, "mixBowl":self.mixBowl, "mixStrength" : self.mixStrength]
                mixRef.setValue(newMixDict)
            })
        }
        
    }
    
}

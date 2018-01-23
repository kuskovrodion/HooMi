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
    
    var firstTabackName: String!
    var firstTabackPercents: String!
    var secondTabackName: String?
    var secondTabackPercents: String?
    var thirdTabackName: String?
    var thirdTabackPercents: String?
    var forthTabackNamme: String?
    var forthTabackPercents: String?
    
    init (image: UIImage, MixName: String, MixDesc: String, mixBowl: String, mixStrength: String,firstTabackName: String,firstTabackPercents: String, secondTabackName: String, secondTabackPercents: String, thirdTabackName: String, thirdTabackPercents: String, forthTabackNamme: String, forthTabackPercents: String) {
        
        self.image = image
        self.MixDesc = MixDesc
        self.MixName = MixName
        self.mixBowl = mixBowl
        self.mixStrength = mixStrength
        
        self.firstTabackName = firstTabackName
        self.firstTabackPercents = firstTabackPercents
        self.secondTabackName = secondTabackName
        self.secondTabackPercents = secondTabackPercents
        self.thirdTabackName = thirdTabackName
        self.thirdTabackPercents = thirdTabackPercents
        self.forthTabackNamme = forthTabackNamme
        self.forthTabackPercents = forthTabackPercents
        
    }
    
    init (snapshot: DataSnapshot) {
        let json = JSON(snapshot.value ?? "")
        self.imageUrl = json["imageUrl"].stringValue
        self.MixName = json["MixName"].stringValue
        self.MixDesc = json["MixDesc"].stringValue
        self.mixBowl = json["mixBowl"].stringValue
        self.mixStrength = json["mixStrength"].stringValue
        
        self.firstTabackName = json["1name"].stringValue
        self.firstTabackPercents = json["1%"].stringValue
        self.secondTabackName = json["2name"].stringValue
        self.secondTabackPercents = json["2%"].stringValue
        self.thirdTabackName = json["3name"].stringValue
        self.thirdTabackPercents = json["3%"].stringValue
        self.forthTabackNamme = json["4name"].stringValue
        self.forthTabackPercents = json["4%"].stringValue
    }
    
    func saveIntoDatabase() {
        let mixRef = Database.database().reference().child("Mix").childByAutoId()
        let mixKey = mixRef.key
        let imageStorageRef = Storage.storage().reference().child("Images")
        let newImageRef = imageStorageRef.child(mixKey)
        
        if let imageData = UIImageJPEGRepresentation(self.image, 0.5) {
            newImageRef.putData(imageData).observe(.success, handler: { (snapshot) in
                self.imageUrl = snapshot.metadata?.downloadURL()?.absoluteString
                let newMixDict = ["imageUrl" : self.imageUrl, "MixName" : self.MixName, "MixDesc" : self.MixDesc, "mixBowl":self.mixBowl, "mixStrength" : self.mixStrength, "1name" : self.firstTabackName, "1%":self.firstTabackPercents, "2name":self.secondTabackName, "2%":self.secondTabackPercents, "3name":self.thirdTabackName, "3%":self.thirdTabackPercents, "4name":self.forthTabackNamme, "4%":self.forthTabackPercents]
                mixRef.setValue(newMixDict)
            })
        }
        
    }
    
}

//
//  MainScreenTableViewCell.swift
//  HooMi
//
//  Created by Родион on 15.01.2018.
//  Copyright © 2018 Rodion Kuskov. All rights reserved.
//

import UIKit
import Firebase
class MainScreenTableViewCell: UITableViewCell {

    var mix : Mix! {
        didSet {
            self.setDataToMix()
        }
    }
    
    @IBOutlet weak var MainNameLabel: UILabel!
    @IBOutlet weak var MainDescLabel: UILabel!
    @IBOutlet weak var MainPictureView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataToMix(){
        self.MainNameLabel.text = mix.MixName
        self.MainDescLabel.text = mix.MixDesc
        
        if let imageUrl = mix.imageUrl {
            let imgStorageRef = Storage.storage().reference(forURL :imageUrl)
            imgStorageRef.getData(maxSize: 3 * 1024 * 1024, completion: { [weak self] (data, error) in
                if let error = error  {
                    print(error)
                } else {
                    if let imgData = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: imgData)
                            self?.MainPictureView.image = image
                        }

                    }
                }
            })
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

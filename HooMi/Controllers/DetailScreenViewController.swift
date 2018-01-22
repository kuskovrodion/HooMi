//
//  DetailScreenViewController.swift
//  HooMi
//
//  Created by Родион on 16.01.2018.
//  Copyright © 2018 Rodion Kuskov. All rights reserved.
//

import UIKit
import Firebase
import Social

class DetailScreenViewController: UIViewController {

    
    var detail : Mix?
    
    
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailDescLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailBowlLabel: UILabel!
    
    
    
    
    func setting() {
        detailNameLabel.text = detail?.MixName
        detailDescLabel.text = detail?.MixDesc
        detailBowlLabel.text = detail?.mixBowl
        detailImageView.image = detail?.image
        
        if let imageUrl = detail?.imageUrl {
            let imgStorageRef = Storage.storage().reference(forURL :imageUrl)
            imgStorageRef.getData(maxSize: 3 * 1024 * 1024, completion: { [weak self] (data, error) in
                if let error = error  {
                    print(error)
                } else {
                    if let imgData = data {
                        DispatchQueue.main.async {
                            let image = UIImage(data: imgData)
                            self?.detailImageView.image = image
                        }
                        
                    }
                }
            })
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setting()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }

}

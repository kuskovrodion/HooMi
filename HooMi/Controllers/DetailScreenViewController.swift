//
//  DetailScreenViewController.swift
//  HooMi
//
//  Created by Родион on 16.01.2018.
//  Copyright © 2018 Rodion Kuskov. All rights reserved.
//

import UIKit
import Firebase
import RKPieChart

class DetailScreenViewController: UIViewController {

    var detail : Mix?

    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailDescLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailBowlLabel: UILabel!
    @IBOutlet weak var detailStrengthLabel: UILabel!

    @IBOutlet weak var bottomImageView: UIImageView!
    
    func setting() {
        detailNameLabel.text = detail?.MixName
        detailDescLabel.text = detail?.MixDesc
        detailBowlLabel.text = detail?.mixBowl

//        detailImageView.image = detail?.image
        detailStrengthLabel.text = detail?.mixStrength


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
                            self?.bottomImageView.image = image
                        }

                    }
                }
            })
        }

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setting()
        setUpDiagramm()

    }

    func setUpDiagramm() {
        let xd1 = detail?.firstTabackPercents
        let test1 = uint(xd1!)

        let xd2 = detail?.secondTabackPercents
        let test2 = uint(xd2!)

        let xd3 = detail?.thirdTabackPercents
        let test3 = uint(xd3!)

        let xd4 = detail?.forthTabackPercents
        let test4 = uint(xd4!)



        let firstItem: RKPieChartItem = RKPieChartItem(ratio: (test1!), color: UIColor(red: 155/255, green: 205/255, blue: 237/255, alpha: 1.0), title: detail?.firstTabackName)


        let secondItem: RKPieChartItem = RKPieChartItem(ratio: (test2!), color: UIColor(red: 147/255, green: 19/255, blue: 28/255, alpha: 1.0), title: detail?.secondTabackName)


        let thirdItem: RKPieChartItem = RKPieChartItem(ratio: (test3!), color: UIColor(red: 0/255, green: 208/255, blue: 91/255, alpha: 1.0), title: detail?.thirdTabackName)

        let forthItem: RKPieChartItem = RKPieChartItem(ratio: (test4!), color: UIColor(red: 150/255, green: 100/255, blue: 163/255, alpha: 1.0), title: detail?.forthTabackNamme)

        let chartView = RKPieChartView(items: [firstItem, secondItem, thirdItem, forthItem], centerTitle: "")
//        let chartView = RKPieChartView(items: [firstItem, secondItem], centerTitle: "")
        chartView.circleColor = .clear
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.arcWidth = 30
        chartView.isIntensityActivated = false
        chartView.style = .butt
        chartView.isTitleViewHidden = false
        chartView.isAnimationActivated = true
        self.view.addSubview(chartView)

        chartView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        chartView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        chartView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        chartView.topAnchor.constraint(equalTo: detailStrengthLabel.topAnchor, constant: 20).isActive = true
        chartView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
private extension UIColor {
    var dark: UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.4, 0.0), green: max(g - 0.4, 0.0), blue: max(b - 0.4, 0.0), alpha: a)
        }
        
        return UIColor()
    }
    var light: UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: min(r + 0.4, 1.0), green: min(g + 0.4, 1.0), blue: min(b + 0.4, 1.0), alpha: a)
        }
        
        return UIColor()
    }
    
}



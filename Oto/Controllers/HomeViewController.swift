//
//  HomeViewController.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 24/7/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var sldTimeLineCar: UISlider!
    @IBOutlet weak var subViewTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sldTimeLineCar.setThumbImage(UIImage(named: "truck"), for: .normal)
        sldTimeLineCar.value = 0
    }
}

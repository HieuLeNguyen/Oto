//
//  HomeViewController.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 24/7/24.
//

import UIKit

class HomeViewController: UIViewController {
<<<<<<< HEAD

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

=======
    @IBOutlet weak var sldTimeLineCar: UISlider!
    @IBOutlet weak var subViewTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sldTimeLineCar.setThumbImage(UIImage(named: "truck"), for: .normal)
        sldTimeLineCar.value = 0
    }
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))
}

//
//  MailViewController.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 24/7/24.
//

import UIKit

class MailViewController: UIViewController {
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

}
=======
    @IBOutlet weak var tableView: UITableView!
    
    var mailList: [String] = [
        "Thông báo sắp hết hạn bảo dưỡng xe!",
        "Thông báo nội quy mới dành cho tài xe",
        "Thưởng khi đặt mốc 200k/ ngày, ...",
        "Thông báo mới nhất"
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension MailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hộp thư"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMail", for: indexPath)
        cell.textLabel?.text = mailList[indexPath.row]
        return cell
    }
    
}
>>>>>>> 6cb3d12 (feature: auth with api (login, logout, user))

//
//  MailViewController.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 24/7/24.
//

import UIKit

class MailViewController: UIViewController {

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

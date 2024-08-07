//
//  MyViewController.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 24/7/24.
//

import UIKit

class MyViewController: UIViewController {
    @IBOutlet weak var tblMe: UITableView!
    
    var profile: [String] = [String]()
    
    var setting = ["Nhập, xuất số nhiên liệu tiêu thụ", "Lịch sử", "Hướng dẫn", "Cài đặt mật khẩu"]
    
    var logout = ["Đăng xuất"]
    
    var arrMe: [[String]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrMe = [profile, setting, logout]
        
        tblMe.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tblMe.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewCell")
        tblMe.register(UINib(nibName: "LogoutTableViewCell", bundle: nil), forCellReuseIdentifier: "LogoutTableViewCell")
        
        let token = UserDefaults.standard.string(forKey: "token") ?? ""

        NetworkManager.shared.token = token
        
        loadUserInfo()
        
    }
    
    func loadUserInfo() {
        
        APIService.shared.infoUser { [weak self] result in
            
            switch result {
            case .success(let userResponse):
                let user = userResponse.data.user
                self?.profile = [user.name]
                self?.arrMe[0] = self?.profile ?? []
                
                // refresh table
                DispatchQueue.main.async {
                    self?.tblMe.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    //MARK: View Xác nhận - logout
    func showLogoutConfirmationAlert() {
        let alertController = UIAlertController(title: "Xác nhận", message: "Bạn có chắc chắn muốn đăng xuất?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Hủy", style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: "Đăng xuất", style: .destructive) { [weak self] _ in
            self?.performLogout()
            print("Confirm")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func performLogout() {
        APIService.shared.logout { [weak self] result in
            UserDefaults.standard.removeObject(forKey: "token")
            
            DispatchQueue.main.async {
                
                let userDefaultHasToken = UserDefaults.standard.string(forKey: "token")
                
                if userDefaultHasToken == nil || userDefaultHasToken == ""  {
                    print("Logout success!")
                    self?.navigateToLoginScreen()
                }
            }
        }
    }


    // MARK: - Navigation View Login
    func navigateToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.navigationItem.hidesBackButton = true
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
    }

    
    // MARK: - Error Alert
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Lỗi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension MyViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrMe.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMe[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.lblTitle?.text = arrMe[indexPath.section][indexPath.row]
            cell.frame.size.height = 96
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
            cell.textLabel?.text = arrMe[indexPath.section][indexPath.row]
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
            cell.textLabel?.text = arrMe[indexPath.section][indexPath.row]
            cell.textLabel?.textColor = .red
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            "Thông tin cá nhân"
        case 1:
            "Cài đặt và quản lý"
        case 2:
            "--"
        default:
            nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            let selectedProfileItem = arrMe[indexPath.section][indexPath.row]
            print("Selected profile item: \(selectedProfileItem)")
            // Handle profile item click
        case 1:
            let selectedSettingItem = arrMe[indexPath.section][indexPath.row]
            print("Selected setting item: \(selectedSettingItem)")
            // Handle setting item click
        case 2:
            print("Selected logout")
            showLogoutConfirmationAlert()
            
        default:
            break
        }
    }

}

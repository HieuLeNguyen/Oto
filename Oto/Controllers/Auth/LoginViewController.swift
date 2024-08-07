//
//  LoginViewController.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 23/7/24.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblFailurePhone: UILabel!
    @IBOutlet weak var lblFailurePw: UILabel!
//    @IBOutlet weak var btnEye: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFailurePhone.text = ""
        lblFailurePw.text = ""
        
        txtPhone.text = "0123456789"
        txtPassword.text = "123123"
        
//        txtPassword.isSecureTextEntry = true
    }
    
//    @IBAction func ac_Eye(_ sender: UIButton) {
//        txtPassword.isSecureTextEntry = false
//    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        lblFailurePhone.text = ""
        lblFailurePw.text = ""
        
        let phone = txtPhone.text
        let password = txtPassword.text
        
        var hasError = false
        
        if let phone = phone, phone.isEmpty {
            lblFailurePhone.text = "The phone field is required."
            hasError = true
        }
        
        if let password = password, password.isEmpty {
            lblFailurePw.text = "The password field is required."
            hasError = true
        }
        
        if hasError {
            return
        }
        
        
        APIService.shared.login(
            params: ["phone": phone!, "password": password!]
        ) { [weak self] result in
            
            switch result {
            case .success(let loginResponse):
                self?.navigateToHome()
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(loginResponse.data.tokenType, forKey: "token_type")
                userDefaults.set(loginResponse.data.accessToken, forKey: "token")
                userDefaults.synchronize()
                
            case .failure(let error):
                self?.handleLoginError(error)
            }
        }
    }
    
    // MARK: Xử lý lỗi tùy thuộc vào kiểu lỗi
    private func handleLoginError(_ error: NetworkError) {
        switch error {
        case .apiError(let errorRes):
            if let errors = errorRes.errors {
                if let phoneErrors = errors.phone, !phoneErrors.isEmpty {
                    self.lblFailurePhone.text = phoneErrors.joined(separator: "\n")
                }
                if let passwordErrors = errors.password, !passwordErrors.isEmpty {
                    self.lblFailurePw.text = passwordErrors.joined(separator: "\n")
                }
            } else {
                self.lblFailurePw.text = errorRes.message
            }
            
        case .invalidURL:
            // Xử lý lỗi URL không hợp lệ
            print("Invalid URL. Please try again.")
            
        case .noData:
            // Xử lý lỗi không có dữ liệu
            print("No data received. Please try again.")
        }
    }

    // MARK: Xử lý điều hướng
    private func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
            print("Not find TabBarViewController with identifier 'TabBarViewController'.")
            return
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true) {
            tabBarVC.showAlert("Đăng nhập thành công!")
        }
    }

}


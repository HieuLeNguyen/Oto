//
//  AppDelegate.swift
//  Oto
//
//  Created by Nguyễn Văn Hiếu on 23/7/24.
//

import UIKit
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let monitor = NWPathMonitor()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Connected Network")
                DispatchQueue.main.async {
                    self.handleAppLaunch()
                }
            } else {
                print("No connection Network")
                DispatchQueue.main.async {
                    self.showNetworkErrorInterface()
                }
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Xử lý khi người dùng bỏ các phiên làm việc
    }
    
    // MARK: - Helper Methods
    
    func handleAppLaunch() {
        // Kiểm tra token khi ứng dụng khởi động
        if let token = UserDefaults.standard.string(forKey: "token"), !token.isEmpty {
            
            showMainInterface()
        } else {

            showLoginInterface()
        }
    }
    
    func showMainInterface() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
            return
        }
        let navController = UINavigationController(rootViewController: tabBarVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func showLoginInterface() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }
    
    func showNetworkErrorInterface() {
        let alert = UIAlertController(title: "Lỗi kết nối mạng", message: "Không có kết nối mạng. Vui lòng kiểm tra lại kết nối của bạn.", preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Thử lại", style: .default) { _ in
            if self.isConnectedToNetwork() {
                self.handleAppLaunch()
            } else {
                self.showNetworkErrorInterface()
            }
        }
        alert.addAction(retryAction)
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func isConnectedToNetwork() -> Bool {
        let monitor = NWPathMonitor()
        var isConnected = false
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                isConnected = true
            } else {
                isConnected = false
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        
        return isConnected
    }
}

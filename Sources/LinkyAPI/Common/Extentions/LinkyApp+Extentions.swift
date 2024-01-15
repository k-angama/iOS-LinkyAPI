//
//  LinkyApp+Extentions.swift
//  LinkyAPI
//
//  Created by Karim Angama on 15/01/2024.
//

import UIKit


extension UIApplication {
    
    var rootViewController: UIViewController? {
        guard let scene = self.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window,
              let rootViewController = window?.rootViewController else { return nil }
        return rootViewController
    }
    
    var topViewController: UIViewController? {
        
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController.topViewController?.presentedViewController ?? navigationController.topViewController
        }
        
        if let presentedViewController = rootViewController?.presentedViewController {
            return presentedViewController
        }
        
        return rootViewController
    }
    
}


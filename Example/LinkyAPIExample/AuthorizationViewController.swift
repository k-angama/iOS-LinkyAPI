//
//  ViewController.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 13/06/2023.
//

import UIKit
import LinkyAPI
import SwiftUI

class AuthorizationViewController: UIViewController {
    
    var linkyAuth: LinkyAuthorization!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = LinkyConfiguration(
            clientId: Env.clientID,
            clientSecret: Env.clientSecret,
            redirectURI: URL(string: Env.redirectURI)!,
            mode: .sandbox(prm: .client7(.prm2)),
            duration: .day(value: 1)
        )
        linkyAuth = LinkyAuthorization(configuration: configuration)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayScreen()
    }

    @IBAction func openAutorization(_ sender: Any) {
        linkyAuth.authorization { [weak self] error in
            if error == nil {
                self?.displayScreen()
            }else if let error = error {
                self?.displayErrorMessage(error)
            }
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        linkyAuth.logout()
        displayResetMessage()
    }
    
    private func displayScreen() {
        if linkyAuth.isAccess {
            DispatchQueue.main.async { [weak self] in
                self?.present(UIHostingController(rootView: ContentChart()), animated: true)
            }
        }
    }
    
    private func displayResetMessage() {
        let action = UIAlertAction(title: "OK", style: .default)
        let alert = UIAlertController(title: "Log out client", message: "Reset auth data.", preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func displayErrorMessage(_ error: Error) {
        let action = UIAlertAction(title: "OK", style: .default)
        let alert = UIAlertController(title: "Error", message: "Error API\n\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}


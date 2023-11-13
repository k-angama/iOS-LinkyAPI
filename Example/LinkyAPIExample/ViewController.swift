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
            //clientId: "e882c1ea-add0-4d9b-ac79-96513c88bfbe",
            clientId: "09f2a00e-812d-451c-9805-38bdce602ac9",
            clientSecret: "a832d50f-afa8-4f6d-a345-120864c9adfb",
            redirectURI: URL(string: "conso.vercel.app")!,
            mode: .sandbox(prm: .client5),
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
            }else{
                // TODO display error
            }
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        linkyAuth.reset()
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
        let alert = UIAlertController(title: "reset", message: "reset", preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func displayErrorMessage() {
        
    }
    
}


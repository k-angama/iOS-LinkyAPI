//
//  LinkyAPI.swift
//  LinkyAPI
//
//  Created by Karim Angama on 13/06/2023.
//

import Foundation
import WebKit
import UIKit

/// Launch the authorization request
/// To access customer metering data APIs, the application must first obtain permission from the customer.
/// It requires the authentication of the end customer with Enedis and their free, explicit and informed consent.
///
/// - Parameter configuration: Information to access API data
/// 
public class LinkyAuthorization {
    
    /// Submits a block for synchronous execution
    ///
    ///- Parameter error: An error object that indicates why the request failed, or nil if the request was successful.
    ///
    public typealias AuthorizationCompletion = (_ error: Error?) -> Void
    
    /// Indicates whether access has already been authorized
    ///
    public var isAccess: Bool {
        get {
            if configuration.mode != .production
                && account.getUsagePointsId() != nil
                && configuration.mode.prm != account.getUsagePointsId() {
                account.deleteUsagePointsId()
            }
            return account.isAccess
        }
    }
    
    /// Indicates selected usage point id (PRM)
    ///
    public var usagePointIdSelected: String?  {
        get {
            return account.getUsagePointsId()
        }
    }
    
    private(set) var configuration: LinkyConfiguration
    private(set) var account: LinkyAccount
    private(set) var serviceAPI: LinkyAPI
    private(set) var authorizationBlok: AuthorizationCompletion?
    
    /// Launch the authorization request
    /// 
    /// - Parameter configuration: Information to access API data
    ///
    public convenience init(configuration: LinkyConfiguration) {
        let account = LinkyAccountImpl()
        self.init(
            configuration: configuration,
            account: LinkyAccountImpl(),
            serviceAPI: LinkyServiceAPI(
                configuration: configuration,
                account: account
            )
        )
    }
    
    
    // MARK: - Public methode
    
    /// Display a view for the user to accepts the sharing of this consumptions data
    ///
    /// - Parameter completionHandler : The completion handler to call when the authorization is complete.
    ///
    public func authorization(completionHandler: @escaping AuthorizationCompletion) {
        if !isAccess {
            self.authorizationBlok = completionHandler
            displayWebViewScreen()
        }else{
            completionHandler(nil)
        }
    }
    
    /// Reset account
    ///
    public func logout() {
        account.deleteAcceesToken()
        account.deleteUsagePointsId()
        account.setExpireAccessToken(0)
    }
    
    
    // MARK: - Internal methode
    
    internal init(configuration: LinkyConfiguration, account: LinkyAccount, serviceAPI: LinkyAPI) {
        self.configuration = configuration
        self.account = account
        self.serviceAPI = serviceAPI
        LinkyConsumption.shared.linkyAPI = serviceAPI
        LinkyCustomer.shared.linkyAPI = serviceAPI
    }
    
    internal func handleResponse(usagePointsId: String?, state: String?, error: Error?) {
        if (state != configuration.state || error != nil) && usagePointsId == nil {
            if error != nil {
                self.authorizationBlok?(error)
            }else {
                self.authorizationBlok?(LinkyAuthorizationError.stateAuthorization)
            }
            dismissScreen()
        } else if let usagePointsId = usagePointsId {
            if account.getUsagePointsId() == nil {
                account.setUsagePointsId(usagePointsId)
            }
            handleAccessToken()
        }else{
            self.authorizationBlok?(LinkyAuthorizationError.authorization)
            dismissScreen()
        }
    }
    
    internal func displayWebViewScreen() {
        let nc = UINavigationController(
            rootViewController: LinkyWebViewController(
                configuration: configuration,
                account: account,
                block: handleResponse)
        )
        UIApplication.shared.topViewController?.present(nc, animated: true)
    }
    
    internal func dismissScreen() {
        DispatchQueue.main.async {
            let viewController = UIApplication.shared.topViewController
            viewController?.dismiss(animated: true)
        }
    }
    
    internal func handleAccessToken() {
        self.serviceAPI.accessToken { [weak self] accessToken, error in
            if (accessToken != nil) {
                self?.account.setAcceesToken(accessToken?.access_token ?? "")
                self?.account.setExpireAccessToken(accessToken?.expires_in ?? 0)
                self?.dismissScreen()
                self?.authorizationBlok?(nil)
            } else if error != nil {
                self?.logout()
                self?.dismissScreen()
                self?.authorizationBlok?(error)
            }
        }
    }
    
}

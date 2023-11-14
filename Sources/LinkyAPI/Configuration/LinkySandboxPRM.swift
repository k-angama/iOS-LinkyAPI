//
//  LinkySandboxPRM.swift
//  LinkyAPI
//
//  Created by Karim Angama on 08/11/2023.
//

import Foundation

/**
 PRM de client permettant de tester en mode bac a sable
 */
public enum LinkySandboxPRM {
    
    /// Client qui ne possède qu’un seul point de livraison de consommation pour lequel il a activé la courbe de charge.
    /// Ses données sont remontées de manière exacte (sans « trou » de données) et son compteur a été mis en service au début du déploiement Linky.
    public enum LinkySandboxClien0: String {
        case prm1 = "22516914714270"
    }
    case client0(LinkySandboxClien0)
    
    /// Client qui ne possède qu’un seul point de livraison de consommation pour lequel il a activé la courbe de charge.
    /// Ses données sont remontées de manière exacte (sans « trou » de données) et son compteur a été mis en service le 27 août 2019.
    public enum LinkySandboxClien1: String {
        case prm1 = "11453290002823"
    }
    case client1(LinkySandboxClien1)
    
    /// Client qui ne possède qu’un seul point de livraison de consommation pour lequel il n’a pas activé la courbe de charge.
    /// Ses données sont remontées de manière exacte (sans « trou » de données) et son compteur a été mis en service au début du déploiement Linky.
    public enum LinkySandboxClien2: String {
        case prm1 = "32320647321714"
    }
    case client2(LinkySandboxClien2)
    
    /// Client qui possède un point de livraison de consommation et un point de livraison de production pour lesquels il a activé les courbes de charge.
    /// Ses données sont remontées de manière exacte (sans « trou » de données) et ses compteurs ont été mis en service au début du déploiement Linky.
    public enum LinkySandboxClien3: String {
        case prm1 = "12345678901234"
        case prm2 = "10284856584123"
    }
    case client3(LinkySandboxClien3)
    
    /// Client qui possède qu’un  seul point de livraison de consommation pour lequel il a activé la courbe de charge.
    /// Ses données présentent des « trous » de données les mardis et mercredis et son compteur a été mis en service au début
    /// du déploiement Linky
    public enum LinkySandboxClien4: String {
        case prm1 = "42900589957123"
    }
    case client4(LinkySandboxClien4)
    
    /// Client qui possède qu’un seul point de livraison de production pour lequel il a activé la courbe de charge.
    /// Ses données sont remontées de manière exacte (sans « trou » de données) et son compteur a été mis en service au début du déploiement Linky.
    public enum LinkySandboxClien5: String {
        case prm1 = "24880057139941"
    }
    case client5(LinkySandboxClien5)
    
    /// Client qui possède un point de livraison d’ auto-consommation pour lequel il a activé la courbe de charge en production et en consommation.
    /// Pour chaque point prélevé, lorsque la consommation est supérieur à la production les données de consommation remontées correspondent à
    /// la consommation moins la production et la production est nulle. Inversement lorsque la production est supérieure à la consommation.
    /// Ses données sont remontées de manière exacte (sans « trou » de données) et son compteur a été mis en service au début du déploiement Linky.
    public enum LinkySandboxClien6: String {
        case prm1 = "12655648759651"
    }
    case client6(LinkySandboxClien6)
    
    /// Client qui possède trois points de livraison de consommation  pour lesquels il a activé les courbes de charge.
    /// Ses données sont remontées de manière exacte (sans « trou » de données) et ses compteurs ont été mis en service au début du déploiement Linky.
    public enum LinkySandboxClien7: String {
        case prm1 = "64975835695673"
        case prm2 = "63695879465986"
        case prm3 = "22315546958763"
    }
    case client7(LinkySandboxClien7)
    
    /// Client qui donne son consentement mais le révoque immédiatement après l’avoir donné.
    public enum LinkySandboxClien8: String {
        case prm1 = "26584978546985"
    }
    case client8(LinkySandboxClien8)
    
    // Return the prm selected
    var prm: String {
        switch self {
        case .client0(let prm1):
            return prm1.rawValue
        case .client1(let prm1):
            return prm1.rawValue
        case .client2(let prm1):
            return prm1.rawValue
        case .client3(let prm1):
            return prm1.rawValue
        case .client4(let prm1):
            return prm1.rawValue
        case .client5(let prm1):
            return prm1.rawValue
        case .client6(let prm1):
            return prm1.rawValue
        case .client7(let prm1):
            return prm1.rawValue
        case .client8(let prm1):
            return prm1.rawValue
        }
    }
    
}

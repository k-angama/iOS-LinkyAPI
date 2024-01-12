//
//  LinkyURL+Extentions.swift
//  LinkyAPI
//
//  Created by Karim Angama on 12/01/2024.
//

import Foundation

extension URL {
    func formatted() -> URL? {
        if(self.scheme == nil) {
            return URL(string: "https://\(self)")
        }
        if(self.host == nil) {
            return nil
        }
        return self
    }
}

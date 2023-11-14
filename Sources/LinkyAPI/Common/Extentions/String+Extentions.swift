//
//  String+Extentions.swift
//  LinkyAPI
//
//  Created by Karim Angama on 26/06/2023.
//

import Foundation

extension String {
    func date() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = self.count == 10 ? "YYYY-MM-dd" : "YYYY-MM-dd HH:mm:ss"
        return formatter.date(from: self) ?? Date.now
    }

}

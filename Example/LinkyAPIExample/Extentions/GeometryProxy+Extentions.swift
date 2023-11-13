//
//  GeometryProxy+Extentions.swift
//  LinkyAPIExample
//
//  Created by Karim Angama on 07/07/2023.
//

import Foundation
import SwiftUI

extension GeometryProxy {
    func sizeChar(_ count: Int) -> CGFloat {
        let width = 32 * CGFloat(count)
        return width < size.width ? size.width - 60 : width
    }
}

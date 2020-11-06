//
//  UIBezierPathExtension.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/6/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath {
    convenience init(lineSegment: Line) {
        self.init()
        self.move(to: lineSegment.startPoint)
        self.addLine(to: lineSegment.endPoint)
    }
}

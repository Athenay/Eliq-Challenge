//
//  CALayerExtension.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/6/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func addLineLayer(lineSegment: Line, color: CGColor, width: CGFloat) {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(lineSegment: lineSegment).cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color
        layer.lineWidth = width
        self.addSublayer(layer)
    }
    
    func addTextLayer(frame: CGRect, color: CGColor, fontSize: CGFloat, text: String) {
        let textLayer = CATextLayer()
        textLayer.frame = frame
        textLayer.foregroundColor = color
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = fontSize
        textLayer.string = text
        self.addSublayer(textLayer)
    }
    
    func addRectangleLayer(frame: CGRect, color: CGColor) {
        let layer = CALayer()
        layer.frame = frame
        layer.backgroundColor = color
        self.addSublayer(layer)
    }
    
    func addCornerRadius(_ value: CGFloat) {
        self.masksToBounds = true
        self.cornerRadius = value
    }
}

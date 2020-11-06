//
//  BarChartModel.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/6/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation
import UIKit

struct BarDataSet {
    let origin: CGPoint
    let barWidth: CGFloat
    let barHeight: CGFloat
    let space: CGFloat
    let data: DataEntry
    var barFrame: CGRect {
        return CGRect(x: origin.x, y: origin.y, width: barWidth, height: barHeight)
    }
}

struct AxisLine {
    let segment: Line
    let width: CGFloat
}


struct DataEntry {
    let color: UIColor
    let height: Float
}


struct Line {
    let startPoint: CGPoint
    let endPoint: CGPoint
}

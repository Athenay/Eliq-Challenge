//
//  BarChartHelper.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/6/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation
import UIKit

class BarChartHelper {
    let barWidth: CGFloat
    let space: CGFloat
    private let bottomSpace: CGFloat = 10.0
    private let topSpace: CGFloat = 10.0
    private let rightSpace: CGFloat = 20
    var dataEntries: [DataEntry] = []
    
    init(barWidth: CGFloat = 20, space: CGFloat = 10) {
        self.barWidth = barWidth
        self.space = space
    }
    
    func computeContentWidth(frame: CGRect) -> CGFloat {
        return max(frame.size.width - rightSpace, (barWidth + space) * CGFloat(dataEntries.count) + space)
    }
    
    func computeBarEntries(viewHeight: CGFloat) -> [BarDataSet] {
        var result: [BarDataSet] = []
        
        for (index, entry) in dataEntries.enumerated() {
            let entryHeight = CGFloat(entry.height) * (viewHeight - bottomSpace - topSpace)
            let xPosition: CGFloat = space + CGFloat(index) * (barWidth + space)
            let yPosition = viewHeight - bottomSpace - entryHeight
            let origin = CGPoint(x: xPosition, y: yPosition)
            let barEntry = BarDataSet(origin: origin, barWidth: barWidth, barHeight: entryHeight, space: space, data: entry)
            result.append(barEntry)
        }
        return result
    }
    
    func computeAxisLines(frame: CGRect) -> [AxisLine] {
        var result: [AxisLine] = []
        let xAxisYPosition = frame.size.height - bottomSpace
        let length = computeContentWidth(frame: frame)
        let xlineSegment = Line(startPoint: CGPoint(x: 2, y: xAxisYPosition), endPoint: CGPoint(x: length - 2, y: xAxisYPosition))
        let xline = AxisLine(segment: xlineSegment, width: 2.0)
        let ylineSegment = Line(startPoint: CGPoint(x: 2, y: xAxisYPosition), endPoint: CGPoint(x: 2, y: 0))
        let yline = AxisLine(segment: ylineSegment, width: 2.0)
        result.append(xline)
        result.append(yline)
        return result
    }
}

//
//  BarChart.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/6/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation
import UIKit

class BarChart: UIView {
    private let mainLayer: CALayer = CALayer()
    private let scrollView: UIScrollView = UIScrollView()
    private let presenter = BarChartHelper(barWidth: 10, space: 15)
    
    private var barEntries: [BarDataSet] = [] {
        didSet {
            mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
            scrollView.contentSize = CGSize(width: presenter.computeContentWidth(frame: frame), height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            showAxis()
            for (index, entry) in barEntries.enumerated() {
                showEntry(index: index, entry: entry, oldEntry: oldValue.elementAt(index: index))
            }
        }
    }
    
    func updateDataEntries(dataEntries: [DataEntry]) {
        self.presenter.dataEntries = dataEntries
        self.barEntries = self.presenter.computeBarEntries(viewHeight: self.frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateDataEntries(dataEntries: presenter.dataEntries)
    }
    
    private func showEntry(index: Int, entry: BarDataSet, oldEntry: BarDataSet?) {
        let cgColor = entry.data.color.cgColor
        mainLayer.addRectangleLayer(frame: entry.barFrame, color: cgColor)
    }
    
    private func showAxis() {
        self.layer.sublayers?.forEach({
            if $0 is CAShapeLayer {
                $0.removeFromSuperlayer()
            }
        })
        let lines = presenter.computeAxisLines(frame: self.frame)
        lines.forEach { (line) in
            mainLayer.addLineLayer(lineSegment: line.segment, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor, width: line.width)
        }
    }
}

//
//  UIViewControllerExtension.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/6/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    private func setNavItemColor(_ titleColor: UIColor, largeTitleColor: UIColor, barTintColor: UIColor, tintColor: UIColor?, transparentBackground: Bool? = false, titleFont: UIFont?, largeTitleFont: UIFont?) {
        if let navBarAppearance = navigationController?.navigationBar.standardAppearance {
            if let transparentBackground = transparentBackground, transparentBackground {
                navBarAppearance.configureWithTransparentBackground()
            } else {
                navBarAppearance.configureWithDefaultBackground()
            }
            var currentTitleFont: UIFont = UIFont.systemFont(ofSize: 20.0)
            var currentLargeTitleFont: UIFont = UIFont.systemFont(ofSize: 32.0)
            if let titleFont = titleFont {
                currentTitleFont = titleFont
            }
            if let largeTitleFont = largeTitleFont {
                currentLargeTitleFont = largeTitleFont
            }
            
            navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor, .font: currentTitleFont]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor, .font: currentLargeTitleFont]
            navBarAppearance.backgroundColor = barTintColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.standardAppearance = navBarAppearance
        }
    }
}


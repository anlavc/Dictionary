//
//  CFFloat + Ext.swift
//  Dictionary
//
//  Created by Anıl AVCI on 8.02.2023.
//


import UIKit

extension UIViewController {
    var screenWidth: CGFloat {
        return view.frame.size.width
    }
    var screenHeight: CGFloat {
        return view.frame.size.height
    }
}

extension UIView {
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

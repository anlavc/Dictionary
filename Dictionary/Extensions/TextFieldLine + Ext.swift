//
//  TextFieldLine + Ext.swift
//  Dictionary
//
//  Created by Anıl AVCI on 15.02.2023.
//

import UIKit
extension UITextField {
    func addDottedBottomLine() {
        let bottomLine = CAShapeLayer()
        bottomLine.strokeColor = UIColor.red.cgColor
        bottomLine.lineWidth = 1
        bottomLine.lineDashPattern = [2, 2] // çizgi uzunluğu, boşluk uzunluğu
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 3, y: self.frame.size.height - 1), CGPoint(x: self.intrinsicContentSize.width, y: self.frame.size.height - 1)])
        bottomLine.path = path
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}

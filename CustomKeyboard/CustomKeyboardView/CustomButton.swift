//
//  CustomButton.swift
//  CustomKeyboard
//
//  Created by Yudiz Solutions Ltd on 20/02/23.
//

import UIKit

class CustomButton: UIButton {
    @IBInspectable var borderWidth: CGFloat {
           set {
               layer.borderWidth = newValue
           }
           get {
               return layer.borderWidth
           }
       }

       @IBInspectable var cornerRadius: CGFloat {
           set {
               layer.cornerRadius = newValue
           }
           get {
               return layer.cornerRadius
           }
       }

       @IBInspectable var borderColor: UIColor? {
           set {
               guard let uiColor = newValue else { return }
               layer.borderColor = uiColor.cgColor
           }
           get {
               guard let color = layer.borderColor else { return nil }
               return UIColor(cgColor: color)
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
    }
    
    @objc func btnPressed() {
        UIView.animate(withDuration: 0.02, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) }, completion: { (finish: Bool) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform.identity
                })
            })
    }
}


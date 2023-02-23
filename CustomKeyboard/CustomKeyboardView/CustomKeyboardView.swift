//
//  CustomKeyboardView.swift
//  CustomKeyboard
//
//  Created by Yudiz Solutions Ltd on 20/02/23.
//

import UIKit

protocol CustomKeyboardViewDelegate: AnyObject {
  func insertCharacter(_ newCharacter: String)
  func removeCharacter()
}

class CustomKeyboardView: UIView {
    ///Outlets
    @IBOutlet weak var btnKeyboardSwitch: UIButton!
    
    ///Variables
    var isUpperCase: Bool = false
    weak var delegate: CustomKeyboardViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

//MARK: - Button Actions
extension CustomKeyboardView {
    @IBAction func btnLetterTap(_ sender: UIButton) {
        if let txt = sender.titleLabel?.text {
            delegate?.insertCharacter(isUpperCase ? txt.uppercased() : txt.lowercased())
        }
    }
    
    @IBAction func btnClearTap(_ sender: UIButton) {
        delegate?.removeCharacter()
    }
    
    @IBAction func btnSpaceTap(_ sender: UIButton) {
        delegate?.insertCharacter(" ")
    }
    
    @IBAction func btnCaptialTap(_ sender: UIButton) {
        isUpperCase.toggle()
        sender.isSelected = isUpperCase
    }
}


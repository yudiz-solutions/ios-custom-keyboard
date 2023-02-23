//
//  KeyboardViewController.swift
//  CustomKeyboardView
//
//  Created by Yudiz Solutions Ltd on 20/02/23.
//

import UIKit

class KeyboardViewController: UIInputViewController, CustomKeyboardViewDelegate {
    ///Variables
    var customKeyboardView: CustomKeyboardView!
    var lexicon: UILexicon?
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add CustomKeyboardView to the input view
        let nib = UINib(nibName: "CustomKeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        customKeyboardView = objects.first as? CustomKeyboardView
        customKeyboardView.delegate = self
        
        guard let inputView = inputView else { return }
        inputView.addSubview(customKeyboardView)
        customKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customKeyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
            customKeyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            customKeyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
            customKeyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
          ])
                
        customKeyboardView.btnKeyboardSwitch.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        requestSupplementaryLexicon { lexicon in
          self.lexicon = lexicon
        }
    }
    
    override func viewWillLayoutSubviews() {
        customKeyboardView.btnKeyboardSwitch.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        customKeyboardView.btnKeyboardSwitch.setTitleColor(textColor, for: [])
    }

}

//MARK: - Delegate
extension KeyboardViewController {
    func insertCharacter(_ newCharacter: String) {
        replaceWord()
        textDocumentProxy.insertText(newCharacter)
    }
    
    func removeCharacter() {
        textDocumentProxy.deleteBackward()
    }
    
}

//MARK: - For text replace UILexicon
extension KeyboardViewController {
    func replaceWord() {
        if let entries = lexicon?.entries,
           let currentWord = textDocumentProxy.documentContextBeforeInput?.lowercased() {
            let replaceEntries = entries.filter {
                $0.userInput.lowercased() == currentWord
            }
            if let replacement = replaceEntries.first {
                for _ in 0..<currentWord.count {
                    textDocumentProxy.deleteBackward()
                }
                textDocumentProxy.insertText(replacement.documentText)
            }
        }
    }
}

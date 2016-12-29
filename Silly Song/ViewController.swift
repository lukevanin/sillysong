//
//  ViewController.swift
//  Silly Song
//
//  Created by Luke Van In on 2016/12/28.
//  Copyright © 2016 Luke Van In. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lyricsTextView: UITextView!
    
    private let template : String = {
        return [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
            "Banana Fana Fo F<SHORT_NAME>",
            "Me My Mo M<SHORT_NAME>",
            "<FULL_NAME>"
            ].joined(separator: "\n")
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
        nameTextField.becomeFirstResponder()
    }

    @IBAction func onTextDidBeginEditing() {
        reset()
    }

    @IBAction func onTextDidEndEditing() {
        displayLyrics()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    private func reset() {
        nameTextField.text = ""
        lyricsTextView.text = ""
    }
    
    private func displayLyrics() {
        if let name = nameTextField.text, name.characters.count > 0 {
            lyricsTextView.text = lyricsForName(lyricsTemplate: template, fullName: name)
        }
    }
    
    private func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
        var output = lyricsTemplate
        
        //    1. Make a shortened version of the name
        let shortName = shortNameFromName(fullName)
        
        //    2. Replace <FULL_NAME> in the template with the original name
        output = output.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        
        //    3. Replace <SHORT_NAME> in the template from step 2 with the shortened name
        output = output.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        //    4. Return the customized template
        return output
    }
    
    private func shortNameFromName(_ name : String) -> String {
        let output : String
        let name = name.lowercased()
        let vowelsCharacterSet = CharacterSet(charactersIn: "aeiouy")
        let range = name.range(of: name)
        if let r = name.rangeOfCharacter(from: vowelsCharacterSet, options: .diacriticInsensitive, range: range) {
            output = name.substring(from: r.lowerBound)
        }
        else {
            output = name
        }
        return output
    }
}


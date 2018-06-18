//
//  ViewController.swift
//  Silly Song
//
//  Created by Carmine Sampogna on 6/17/18.
//  Copyright © 2018 Carmine Sampogna. All rights reserved.
//

import UIKit

extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {

    let template = ["<FULLNAME>, <FULLNAME>, Bo B<SHORTNAME>,",
                    "Banana Fana Fo F<SHORTNAME>,",
                    "Me My Mo M<SHORTNAME>,",
                    "<FULLNAME>"].joined(separator: "\n")
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if(nameField.text != nil
            && !nameField.text!.isEmpty){
            lyricsView.text = lyricsForName(name: nameField.text!, lyricsTemplate: template)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func lyricsForName (name: String, lyricsTemplate: String) -> String{
        let shortName = shortNameFromName(name);
        if(shortName.count < 2){
            return ""
        }
        let customizedLyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULLNAME>", with: name)
            .replacingOccurrences(of: "<SHORTNAME>", with: shortName)
        return customizedLyrics
    }

    func shortNameFromName(_ name: String) -> String{
        let lowerCasedName = name.lowercased()
        let vowels = CharacterSet(charactersIn: "aeiou")
        let range = lowerCasedName.rangeOfCharacter(from: vowels, options: String.CompareOptions.caseInsensitive)
        if(range == nil){
            return ""
        }
        return String(lowerCasedName.suffix(from: range!.lowerBound))
    }
}


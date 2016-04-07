 //
//  ViewController.swift
//  Piglatin Translator
//
//  Created by block7 on 2/26/16.
//  Copyright © 2016 noahhuppert.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    // MARK: Regular Expressions
    let partsExp = try! NSRegularExpression(pattern: "(\\w+|[^\\w])", options: .CaseInsensitive)
    let translatableExp = try! NSRegularExpression(pattern: "(\\w+)", options: [])
    let capitalExp = try! NSRegularExpression(pattern: "[A-Z]", options: [])
    /*
    let capitalExp = try! NSRegularExpression(pattern: "[A-Z]", options: [])
    let wordExp = try! NSRegularExpression(pattern: "([^\\s]*) ?", options: [])
    let piglatinExp = try! NSRegularExpression(pattern: "([aieou]*)([^aieou]*)(\\w*)", options: .CaseInsensitive)
    */
    
    // MARK: Translators
    let translators: [Translator] = [PiglatinTranslator()]
    var current_translator_index: Int = 0
    
    // MARK: Outlets
    @IBOutlet weak var translatedTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Translator Helpers
    func getCurrentTranslator() -> Translator {
        return translators[current_translator_index]
    }
    
    // MARK: User functions
    func translateToPiglatin(text: String) -> String {
        let parts = RegexHelper.matchRegex(text, regex: partsExp)
        var result: [String] = []
        
        for var i = 0; i < parts.count; i++ {
            var part = parts[i]
            
            let translatableMatches = RegexHelper.matchRegex(part, regex: translatableExp)
            
            if translatableMatches.count > 0 {
                var capitalIndexes: [Int] = []
                
                let matches = capitalExp.matchesInString(part, options: [], range: NSRange(location: 0, length: part.characters.count))
                for match in matches {
                    capitalIndexes.append(match.range.location)
                }
            
                part = getCurrentTranslator().translate(part)
                part = part.lowercaseString
                
                for index in capitalIndexes {
                    let stringIndex = part.startIndex.advancedBy(index)
                    part.replaceRange(stringIndex...stringIndex, with: String(part[stringIndex]).capitalizedString)
                }
            }
            
            result.append(part)
        }
        
        return result.joinWithSeparator("")
    }

    // MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        translatedTextView.text = translateToPiglatin(textView.text)
    }
}


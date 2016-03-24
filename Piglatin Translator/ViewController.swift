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
        
        /*
        let wordMatches = wordExp.matchesInString(text, options: [], range: NSRange(location: 0, length: text.characters.count))
        var words: [String] = []
        
        for match in wordMatches {
            if match.rangeAtIndex(1).length != 0 {
                words.append(getRegexGroup(text, match: match, index: 1))
            }
        }
        
        var result = ""
        
        for word in words {
            let capitalMatches = capitalExp.matchesInString(word, options: [], range: NSRange(location: 0, length: word.characters.count))
            let partOneMatches = piglatinExp.matchesInString(word, options: [], range: NSRange(location: 0, length: word.characters.count))
            
            var capital = false
            
            if capitalMatches.count > 0 {
                capital = true
            }
            
            let one = getRegexGroup(word, match: partOneMatches[0], index: 1)
            let two = getRegexGroup(word, match: partOneMatches[0], index: 2)
            let three = getRegexGroup(word, match: partOneMatches[0], index: 3)
            
            var piglatinWord = (three + two + one + "ay").lowercaseString
            
            if capital {
                piglatinWord.replaceRange(piglatinWord.startIndex...piglatinWord.startIndex, with: String(piglatinWord[piglatinWord.startIndex]).capitalizedString)
            }
            
            result += " \(piglatinWord)"
        }
        
        return result;
        */
        
        return result.joinWithSeparator("")
    }

    // MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        translatedTextView.text = translateToPiglatin(textView.text)
    }
}


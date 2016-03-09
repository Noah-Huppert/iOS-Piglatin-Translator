//
//  ViewController.swift
//  Piglatin Translator
//
//  Created by block7 on 2/26/16.
//  Copyright © 2016 noahhuppert.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    let partsExp = try! NSRegularExpression(pattern: "(\\w+|[^\\w])", options: .CaseInsensitive)
    let translatableExp = try! NSRegularExpression(pattern: "(\\w+)", options: [])
    /*
    let capitalExp = try! NSRegularExpression(pattern: "[A-Z]", options: [])
    let wordExp = try! NSRegularExpression(pattern: "([^\\s]*) ?", options: [])
    let piglatinExp = try! NSRegularExpression(pattern: "([aieou]*)([^aieou]*)(\\w*)", options: .CaseInsensitive)
    */
    
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
    
    // MARK: Helpers
    func getRegexGroup(text: String, match: NSTextCheckingResult, index: Int) -> String {
        return (text as NSString).substringWithRange(match.rangeAtIndex(index))
    }
    
    func matchRegex(text: String, regex: NSRegularExpression) -> [String] {
        let matches = regex.matchesInString(text, options: [], range: NSRange(location: 0, length: text.characters.count))
        var results: [String] = []
        
        for var i = 0; i < matches.count; i++ {
            results.append(getRegexGroup(text, match: matches[i], index: 1))
        }
        
        return results
    }
    
    // MARK: User functions
    func translateToPiglatin(text: String) -> String {
        let parts = matchRegex(text, regex: partsExp)
        var result: [String] = []
        
        for var i = 0; i < parts.count; i++ {
            var part = parts[i]
            
            let translatableMatches = matchRegex(part, regex: translatableExp)
            
            if translatableMatches.count > 0 {
                // Translate
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
        
        return "\(parts)"
    }

    // MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        translatedTextView.text = translateToPiglatin(textView.text)
    }
}


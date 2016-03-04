//
//  ViewController.swift
//  Piglatin Translator
//
//  Created by block7 on 2/26/16.
//  Copyright © 2016 noahhuppert.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    let wordExp = try! NSRegularExpression(pattern: "([^\\s]*) ?", options: [])
    let piglatinExp = try! NSRegularExpression(pattern: "([aieou]*)([^aieou]*)(\\w*)", options: .CaseInsensitive)
    
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
    
    // MARK: User functions
    func translateToPiglatin(text: String) -> String {
        let wordMatches = wordExp.matchesInString(text, options: [], range: NSRange(location: 0, length: text.characters.count))
        var words: [String] = []
        
        for match in wordMatches {
            if match.rangeAtIndex(1).length != 0 {
                words.append(getRegexGroup(text, match: match, index: 1))
            }
        }
        
        for word in words {
            let partOneMatches = piglatinExp.matchesInString(word, options: [], range: NSRange(location: 0, length: word.characters.count))
            
            let one = getRegexGroup(word, match: partOneMatches[0], index: 1)
            let two = getRegexGroup(word, match: partOneMatches[0], index: 2)
            let three = getRegexGroup(word, match: partOneMatches[0], index: 3)
            
            print("\(three) + \(two) + \(one)ay")
        }
        
        return text;// TODO
    }

    // MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        translatedTextView.text = translateToPiglatin(textView.text)
    }
}


//
//  RegexHelper.swift
//  Piglatin Translator
//
//  Created by block7 on 3/24/16.
//  Copyright © 2016 noahhuppert.com. All rights reserved.
//

import Foundation

class RegexHelper {
    // MARK: Regex Helpers
    class func getRegexGroup(text: String, match: NSTextCheckingResult, index: Int) -> String {
        return (text as NSString).substringWithRange(match.rangeAtIndex(index))
    }
    
    class func matchRegex(text: String, regex: NSRegularExpression) -> [String] {
        let matches = regex.matchesInString(text, options: [], range: NSRange(location: 0, length: text.characters.count))
        var results: [String] = []
        
        for var i = 0; i < matches.count; i++ {
            results.append(getRegexGroup(text, match: matches[i], index: 1))
        }
        
        return results
    }

}
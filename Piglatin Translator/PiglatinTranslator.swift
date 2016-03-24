//
//  PiglatinTranslator.swift
//  Piglatin Translator
//
//  Created by block7 on 3/10/16.
//  Copyright © 2016 noahhuppert.com. All rights reserved.
//
import Foundation

class PiglatinTranslator: Translator {
    let piglatinExp = try! NSRegularExpression(pattern: "([aieou]*)([^aieou]*)(\\w*)", options: [])
    
    func translate(text: String) -> String {
        let match = piglatinExp.matchesInString(text, options: [], range: NSRange(location: 0, length: text.characters.count))[0]
        
        let one = RegexHelper.getRegexGroup(text, match: match, index: 1)
        let two = RegexHelper.getRegexGroup(text, match: match, index: 2)
        let three = RegexHelper.getRegexGroup(text, match: match, index: 3)
        
        return three + two + one + "ay";
    }
}

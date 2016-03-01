//
//  ViewController.swift
//  Piglatin Translator
//
//  Created by block7 on 2/26/16.
//  Copyright © 2016 noahhuppert.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
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
    
    // MARK: User functions
    func translateToPiglatin(text: String) -> String {
        return text;// TODO
    }

    // MARK: UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        translatedTextView.text = translateToPiglatin(textView.text)
    }
}


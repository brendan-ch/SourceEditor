//
//  ViewController.swift
//  SourceEditor
//
//  Created by Brendan Chen on 2024.02.08.
//

import Cocoa

let monoFont = NSFont(name: "SF Mono", size: 12)

class ViewController: NSViewController {
    @IBOutlet var textView: NSTextView!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Stylize the text view
        textView.font = monoFont
        textView.enabledTextCheckingTypes = 0
        textView.delegate = self
        
        // Open and initialize the document from the window controller
        if let document = self.view.window?.windowController?.document as? TextDocument {
            if document.didReadData {
                guard let content = representedObject as? DocumentContents else { return }
                textView.string = content.content
                
                document.didReadData = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController: NSTextViewDelegate {
    func textViewDidChangeSelection(_ notification: Notification) {
        // Save the represented object using data from the text view
        // May need to change the string contents into a class property
        (representedObject as? DocumentContents)?.content = textView.string
    }
}

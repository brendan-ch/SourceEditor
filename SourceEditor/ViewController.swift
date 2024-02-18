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
        
        // Set the delegate of the text view to the class
        textView.delegate = self
        
        // Open and initialize the document
        // The windowController.document property is set when the NSDocument instance calls addWindowController
        // (see TextDocument.swift line 43)
        if let document = self.view.window?.windowController?.document as? TextDocument {
            // Check whether data has been read in correctly
            if document.didReadData {
                // Check that the content's been initialized
                guard let content = representedObject as? DocumentContents else { return }
                
                // Initialize the textView's string contents
                textView.string = content.content
                
                // Reset the state of the document
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
    // Separate text delegate logic into an extension of ViewController
    
    func textViewDidChangeSelection(_ notification: Notification) {
        // Save the represented object using data from the text view
        // May need to change the string contents into a class property
        (representedObject as? DocumentContents)?.content = textView.string
    }
}

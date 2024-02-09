//
//  ViewController.swift
//  SourceEditor
//
//  Created by Brendan Chen on 2024.02.08.
//

import Cocoa

let monoFont = NSFont(name: "SF Mono", size: 12)

class ViewController: NSViewController, NSTextViewDelegate {
    @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.font = monoFont
        textView.enabledTextCheckingTypes = 0

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDocumentOpen(notification:)), name: .didOpenDocument, object: nil)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func handleDocumentOpen(notification: Notification) {
        if let path = notification.userInfo?["path"] as? URL {
            // Load the document from the path
            if let contents = try? String(contentsOf: path) {
                print(contents)
                textView.string = contents
            }
        }
    }


}


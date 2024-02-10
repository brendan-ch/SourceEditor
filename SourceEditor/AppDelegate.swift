//
//  AppDelegate.swift
//  SourceEditor
//
//  Created by Brendan Chen on 2024.02.08.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func openDocument(_ sender: Any) {
        let documentController = NSDocumentController.shared
        
        documentController.beginOpenPanel { urls in
            guard let urls = urls else { return }
            
            for url in urls {
                // Attempt to open the document
                documentController.openDocument(withContentsOf: url, display: true) { document, alreadyOpen, error in
                    if let error = error {
                        NSApp.presentError(error)
                    }
                }
            }
        }
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        // Grab the text contents from the currently active view controller
        if let vc = NSApplication.shared.mainWindow?.contentViewController as? ViewController {
            print(vc.textView.string)
        }
    }
}

extension NSNotification.Name {
    static let didOpenDocument = Notification.Name("didOpenDocument")
}


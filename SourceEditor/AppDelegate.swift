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
        // Attempt to save the document
        let documentController = NSDocumentController.shared
        
        if let currentDocument = documentController.currentDocument as? TextDocument {
            // Attempt to save the current document
            currentDocument.save(to: currentDocument.fileURL!, ofType: currentDocument.fileType!, for: .saveOperation) { error in
                if let error = error {
                    NSApp.presentError(error)
                }
            }
        }
    }
}

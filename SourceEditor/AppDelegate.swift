//
//  AppDelegate.swift
//  SourceEditor
//
//  Created by Brendan Chen on 2024.02.08.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    // MARK: - Lifecycle methods
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return false
    }

    // MARK: - IBAction functions
    
    /// Open a new document using the document controller.
    /// @param sender The sender of the IBAction.
    @IBAction func openDocument(_ sender: Any) {
        // Get the shared document controller
        let documentController = NSDocumentController.shared
        
        // Open the macOS file picker
        // Allow for selection of multiple files
        documentController.beginOpenPanel { urls in
            // Grab the URLs returned from the file picker
            guard let urls = urls else { return }
            
            // Open each document selected
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
    
    /// Save the document to the document's original file path.
    /// @param sender The sender of the IBAction.
    @IBAction func saveDocument(_ sender: Any) {
        print(type(of: sender))
        // Attempt to save the document using the shared document controller.
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

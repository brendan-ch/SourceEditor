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
        // Let the user open a new text document
        let openPanel = NSOpenPanel()
        
        // Set options
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = true
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.plainText]
        
        // Handle opening of the panel
        openPanel.begin { result in
            if result == NSApplication.ModalResponse.OK {
                if let selectedPath = openPanel.url {
                    print(selectedPath)
                }
            }
        }
    }
}


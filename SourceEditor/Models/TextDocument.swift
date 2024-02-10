//
//  TextDocument.swift
//  SourceEditor
//
//  Created by Brendan Chen on 2024.02.09.
//

import Cocoa

class TextDocument: NSDocument {
    // Data model
    // In this case, it's just plaintext
    var content: String = ""
    
    override class var readableTypes: [String] {
        return ["public.plain-text"]
    }
    
    override class var writableTypes: [String] {
        return ["public.plain-text"]
    }
    
    override func makeWindowControllers() {
        // Create a window controller containing the document
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        
        // Create a new window controller from the storyboard
        if let wc = storyboard.instantiateController(withIdentifier: "DocumentWindowController") as? NSWindowController {
            self.addWindowController(wc)
            
            // Initialize document content within window's view controller?
        }
    }
    
    override func data(ofType typename: String) throws -> Data {
        // Serialize document content to Data object
        if let data = content.data(using: .utf8) {
            return data
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
    
    override func read(from data: Data, ofType typename: String) throws {
        // Deserialize document content from data
        if let contentString = String(data: data, encoding: .utf8) {
            self.content = contentString
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
    
    override func read(from url: URL, ofType typeName: String) throws {
        // Implement reading of plain text files
        do {
            self.content = try String(contentsOf: url, encoding: .utf8)
        } catch {
            throw error
        }
    }

    override func write(to url: URL, ofType typeName: String) throws {
        // Implement writing of plain text files
        do {
            try self.content.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            throw error
        }
    }

}

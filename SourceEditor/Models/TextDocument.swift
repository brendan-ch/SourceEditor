//
//  TextDocument.swift
//  SourceEditor
//
//  Created by Brendan Chen on 2024.02.09.
//

import Cocoa

/// Wrapper class for the text contents of the document.
class DocumentContents: Codable {
    /// The text contents of the document.
    var content: String = ""
}

class TextDocument: NSDocument {
    /// DocumentContents instance which tracks text contents for the document.
    var contents = DocumentContents()
    
    /// Indicates whether data has been initialized successfully, whether from
    /// a `Data` object or a URL.
    var didReadData = false
    
    /// Readable types for the document.
    override class var readableTypes: [String] {
        return ["public.plain-text"]
    }
    
    /// Writable types for the document.
    override class var writableTypes: [String] {
        return ["public.plain-text"]
    }
    
    /// Create the window controller object that displays the document,
    /// and initializes the `representedObject` property of the view controller.
    /// It is up to the view controller how to use the `representedObject` property.
    override func makeWindowControllers() {
        // Create a window controller containing the document
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        
        // Create a new window controller from the storyboard
        if let wc = storyboard.instantiateController(withIdentifier: "DocumentWindowController") as? NSWindowController {
            self.addWindowController(wc)
            
            // Initialize document content within window's view controller?
            if let vc = wc.contentViewController as? ViewController {
                vc.representedObject = contents
            }
        }
    }
    
    /// Attempt to serialize the content into a Data object, using the UTF-8 encoding.
    /// @param ofType The string identifying the document type.
    override func data(ofType typename: String) throws -> Data {
        // Serialize document content to Data object
        if let data = contents.content.data(using: .utf8) {
            return data
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
    
    /// Deserialize and read content from a Data object.
    /// @param from The Data object to deserialize.
    /// @param ofType The string identifying the document type.
    override func read(from data: Data, ofType typename: String) throws {
        // Deserialize document content from data
        if let contentString = String(data: data, encoding: .utf8) {
            contents.content = contentString
            didReadData = true
        } else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
    }
    
    /// Read content from a URL.
    /// @param from The URL to read from.
    /// @param ofType The string identifying the document type.
    override func read(from url: URL, ofType typeName: String) throws {
        // Implement reading of plain text files
        do {
            contents.content = try String(contentsOf: url, encoding: .utf8)
            didReadData = true
        } catch {
            throw error
        }
    }
    
    
}

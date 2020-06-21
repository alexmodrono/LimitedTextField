//
//  LimitedTextBindingManager.swift
//  
//
//  Created by Alejandro Modroño Vara on 20/06/2020.
//

import Foundation
import SwiftUI

public enum LimitedTextFieldCounterType { case byWord(Int); case byCharacter(Int) }

/// An ObservableObject that keeps track of the lenght of the content inside the TextField.
///
/// - Parameters:
///     - text: the contents of the TextField.
///     - limit: the maximum lenght.
///
/// - Since: v1.0
///
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public class LimitedTextBindingManager: ObservableObject {
    
    // MARK: - STORED PROPERTIES
    
    public let countType: LimitedTextFieldCounterType
    
    public var characterLimit: Int?
    public var wordLimit: Int?

    // MARK: - INITIALIZERS

    /// - Parameters:
    ///     - limit: The maximum amount of characters allowed.
    ///
    public init(limit: Int = 5) {
        
        countType = .byCharacter(5)
        characterLimit = limit
        wordLimit = nil
        
    }

    /// - Parameters:
    ///     - limit: A LimitedtextFieldCounterType with the maximum amount of characters or words allowed.
    public init(limit: LimitedTextFieldCounterType) {
        
        countType = limit
        wordLimit = nil
        characterLimit = nil
        
        if case .byWord(let maxLenght) = limit {
            
            wordLimit = maxLenght
            
        } else if case .byCharacter(let maxLenght) = limit {
            
            characterLimit = maxLenght
            
        }
        
    }
    
    /// Used to notify when the character limit is reached.
    @Published public var characterLimitReached: Bool = false
    
    /// The actual content of the textfield.
    @Published public var text = "" {
        didSet {
            
            if let characterLimit = characterLimit {
                
                if text.count > characterLimit && oldValue.count <= characterLimit {
                    
                    text = oldValue
                    
                    self.characterLimitReached = true
                    
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                    
                } else {
                
                    self.characterLimitReached = false
                
                }
                
            } else if let wordLimit = wordLimit {
                
                let wordCount = text.split { !$0.isLetter && !$0.isNumber && !$0.isSymbol && !$0.isMathSymbol && !$0.isPunctuation  }.count
                
                if wordCount > wordLimit && oldValue.split(whereSeparator: { !$0.isLetter && !$0.isNumber && !$0.isSymbol && !$0.isMathSymbol && !$0.isPunctuation}).count <= wordLimit {
                    
                    text = oldValue
                    
                    self.characterLimitReached = true
                    
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                    
                } else {
                
                    self.characterLimitReached = false
                
                }
                
            }
            
        }
    }
    
}

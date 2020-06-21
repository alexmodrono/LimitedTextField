//
//  LimitedTextField.swift
//
//
//  Created by Alejandro Modroño Vara on 20/06/2020.
//

import Foundation
import SwiftUI

/// A TextField with a maximum length and a simple label that shows how many characters or words are left.
///
/// You may want to have a specific length allowed in the TextField.
/// You can easily do this by using `.counter()`.
///
/// ```
/// LimitedTextField()
///     .counter(30)
/// ```
///
/// # Word limit #
/// There might be ocassions where you may want to have a limit for the amount of words,
/// and not be conditioned by the amount of characters. You can achieve this easily by using
/// `.byWord()`.
///
/// ```
/// LimitedTextField()
///     .counter(.byWord(5))
/// ```
///
/// # Styling #
/// LimitedTextField is just a simple TextField without styling, so you can easily add whatever styling
/// you want.
///
/// ```
/// LimitedTextField()
///     .padding()
///     .background(
///         Color(.systemGray5)
///             .cornerRadius(5.0)
///     )
///
/// ```
///
/// - Returns: A LimitedTextField with a maximum length specified by the user.
///
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct LimitedTextField: View {
    
    // MARK: - STORED PROPERTIES
    
    public let placeholder: String?
    @ObservedObject public var content: LimitedTextBindingManager
    
    // MARK: - INITIALIZERS
    ///
    /// - Parameters:
    ///     - placeholder: The placeholder of the TextField.
    ///     - content: A LimitedTextBindingManager that tells the TextField the limit amount of characters or words.
    ///
    public init(
        placeholder: String? = nil,
        _ content: LimitedTextBindingManager = LimitedTextBindingManager(limit: 20)
    ) {
        self.placeholder = placeholder
        self.content = content
    }
    
    /// Declares the content and behavior of this view.
    public var body: some View {
        
        HStack {
            
            TextField(getPlaceholder(), text: self.$content.text)
            
            Divider()
                .frame(height: 20)
            
            Text("\(self.content.characterLimit != nil ? self.content.characterLimit! - self.content.text.count : self.content.wordLimit! - self.content.text.split { !$0.isLetter && !$0.isNumber && !$0.isSymbol && !$0.isMathSymbol && !$0.isPunctuation}.count)")
                .font(.headline)
                .foregroundColor(self.getColor())
                
        }
        
    }
    
    // MARK: - HELPER FUNCTIONS
    
    /// If no placeholder is given, the placeholder will be "X words/characters maximum".
    private func getPlaceholder() -> String {
        
        if let placeholder = placeholder {
            
            return placeholder
            
        }
        
        return "\(self.content.characterLimit ?? self.content.wordLimit!) \(self.content.characterLimit != nil ? "characters" : "words") maximum"
        
    }
    
    /// Returns a color based on how many characters (or words) are left.
    private func getColor() -> Color {
        
        if let characterLimit = self.content.characterLimit {
            
            if self.content.text.count >= characterLimit / 2 && self.content.text.count != characterLimit {

                return .yellow

            } else if self.content.text.count == characterLimit {

                return .red

            } else {

                return Color(.label)

            }
        
        } else if let wordLimit = self.content.wordLimit {
            
            if self.content.text.split(whereSeparator: { !$0.isLetter && !$0.isNumber && !$0.isSymbol && !$0.isMathSymbol && !$0.isPunctuation  }).count >= wordLimit / 2 && self.content.text.split(whereSeparator: { !$0.isLetter && !$0.isNumber && !$0.isSymbol && !$0.isMathSymbol && !$0.isPunctuation  }).count != wordLimit {

                return .yellow

            } else if self.content.text.split(whereSeparator: { !$0.isLetter && !$0.isNumber && !$0.isSymbol && !$0.isMathSymbol && !$0.isPunctuation  }).count == wordLimit {

                return .red

            } else {

                return Color(.label)

            }
            
        }
        
        return Color(.label)
        
    }
    
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension LimitedTextField {
    
    /// Changes the maximum characters allowed in the TextField.
    ///
    /// - Parameters:
    ///     - limit: An Int specifying the maximum amount of characters you want the TextField to have.
    ///
    /// - Returns: A LimitedTextField with a maximum length specified by the user.
    ///
    public func counter(_ limit: Int) -> LimitedTextField {
        
        return LimitedTextField(LimitedTextBindingManager(limit: limit))
        
    }
    
    /// Changes the maximum characters allowed in the TextField.
    ///
    /// - Parameters:
    ///     - limit: An LimitedTextFieldCounterType specifying the maximum amount of characters *or words* you want the TextField to have.
    ///
    /// - Returns: A LimitedTextField with a maximum length specified by the user.
    ///
    public func counter(_ limit: LimitedTextFieldCounterType) -> LimitedTextField {
        
        return LimitedTextField(LimitedTextBindingManager(limit: limit))
        
    }
    
}

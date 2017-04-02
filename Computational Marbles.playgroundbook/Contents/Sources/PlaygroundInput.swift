import Foundation
import PlaygroundSupport

#if !(arch(i386) || arch(x86_64))
extension PlaygroundPage {
    public func userInputs() -> [String] {
        var inputs: [String] = []
        let scanner = Scanner(string: PlaygroundPage.current.text)
        
        while scanner.scanUpTo("//#-editable-code", into: nil) {
            var userInput: NSString? = ""
            scanner.scanUpTo("\n", into: nil)
            scanner.scanUpTo("//#-end-editable-code", into: &userInput)
            
            if userInput != nil {
                inputs.append(String(userInput!).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
            }
        }
        
        return inputs
    }
}
#endif

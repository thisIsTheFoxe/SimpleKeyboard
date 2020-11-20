import SwiftUI

public struct SimpleKeyboard: View {
    var keys: [[String]]
    @Binding var text: String
    var action : (()->())?
    
    public init(keys: [[String]], textInput: Binding<String>, action: (()->())? = nil) {
        self.keys = keys
        self._text = textInput
        self.action = action
    }
    
    public var body: some View {
        VStack{
            ForEach(keys, id: \.self) { row in
                HStack{
                    ForEach(row, id: \.self) { key in
                        KeyButton(text: self.$text, letter: key)
                    }
                }
            }
            HStack{
                ActionKeyButton(icon: .done) {
                    self.action?()
                }
            }
        }.padding(.vertical, 5).background(Color.gray.opacity(0.2))
    }
}

import SwiftUI

@available(iOS 13.0, *)
public struct SimpleKeyboard: View {
    var keys: [[String]]
    @Binding var text: String
    var action : ()->()
    
    public init(keys: [[String]], text: Binding<String>, action: @escaping ()->()){
        self.key = keys
        self._text = text
        self.action = action
    }
    
    public var body: some View {
        VStack{
            ForEach(keys, id: \.self){ row in
                HStack{
                    ForEach(row, id: \.self){ key in
                        KeyButton(text: self.$text, letter: key)
                    }
                }
            }
            HStack{
                ActionKeyButton(icon: .done) {
                    action
                }
            }
        }.padding(.vertical, 5).background(Color.gray.opacity(0.2))
    }
}

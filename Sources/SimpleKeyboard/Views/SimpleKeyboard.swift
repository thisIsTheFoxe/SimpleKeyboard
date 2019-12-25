import SwiftUI

@available(iOS 13.0, *)
public struct SimpleKeyboard: View {
    var keys: [[String]]
    @Binding var text: String
    @Binding var isShown : Bool
    
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
                    self.isShown.toggle()
                }
            }
        }.padding(.vertical, 5).background(Color.gray.opacity(0.2))
    }
}

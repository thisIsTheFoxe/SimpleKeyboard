//
//  File.swift
//  
//
//  Created by Henrik Storch on 12/24/19.
//

import SwiftUI

@available(iOS 13.0, *)
struct KeyButton: View {
    @Binding var text: String
    var letter: String
//    @Binding var input...
    
    var body: some View{
        Button(action: {
            self.text.append(self.letter)
        }) {
            Text(letter).font(.system(size: 20))//.padding()
        }
    }
}

@available(iOS 13.0, *)
struct SpaceKeyButton: View {
    @Binding var text: String
//    @Binding var input...
    
    var body: some View{
        Button(action: {
            self.text.append(" ")
        }) {
            Text("space")
        }
    }
}

@available(iOS 13.0, *)
struct DeleteKeyButton: View {
    @Binding var text: String
//    @Binding var input...
    
    var body: some View{
        Button(action: {
            _ = self.text.removeLast()
        }) {
            Image(systemName: "delete.left")
        }
    }
}

@available(iOS 13.0, *)
struct ActionKeyButton: View {
    @State var icon: Icon
    var action: ()->()
//    @Binding var input...
    
    var body: some View{
        Button(action: {
            self.action()
        }) {
            icon.view
        }
    }
}

@available(iOS 13.0, *)
enum Icon {
    case done, search, go
    
    var view: some View{
        switch self{
        case .done: return AnyView(Text("Done!"))
        case .search: return AnyView(Image(systemName: "magnifyingglass"))
        case .go: return AnyView(Text("Go!"))
        }
    }
    
}

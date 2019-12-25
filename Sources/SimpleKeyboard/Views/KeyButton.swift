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
            Text(letter).foregroundColor(.primary).font(.system(size: 25)).padding(5).frame(minWidth: 27)
                .background(Color.gray.opacity(0.5)).cornerRadius(5)
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
            Text("space").padding().padding(.horizontal, 50)
                .foregroundColor(.primary)
                .background(Color.gray.opacity(0.5)).cornerRadius(7)
        }
    }
}

@available(iOS 13.0, *)
struct DeleteKeyButton: View {
    @Binding var text: String
//    @Binding var input...
    
    var body: some View{
        Button(action: {
            guard !self.text.isEmpty else { return }
            _ = self.text.removeLast()
        }) {
            Image(systemName: "delete.left")
                .foregroundColor(.primary)
                .imageScale(.large)
                .font(Font.headline.weight(.semibold))
                .padding()
                .background(Color.gray.opacity(0.5)).cornerRadius(7)
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
            icon.view.padding()
                .foregroundColor(.white)
            .background(Color.blue).cornerRadius(7)
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

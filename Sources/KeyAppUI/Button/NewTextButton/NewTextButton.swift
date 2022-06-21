//
//  SwiftUIView.swift
//
//
//  Created by Giang Long Tran on 17.06.2022.
//

import SwiftUI

public struct NewTextButton: View {
    let leading: Image?
    let title: String
    let trailing: Image?

    public init(title: String, leading: Image? = nil, trailing: Image? = nil) {
        self.leading = leading
        self.title = title
        self.trailing = trailing
    }

    var leadingView: some View {
        guard leading == leading else {
            return AnyView(Spacer(minLength: 8))
        }
        return AnyView(leading)
    }

    var trailingView: some View {
        guard trailing == trailing else {
            return AnyView(Spacer(minLength: 8))
        }
        return AnyView(trailing)
    }

    public var body: some View {
        Button {
            print("Click")
        } label: {
            HStack {
                leadingView
                Text(title)
                trailingView
            }
        }
    }
}

public struct TextButtonStyle: PrimitiveButtonStyle {
    enum Style {
        case primary
        case secondary
    }
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.label
                .padding(.horizontal, 20)
        }.frame(maxWidth: .infinity)
            .frame(height: 56)
            .foregroundColor(Color(Asset.Colors.lime.color))
            .background(Color(Asset.Colors.night.color))
            .cornerRadius(12)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            NewTextButton(title: "Hello", trailing: Image(uiImage: Asset.MaterialIcon.arrowForward.image))
                .frame(maxWidth: .infinity)
                .buttonStyle(TextButtonStyle())
            NewTextButton(title: "Hello", leading: Image(uiImage: Asset.MaterialIcon.arrowBack.image))
                .frame(maxWidth: .infinity)
                .buttonStyle(TextButtonStyle())
            NewTextButton(title: "Hello")
                .buttonStyle(TextButtonStyle())
            HStack {
                Text("Abc")
                Spacer()
                NewTextButton(title: "Hello")
                    .fixedSize()
                    .buttonStyle(TextButtonStyle())
            }
        }.padding(.all, 8)
    }
}

public extension View {
    var asUIView: UIView {
        let vc = UIHostingController(rootView: self)
        vc.view.backgroundColor = .clear
        vc._disableSafeArea = true
        return vc.view
    }
}

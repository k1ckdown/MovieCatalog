//
//  Test.swift
//  Movies
//
//  Created by Ivan Semenov on 31.10.2023.
//

import SwiftUI

struct Test: View {
    @State private var isExpanded: Bool = false

    var body: some View{

        VStack{

            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                .lineLimit(isExpanded ? nil : 3)
                .overlay(
                    GeometryReader { proxy in
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Text(isExpanded ? "Less" : "More")
                                .font(.caption).bold()
                                .padding(.leading, 8.0)
                                .padding(.top, 4.0)
                                .background(Color.white)
                        }
                        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottomTrailing)
                    }
                )

            Spacer()
        }
        .padding()
    }
}

#Preview {
    Test()
}

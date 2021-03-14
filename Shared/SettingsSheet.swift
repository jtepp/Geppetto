//
//  SettingsSheet.swift
//  Geppetto
//
//  Created by Jacob Tepperman on 2021-03-14.
//

import SwiftUI

struct SettingsSheet: View {
    @State var key = UserDefaults.standard.string(forKey: "key") ?? ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Settings")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .bold()
                Spacer()
            }
            .padding(.bottom, 60)
            Text("API key:")
                .font(.title2)
                .bold()
            TextField("Paste API key here...", text: $key)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: key, perform: { _ in
                    UserDefaults.standard.setValue(key, forKey: "key")
                })
            Spacer()
        }
        .padding()
    }
}

struct SettingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        SettingsSheet()
//            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

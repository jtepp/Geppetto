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
            Text("API key:")
                .bold()
            TextField("Paste API key here...", text: $key)
                .onChange(of: key, perform: { _ in
                    UserDefaults.standard.setValue(key, forKey: "key")
                })
        }
    }
}


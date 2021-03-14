//
//  ContentView.swift
//  Shared
//
//  Created by Jacob Tepperman on 2021-03-14.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    @State var showSettings = false
    @State var text = ""
    var body: some View {
        VStack {
            HStack {
                Text("Geppetto")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .bold()
                Spacer()
            }
            .padding()
            .padding(.bottom, 100)
            
            TextEditor(text: $text)
                
                .frame(maxWidth: UIScreen.main.bounds.width-80,
                       minHeight: 100,
                       idealHeight: 200,
                       maxHeight: UIScreen.main.bounds.height-500, alignment: .topLeading)
                .padding()
                .background(
                    Color("silver")
                )
                .cornerRadius(25)
                .overlay(
                    VStack {
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {openapi(prompt: $text)}, label: {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(
                                                Color.black
                                            )
                                    )
                            })
                            .shadow(radius: 10)
                        }
                    }
                    .padding()
                )
                .overlay(
            VStack {
                HStack{
                    if text.isEmpty {
                    Text("Type to GPT-3")
                        .foregroundColor(.secondary)
                        .offset(y:-60)
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            )
            Spacer()
            Button(action: {
            showSettings = true
            }, label: {
            Text("Setttings")
            .foregroundColor(.white)
            .bold()
            })
            .frame(width: UIScreen.main.bounds.width-80)
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 25)
            .fill(
            Color("settingsbutton")
            )
            )
        }
        .sheet(isPresented: $showSettings){
            SettingsSheet()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .preferredColorScheme(.dark)
    }
}

func openapi(prompt: Binding<String>){
    let session = URLSession(configuration: .default)
    let url = URL(string: "https://api.openai.com/v1/engines/davinci/completions")
    var request = URLRequest(url: url!)
    do {
        let json : [String:Any] = [
            "prompt":prompt.wrappedValue,
            "temperature":0,
            "top_p":1,
            "frequency_penalty":0.0,
            "presence_penalty":0.0,
            "stop":["###"]
        ]
    let data = try JSONSerialization.data(withJSONObject: json, options: [])
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("Bearer \(UserDefaults.standard.string(forKey: "key") ?? "")", forHTTPHeaderField: "Authorization")
    request.httpBody = data
    let task = session.dataTask(with: request) { data, response, error in
        // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
                // Convert HTTP Response Data to a String
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    
                    print("Response data string:\n \(dataString)")
                    
                    if dataString.contains("You didn't provide an API key") {
                        
                    }
                }
    }
    task.resume() // <- otherwise your network request won't be started
    } catch {
        print("ERROR")
    }
}

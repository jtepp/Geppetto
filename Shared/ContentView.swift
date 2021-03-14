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
                            Button(action: openapi, label: {
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
                    Text(text.isEmpty ? "Type to GPT-3:" : "")
                        .foregroundColor(.secondary)
                        .offset(y:-60)
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

func openapi(){
    print(true)
}

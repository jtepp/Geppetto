//
//  APIcall.swift
//  Geppetto
//
//  Created by Jacob Tepperman on 2021-03-14.
//

import SwiftUI

func APIcall(prompt: Binding<String>, showAlert: Binding<Bool>, title: Binding<String>, msg: Binding<String>, loading: Binding<Bool>){
    let session = URLSession(configuration: .default)
    let url = URL(string: "https://api.openai.com/v1/engines/davinci/completions")
    var request = URLRequest(url: url!)
    loading.wrappedValue = true
    do {
        let json : [String:Any] = [
            "prompt":prompt.wrappedValue,
            "temperature": UserDefaults.standard.float(forKey: "temperature"),
            "max_tokens": Int(UserDefaults.standard.float(forKey: "max_tokens")),
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
                else if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    
                    if dataString.contains("You didn't provide an API key") {
                        title.wrappedValue = "API key missing"
                        msg.wrappedValue = "Make sure you paste your API key into the settings page before you start"
                        showAlert.wrappedValue = true
                    } else if dataString.contains("Incorrect API key") {
                        title.wrappedValue = "Incorrect API key"
                        msg.wrappedValue = "Make sure your API key is correct on the settings page"
                        showAlert.wrappedValue = true
                    } else {
                    
                    let json = jsondata(string: dataString)
                    let choices = json["choices"]! as! [[String:Any]]
                    let response = choices.last!["text"]! as! String
                        withAnimation {
                            prompt.wrappedValue += response
                            loading.wrappedValue = false
                        }
                    }
                }
    }
    task.resume() // <- otherwise your network request won't be started
    } catch {
        print("ERROR")
    }
    
}


func jsondata(string: String) -> [String:Any] {
    do {
    if let json = string.data(using: String.Encoding.utf8){
            if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:Any]{
                return jsonData
            }
    }
    }
    catch{}
    return [:]
}

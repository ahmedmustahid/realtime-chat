//
//  ContentView.swift
//  realtime-chat
//
//  Created by Ahmed on 2021/08/17.
//

import SwiftUI

struct MessageView: View {
    
    @State var text = String()
    @ObservedObject var sot = SourceOfTruth()
    
    init(){
        sot.getMessages()
        sot.observeMessages()
    }
    
    let currentUser = "mustahid"
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack{
                    ForEach(sot.messages){ message in
                        MessageRow(message: message, isCurrentUser: message.senderName==currentUser)
                    }
                    
                }
            }
            HStack {
                TextField("Enter message", text: $text)
                Button("Send",action: didTapSend)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
            }
        }
        .padding(.horizontal, 16)
    }
    
    func didTapSend() {
        print(text)
        let message = Message(senderName: currentUser, body: text, creationDate: Int(Date().timeIntervalSince1970) )
        
        sot.send(message)
        text.removeAll()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}

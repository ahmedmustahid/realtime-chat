//
//  realtime_chatApp.swift
//  realtime-chat
//
//  Created by Ahmed on 2021/08/17.
//

import SwiftUI
import Amplify
import AmplifyPlugins

@main
struct realtime_chatApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            MessageView()
        }
    }
    private func configureAmplify() {
        do {
            let models = AmplifyModels()
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: models))
                
            try Amplify.configure()
                
            print("Configured amplify")
        } catch {
            print("Couldnt configure amplify", error)
        }
    }
   

    
}

//
//  SourceOfTruth.swift
//  realtime-chat
//
//  Created by Ahmed on 2021/08/17.
//

import Foundation
import Amplify

class SourceOfTruth: ObservableObject {
    @Published var messages = [Message]()
    
    func send(_ message: Message){
        Amplify.API.mutate(request: .create(message)) {
            mutationResult in switch mutationResult {
            case .success(let creationResult):
                switch creationResult {
                    case .success:
                        print("successfully created message")
                    case .failure(let error):
                        print(error)
                }
            
            case .failure(let apiError):
                print(apiError)
            }
        }
        
    }
    
    func getMessages(){
        Amplify.API.query(request: .list(Message.self)) {
            [weak self] result in do {
                let messages = try result.get().get()
                
                //messages.forEach{message in self?.delete(message)}
                
                DispatchQueue.main.async {
                    self?.messages = messages.sorted(by: {$0.creationDate < $1.creationDate})
                }
            } catch {
                print(error)
            }
        }
    }
    
    func delete(_ message: Message){
        Amplify.API.mutate(request: .delete(message)) {
            result in print(result)
        }
    }
    
    var subscription: GraphQLSubscriptionOperation<Message>?
    func observeMessages() {
        subscription = Amplify.API.subscribe(
            request: .subscription(of: Message.self, type: .onCreate),
            valueListener: { [weak self] subscriptionEvent in
            switch subscriptionEvent {
            case .connection(let connectionState):
                print("connection state \(connectionState)")
            case .data(let dataResult):
                do{
                    let message = try dataResult.get()
                    
                    DispatchQueue.main.async {
                        self?.messages.append(message)
                    }
                } catch { print(error)}
            }
        },
            completionListener: { completion in print(completion)}
        )
    }
}

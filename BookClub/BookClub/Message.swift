//
//  Message.swift
//  LetterMeApp
//
//  Created by Alex Paul on 12/8/15.
//  Copyright © 2015 SWARM NYC. All rights reserved.
//

import Foundation
import LayerKit


class Message {
    
    var friends = [Friend]()
    var layerConversation: LYRConversation?
    var participantIDs: Set<NSObject>!
    var participants = [Friend]()
    var queryController: LYRQueryController?
    //getMessages
    
    func setupQueryController(layerClient: LYRClient) {
        Background.runInBackground({
        // For more information about the Query Controller, check out https://developer.layer.com/docs/integration/ios#querying
        
        // Query for all the messages in conversation sorted by position
        let query: LYRQuery = LYRQuery(queryableClass: LYRMessage.self)
        query.predicate = LYRPredicate(property: "conversation", predicateOperator: LYRPredicateOperator.IsEqualTo, value: self.layerConversation)
        
        query.sortDescriptors = [NSSortDescriptor(key: "sentAt", ascending: true)]
        
        // Set up query controller
        do {
            self.queryController = try layerClient.queryControllerWithQuery(query)
        }catch {
            print("Error Setting query controller with error: \(error)")
        }
        //self.queryController = layerClient.queryControllerWithQuery(query)
        
        var error: NSError?
        let success: Bool
        do {
            try self.queryController!.execute()
            success = true
        } catch let error1 as NSError {
            error = error1
            success = false
        }
        if success {
            //print("Query fetched \(queryController!.numberOfObjectsInSection(0)) message objects")
        } else {
            //print("Query failed with error: \(error)")
        }
        
        });
    }
    
    
    
}
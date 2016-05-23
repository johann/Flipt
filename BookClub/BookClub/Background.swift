//
// Created by Alex Hartwell on 12/1/15.
// Copyright (c) 2015 SWARM NYC. All rights reserved.
//

import Foundation


public class Background {
    
    
    static func runInBackground(inBackground: (() -> ())) {
        let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            inBackground();
        }
        
    }
    
    static func runInBackgroundAndCallback(inBackground: (() -> ()), callback: (() -> ())) {
        let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            inBackground();
            dispatch_async(dispatch_get_main_queue()) {
                callback();
            }
            
        }
        
        
    }
    
    
    static func runInBackgroundAsyncAndCallback(inBackground: (( (() -> ()) ) -> ()), callback: (() -> ())) {
        let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            inBackground({
                
                dispatch_async(dispatch_get_main_queue()) {
                    callback();
                }
            });
            
            
        };
        
        
    }
    
    static func runInMainThread(closure: (() -> ())) {
        dispatch_async(dispatch_get_main_queue(), closure);
    }
    
}
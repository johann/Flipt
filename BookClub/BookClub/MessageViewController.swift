//
//  MessageViewController.swift
//  BookClub
//
//  Created by Johann Kerr on 2/18/16.
//  Copyright © 2016 Johann. All rights reserved.
//

import UIKit
import LayerKit

class MessageViewController: UIViewController{
    
//    
//    
//    
//    var messageView: MessageView = MessageView()
//    var layerClient: LYRClient!
//    //var currentUser: User!
//    
//    var queryController: LYRQueryController? = nil
//    var conversationSelectedBeforeContentChange: LYRConversation!
//    
//    var selectedRowIndexPath: NSIndexPath!
//  
//
//    
//    let FONT_SIZE_LAST_MESSAGE: CGFloat = 14
//    
//    // MARK: - View Life Cycle
//    
//    override func loadView() {
//        super.loadView()
//        view = self.messageView
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        
//        super.viewWillAppear(animated)
//        
//        setupNavBar()
//        
//        // Reloads the Cell after a User has changed the Group Profile Photo
//        if selectedRowIndexPath != nil {
//            self.messageView.tableView.reloadRowsAtIndexPaths([selectedRowIndexPath!], withRowAnimation: UITableViewRowAnimation.None)
//        }
//        
//        // Register For Layer Notifications
//        registerForLayerNotifications()
//        
//        if self.layerClient == nil {
//            print("View Did Load - Layer Client is nil")
//            // Setup LayerClient and User
////            let lmTabBarController = self.tabBarController as! LMTabBarController
////            //let lmTabBarController = LMTabBarController()
////            layerClient = lmTabBarController.layerClient
////            
////            currentUser = lmTabBarController.currentUser
//            
//            
//            
//        }
//        
//        if self.queryController == nil {
//            if self.layerClient != nil {
//                self.setupConversations(self.layerClient)
//            }
//        }
//        
//        
//    }
//    
//    func setupNavBar() {
//        self.navigationController?.navigationBarHidden = false
//        self.navigationController!.navigationBar.topItem!.title = "Messages"
//        self.navigationController!.navigationBar.topItem!.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "createNewChat")
//        
//        self.navigationController?.navigationBar.topItem!.rightBarButtonItem?.tintColor = Constants.appColor
//        self.navigationController!.navigationBar.topItem!.leftBarButtonItems = nil
//    }
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        
//        self.messageView.tableView.registerClass(MessageCell.classForCoder(), forCellReuseIdentifier: "MessagesCell")
//        
//        self.messageView.tableView.dataSource = self
//        self.messageView.tableView.delegate = self
//        
//        if self.layerClient != nil {
//            self.setupConversations(self.layerClient)
//        }
//        
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//    
//    func numberOfMessages() -> Int {
//        
//        let message: LYRQuery = LYRQuery(queryableClass: LYRMessage.self)
//        
//        if layerClient == nil {
//            return 0
//        }
//        
//        var messageList: NSOrderedSet? = nil
//        do {
//            messageList = try layerClient?.executeQuery(message)
//        } catch {
//            messageList = nil
//        }
//        return messageList != nil ? messageList!.count : 0
//        
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        // Unregister For Layer Notifications
//        unRegisterForLayerNotifications()
//    }
//    
//    
//    // MARK: - Conversation Methods
//    
//    // Fetch Current User Conversations
//    func setupConversations(layerClient: LYRClient) {
//        
//        let value = layerClient.authenticatedUserID
//        
//        if value == nil {
//            print("Value can't be nil")
//            return
//        }
//        
//        let query = LYRQuery(queryableClass: LYRConversation.classForCoder())
//        
//        query.predicate = LYRPredicate(property: "participants", predicateOperator: LYRPredicateOperator.IsIn, value: value!)
//        query.sortDescriptors = [NSSortDescriptor(key: "lastMessage.receivedAt", ascending: false)];
//        
//        
//        do {
//            self.queryController = try self.layerClient.queryControllerWithQuery(query)
//        }catch {
//            print("LayerKit failed to create a query controller with error: \(error)")
//            return
//        }
//        
//        self.queryController!.delegate = self
//        
//        do {
//            try self.queryController!.execute()
//        }catch {
//            print("LayerKit failed to execute query with error: \(error)")
//        }
//        
//    }
//    
//    
//    func getMessageData(layerConversation: LYRConversation) -> Message {
//        
//        let message = Message()
//        message.layerConversation = layerConversation
//        message.participantIDs = layerConversation.participants
//        message.friends = getParticipantsForConversation(layerConversation)
//        return message;
//        
//    }
//    
//    // Fetch Unread Messages
//    func fetchUnreadMessagesCount(conversation: LYRConversation) -> NSOrderedSet {
//        
//        var unreadMessageCount = NSOrderedSet()
//        
//        // Fetches the count of all unread messages for the Autqhenticated User
//        let query = LYRQuery(queryableClass: LYRMessage.classForCoder())
//        
//        // Message for Coversation
//        let conversationPredicate = LYRPredicate(property: "conversation", predicateOperator: LYRPredicateOperator.IsEqualTo, value: conversation)
//        
//        // Messages must be unread
//        let unreadPredicate = LYRPredicate(property: "isUnread", predicateOperator: LYRPredicateOperator.IsEqualTo, value: true)
//        
//        // Messages must not be sent by the authenticated user
//        let userPredicate = LYRPredicate(property: "sender.userID", predicateOperator: LYRPredicateOperator.IsNotEqualTo, value: self.layerClient.authenticatedUserID)
//        
//        query.predicate = LYRCompoundPredicate(type: LYRCompoundPredicateType.And, subpredicates: [unreadPredicate, userPredicate, conversationPredicate])
//        
//        do {
//            unreadMessageCount = try self.layerClient.executeQuery(query)
//        }catch let error as NSError {
//            print("Error - fetchUnreadMessages :\(error)")
//        }
//        //self.totalUnreadMessages += unreadMessageCount.count
//        return unreadMessageCount
//    }
//    
//    func getParticipantsForConversation(conversation: LYRConversation) -> [Friend] {
//        
//        //print("calling....")
//        
//        //var friends = LMSingleton.sharedInstance().letterMeFriends
//        
//        if friends == nil {
//            return [Friend]()
//        }
//        
//        let participantIDs = conversation.participants // ids of people participating in the conversation
//        var participants = [Friend]()
//        
//        // Append the Current User to the Participant Array
//        // If User is not Appended Participants Array will be -1 which won't display a P2P Conversation
//        let userAsAFriend = User.current!.convertUserToAFriend()
//        friends!.append(userAsAFriend)
//        
//        //var participantAdded = false
//        
//        for id in participantIDs { // for each participant id look up the friend object info - req. for Layer
//            var friendCheck = friends?.indexOf({$0.id == id})
//            // Participant is a Friend
//            if let index = friendCheck {
//                participants.append(friends![index])
//            }
//                // Participant is NOT a Friend
//                // Needs to be added
//            else {
//                fetchNonFriendWithId(id as! String)
//            }
//        }
//        
//        //print("returning \(participants.count)")
//        return participants
//        
//    }
//    
//
//    
//    // Generate Color for the Chat Profile Image
//    
//    // MARK: - UITableView DataSource Methods
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        var count = 0
//        if let _ = self.queryController {
//            count = Int(self.queryController!.numberOfObjectsInSection(UInt(section)))
//            return Int(self.queryController!.numberOfObjectsInSection(UInt(section)))
//        }
//        
//        return 0
//        
//    }
//    
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let messageCell = tableView.dequeueReusableCellWithIdentifier("MessagesCell", forIndexPath: indexPath) as! MessagesCell
//        
//        messageCell.p2pChatImageView.image = nil
//        messageCell.p2pInitialLabel.hidden = false
//        
//        
//        if let conversation = self.queryController!.objectAtIndexPath(indexPath) as? LYRConversation {
//            let participants = self.getParticipantsForConversation(conversation)
//            
//            if conversation.participants.count > 1 { // Need at least 2 participants in a Conversation
//                
//                
//                if muteCheck(conversation) == true{
//                    self.muteImageName = "muteIcon"
//                    messageCell.muteImageView.hidden = false
//                    
//                }else{
//                    self.muteImageName = "unmuteIcon"
//                    messageCell.muteImageView.hidden = true
//                    
//                }
//                
//                // P2P Chat, plus current user
//                if conversation.participants.count == 2 {
//                    messageCell.p2pChatImageView.hidden = false
//                    
//                    if(indexPath.row % 4 == 0){
//                        messageCell.p2pChatImageView.backgroundColor = Constants.COLOR1
//                    }
//                    else if (indexPath.row % 4 == 1){
//                        messageCell.p2pChatImageView.backgroundColor = Constants.COLOR2
//                    }
//                    else if (indexPath.row % 4 == 2){
//                        messageCell.p2pChatImageView.backgroundColor = Constants.COLOR3
//                    }
//                    else if (indexPath.row % 4 == 3){
//                        messageCell.p2pChatImageView.backgroundColor = Constants.COLOR4
//                    }
//                    
//                    messageCell.groupChatBackgroundImageView.hidden = true
//                    messageCell.groupChatForegroundImageView.hidden = true
//                    
//                    // Get Other Participant Name, Not Current User
//                    for participant in participants {
//                        if participant.id! != self.currentUser.userID! {
//                            
//                            var conversationTitle = ""
//                            // Setup Group Conversation Title
//                            if conversation.metadata?[Constants.CONVERSATION_TITLE] != nil {
//                                if let title = conversation.metadata?[Constants.CONVERSATION_TITLE] as? String {
//                                    messageCell.displayNameLabel.text = title
//                                    conversationTitle = title
//                                    print("Conversation Metadata Title: \(conversationTitle)")
//                                }
//                            }else {
//                                // No Coversation Title Metadata - Use Group Name String
//                                
//                                let title = participant.username!.capitalizedStringWithLocale(NSLocale.currentLocale())
//                                
//                                
//                                conversationTitle = conversationTitle + title
//                                messageCell.displayNameLabel.text = conversationTitle
//                                print("No Conversation Metadata: \(conversationTitle)")
//                            }
//                            
//                            let initials = conversationTitle.substringWithRange(Range<String.Index>(start: conversationTitle.startIndex.advancedBy(0), end: conversationTitle.endIndex.advancedBy(-(conversationTitle.characters.count-1))))
//                            messageCell.p2pInitialLabel.text = initials.uppercaseString
//                            
//                            
//                            if let hasImage = participant.image {
//                                if hasImage {
//                                    if let imageURL = participant.imageURL {
//                                        messageCell.p2pInitialLabel.hidden = true
//                                        messageCell.p2pChatImageView.sd_setImageWithURL(NSURL(string: imageURL))
//                                    }
//                                }
//                            }
//                        }
//                        
//                    }
//                }
//                    
//                    // Group Chat
//                else if conversation.participants.count > 2 {
//                    messageCell.p2pChatImageView.hidden = true
//                    messageCell.groupChatBackgroundImageView.hidden = false
//                    messageCell.groupChatBackgroundImageView.backgroundColor = Constants.COLOR1
//                    messageCell.groupChatForegroundImageView.hidden = false
//                    messageCell.groupChatForegroundImageView.backgroundColor = Constants.COLOR4
//                    
//                    if participants.count > 0 {
//                        
//                        // Setup Group Conversation Title
//                        if conversation.metadata?[Constants.CONVERSATION_TITLE] != nil {
//                            if let conversationTitle = conversation.metadata?[Constants.CONVERSATION_TITLE] as? String {
//                                messageCell.displayNameLabel.text = conversationTitle
//                            }
//                        }else {
//                            // No Coversation Title Metadata - Use Group Name String
//                            var usernameLabelString = "\(participants[0].username!)"
//                            for var i = 1; i < participants.count; i++ {
//                                usernameLabelString += ", \(participants[i].username!)"
//                            }
//                            messageCell.displayNameLabel.text = usernameLabelString.capitalizedStringWithLocale(NSLocale.currentLocale())
//                        }
//                        
//                        // Setup Group Conversation Image
//                        if conversation.metadata?[Constants.CONVERSATION_IMAGE_URL] != nil {
//                            if let layerConversationIdentifier = conversation.metadata?[Constants.CONVERSATION_IMAGE_URL] as? String {
//                                
//                                var timestamp = ""
//                                if conversation.metadata?[Constants.CONVERSATION_TIMESTAMP] != nil {
//                                    timestamp = conversation.metadata?[Constants.CONVERSATION_TIMESTAMP] as! String
//                                }
//                                
//                                let uuid = layerConversationIdentifier.stringByReplacingOccurrencesOfString("layer:///conversations/", withString: "")
//                                if let imageURL = LMConversationService.getImageUrl(uuid, stamp: timestamp) {
//                                    messageCell.groupChatForegroundImageView.sd_setImageWithURL(NSURL(string: imageURL))
//                                } else {
//                                    print("Error retrieving ImageURL")
//                                }
//                            }
//                        }else {
//                            // No Coversation Image Metadata
//                            
//                            var initials = participants[0].username!.substringWithRange(Range<String.Index>(start: participants[0].username!.startIndex.advancedBy(0), end: participants[0].username!.endIndex.advancedBy(-(participants[0].username!.characters.count-1))))
//                            messageCell.groupInitialLabel.text = initials.uppercaseString
//                        }
//                    }
//                }
//                
//                // Format Date
//                messageCell.dateLabel.text = LMDateFormatter.formatDateWithDate(conversation.lastMessage?.receivedAt)
//                
//                // Set Last Message Label
//                if let lastMessage = conversation.lastMessage {
//                    let messagePart = lastMessage.parts[0] as? LYRMessagePart
//                    
//                    
//                    
//                    if messagePart?.MIMEType == Constants.MIME_TYPES.MIMETypeImagePNG {
//                        if lastMessage.sender.userID != self.currentUser.userID{
//                            messageCell.lastMessageLabel.text = "You recieved a Photo"
//                        }else{
//                            messageCell.lastMessageLabel.text = "You sent a Photo"
//                        }
//                    }
//                    else if messagePart?.MIMEType == Constants.MIME_TYPES.MIMETypeSticker {
//                        if lastMessage.sender.userID != self.currentUser.userID{
//                            messageCell.lastMessageLabel.text = "You recieved a Sticker"
//                        }else{
//                            messageCell.lastMessageLabel.text = "You sent a Sticker"
//                        }
//                    }
//                    else if messagePart?.MIMEType == Constants.MIME_TYPES.MIMETypeAttributedString {
//                        // TODO: Option 1. Send "text" as Notification
//                        messageCell.lastMessageLabel.text = "You recieved an Emoji"
//                    }
//                    else {
//                        if messagePart?.transferStatus == LYRContentTransferStatus.Complete {
//                            if let fontname = FontService().getContactFontName(lastMessage.sender.userID!) {
//                                messageCell.lastMessageLabel.font = UIFont(name: fontname, size: FONT_SIZE_LAST_MESSAGE)
//                            }else {
//                                messageCell.lastMessageLabel.font = UIFont(name: Constants.FONTNAME_RABIOHEAD, size: FONT_SIZE_LAST_MESSAGE)
//                            }
//                            messageCell.lastMessageLabel.text = NSString(data: messagePart!.data!, encoding: NSUTF8StringEncoding) as? String
//                        }
//                    }
//                }
//                
//                // Fetch Unread Messages Count
//                let unReadMessages = self.fetchUnreadMessagesCount(conversation)
//                if unReadMessages.count > 0 {
//                    
//                    print("unread messages: \(unReadMessages.count)")
//                    
//                    messageCell.numberOfMessagesLabel.hidden = false
//                    messageCell.numberOfMessagesImageView.hidden = false
//                    messageCell.numberOfMessagesLabel.text = "\(unReadMessages.count)"
//                }else {
//                    messageCell.numberOfMessagesLabel.hidden = true
//                    messageCell.numberOfMessagesImageView.hidden = true
//                    messageCell.numberOfMessagesLabel.text = ""
//                }
//            }
//            
//        }
//        
//        return messageCell
//    }
//    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            // Delete code here.......
//        }
//    }
//    
//    // MARK: - UITableView Delegate Methods
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        
//        selectedRowIndexPath = indexPath
//        
//        let convo = queryController!.objectAtIndexPath(indexPath) as! LYRConversation;
//        let message = self.getMessageData(convo);
//        
//        if message.friends.count != message.layerConversation?.participants.count {
//            if let participantsIds = message.layerConversation?.participants {
//                for id in participantsIds {
//                    let index = message.friends.indexOf({$0.id == id})
//                    if index == nil {
//                        let nonFriendIndex = nonFriendChatParticipants.indexOf({$0.id == id})
//                        print("non friend index is \(nonFriendIndex)")
//                        if (nonFriendIndex != nil && currentUser.userID! != id ){
//                            message.friends.append(nonFriendChatParticipants[nonFriendIndex!])
//                        }
//                    }
//                }
//            }
//        }
//        let chatViewController = ChatViewController(layerClient: self.layerClient, currentUser: self.currentUser, friends: message.friends, conversation: message.layerConversation!)
//        
//        self.navigationController?.pushViewController(chatViewController, animated: true)
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 80
//    }
//    
//    // Actions for Row During Swipe Edit
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//        
//        let conversation = self.queryController?.objectAtIndexPath(indexPath) as? LYRConversation
//        
//        let deleteAction = BGTableViewRowActionWithImage.rowActionWithStyle(UITableViewRowActionStyle.Normal, title: "    ", backgroundColor: UIColor.whiteColor(), image: UIImage(named: "trash-icon-3"), forCellHeight: 160) { (tableViewRowAction, indexPath) -> Void in
//            
//            if let conversation = self.queryController?.objectAtIndexPath(indexPath) as? LYRConversation {
//                
//                conversation.delete(LYRDeletionMode.MyDevices, error: nil)
//                // Remove Participant from Layer Conversation
//                //                if conversation.participants.count <= 2{
//                //                    conversation.delete(LYRDeletionMode.MyDevices, error: nil)
//                //                }else{
//                //                    do {
//                //                        conversation.delete
//                //                        try conversation.removeParticipants([self.currentUser.userID!])
//                //                    }catch {
//                //                        print("Error Removing Participant with error: \(error)")
//                //                    }
//                //                }
//            }
//        }
//        
//        
//        let mute = conversation?.metadata?[Constants.CONVERSATION_MUTE_KEY] as? String
//        
//        // Get the Selected Cell and show the Mute View
//        let messagesCell = self.messageView.tableView.cellForRowAtIndexPath(indexPath) as! MessagesCell
//        
//        if mute == nil || mute == Constants.CONVERSATION_MUTE_OFF {
//            self.muteImageName = "mute-icon-3"
//            messagesCell.muteImageView.hidden = true
//        } else {
//            self.muteImageName = "unmute-icon-3"
//            messagesCell.muteImageView.hidden = false
//        }
//        
//        let muteAction = BGTableViewRowActionWithImage.rowActionWithStyle(UITableViewRowActionStyle.Normal, title: "    ", backgroundColor: UIColor.whiteColor(), image: UIImage(named: self.muteImageName), forCellHeight: 160) { (tableViewRowAction, indexPath) -> Void in
//            
//            // Toggle Mute Off
//            if self.muteCheck(conversation!) == true{
//                messagesCell.muteImageView.hidden = false
//                
//                var statusDict = [String: String]()
//                var metaDataDict =  [String : AnyObject]()
//                for participant in (conversation?.participants)!{
//                    
//                    if participant == self.currentUser.userID{
//                        
//                        statusDict.updateValue("muteOff", forKey: participant)
//                    }
//                    
//                }
//                metaDataDict.updateValue(statusDict, forKey: "status")
//                
//                
//                //conversation?.setValuesForKeysWithDictionary(metaDataDict)
//                conversation?.setValuesForMetadataKeyPathsWithDictionary(metaDataDict, merge: true)
//                
//                
//                //conversation?.setValue(Constants.CONVERSATION_MUTE_OFF, forMetadataAtKeyPath: Constants.CONVERSATION_MUTE_KEY)
//                
//                print("After -> \(conversation?.metadata)")
//                
//                
//            }else{
//                
//                messagesCell.muteImageView.hidden = true
//                print("Before -> \(conversation?.metadata)")
//                
//                
//                // Turn off Mute Metadata for Conversation
//                
//                
//                
//                
//                var statusDict = [String: String]()
//                var metaDataDict =  [String : AnyObject]()
//                for participant in (conversation?.participants)!{
//                    if participant == self.currentUser.userID{
//                        statusDict.updateValue("muteOn", forKey: participant)
//                    }
//                    
//                }
//                metaDataDict.updateValue(statusDict, forKey: "status")
//                
//                
//                //conversation?.setValuesForKeysWithDictionary(metaDataDict)
//                conversation?.setValuesForMetadataKeyPathsWithDictionary(metaDataDict, merge: true)
//                
//                
//                
//                // Set Mute Metadata for Conversation
//                //conversation?.setValue(Constants.CONVERSATION_MUTE_ON, forMetadataAtKeyPath: Constants.CONVERSATION_MUTE_KEY)
//                
//                
//                print("After -> \(conversation?.metadata)")
//                
//                
//            }
//            //            if mute == Constants.CONVERSATION_MUTE_ON {
//            //                messagesCell.muteImageView.hidden = false
//            //
//            //
//            //                print("Before -> \(conversation?.metadata)")
//            //
//            //
//            //                // Turn off Mute Metadata for Conversation
//            //            }
//            //
//            //            // Toggle Mute On
//            //            else {
//            //
//            //            }
//        }
//        
//        let rowActions = [deleteAction as UITableViewRowAction, muteAction as UITableViewRowAction]
//        
//        return rowActions
//    }
//    
//    // MARK: - LYRQueryControllerDelegate
//    
//    func queryControllerWillChangeContent(queryController: LYRQueryController) {
//        
//        var selectedConversation: LYRConversation!
//        let indexPath = self.messageView.tableView.indexPathForSelectedRow
//        
//        if indexPath != nil {
//            selectedConversation = self.queryController!.objectAtIndexPath(indexPath!) as! LYRConversation
//        }
//        self.conversationSelectedBeforeContentChange = selectedConversation
//        self.messageView.tableView.beginUpdates()
//        
//    }
//    
//    func queryController(controller: LYRQueryController, didChangeObject object: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: LYRQueryControllerChangeType, newIndexPath: NSIndexPath?) {
//        
//        switch (type) {
//        case LYRQueryControllerChangeType.Insert:
//            self.messageView.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
//            break;
//        case LYRQueryControllerChangeType.Update:
//            self.messageView.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
//            break;
//        case LYRQueryControllerChangeType.Move:
//            self.messageView.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
//            self.messageView.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
//            break
//        case LYRQueryControllerChangeType.Delete:
//            self.messageView.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
//            break
//        }
//        
//    }
//    
//    func queryControllerDidChangeContent(queryController: LYRQueryController) {
//        
//        if messageView.tableView.dataSource != nil {
//            self.messageView.tableView.endUpdates()
//            if ((self.conversationSelectedBeforeContentChange) != nil) {
//                let indexPath = self.queryController!.indexPathForObject(conversationSelectedBeforeContentChange)
//                if ((indexPath) != nil) {
//                    self.messageView.tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
//                }
//                self.conversationSelectedBeforeContentChange = nil;
//            }
//            self.setupViewState()
//        }
//        
//    }
//    
//    // MARK: - Actions
//    
//    func createNewChat(){
//        print(self.layerClient)
//        print(self.currentUser)
//        let lmTabBarController = self.tabBarController as! LMTabBarController
//        //let lmTabBarController = LMTabBarController()
//        print(lmTabBarController.layerClient)
//        print(lmTabBarController.currentUser)
//        if self.layerClient != nil && self.currentUser != nil {
//            let createNewChatView = CreateNewChatViewController(layerClient: self.layerClient, currentUser: self.currentUser/*, messagesView: self*/)
//            
//            //let navContorller = UINavigationController()
//            let navController = VerticalOnlyNavigationController()
//            
//            navController.viewControllers = [createNewChatView]
//            self.presentViewController(navController, animated: true, completion: nil)
//        }else {
//            print("Layer Client and Current User can't be nil")
//            return
//        }
//    }
//    
//    
//    // MARK: - Layer Notifications
//    
//    func registerForLayerNotifications() {
//        print("registerForLayerNotifications")
//        
//        // Register for Layer object change notifications
//        // For more information about Synchronization, check out https://developer.layer.com/docs/integration/ios#synchronization
//        NSNotificationCenter.defaultCenter().addObserver(self,
//            selector: "didReceiveLayerObjectsDidChangeNotification:",
//            name: LYRClientObjectsDidChangeNotification,
//            object: nil)
//        
//        // Register for synchronization notifications
//        NSNotificationCenter.defaultCenter().addObserver(self,
//            selector: "didReceiveLayerClientWillBeginSynchronizationNotification:",
//            name: LYRClientWillBeginSynchronizationNotification,
//            object: self.layerClient)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self,
//            selector: "didReceiveLayerClientDidFinishSynchronizationNotification:",
//            name: LYRClientDidFinishSynchronizationNotification,
//            object: self.layerClient)
//    }
//    
//    func unRegisterForLayerNotifications() {
//        print("unRegisterForLayerNotifications")
//        
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//    }
//    
//    // For more infor see: https://developer.layer.com/docs/ios/integration#synchronization
//    func didReceiveLayerObjectsDidChangeNotification(notification: NSNotification) {
//        
//    }
//    
//    func didReceiveLayerClientWillBeginSynchronizationNotification(notification: NSNotification) {
//        print("didReceiveLayerClientWillBeginSynchronizationNotification")
//    }
//    
//    func didReceiveLayerClientDidFinishSynchronizationNotification(notification: NSNotification) {
//        
//        print("didReceiveLayerClientDidFinishSynchronizationNotification")
//    }
//    
//    // Generate Color for the Chat Profile Image
//    func chatProfileColor() -> UIColor {
//        
//        var color = Constants.appColor
//        switch LMSingleton.sharedInstance().colorIndex {
//        case 1: color = Constants.COLOR1
//        case 2: color = Constants.COLOR2
//        case 3: color = Constants.COLOR3
//        case 4: color = Constants.COLOR4
//        default: break
//        }
//        LMSingleton.sharedInstance().colorIndex++
//        
//        if LMSingleton.sharedInstance().colorIndex == 5 {
//            LMSingleton.sharedInstance().colorIndex = 1
//        }
//        return color
//    }
//    

    

    
    


}

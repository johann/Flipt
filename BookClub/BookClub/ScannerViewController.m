//
//  ViewController.m
//  iOS7_BarcodeScanner
//
//  Created by Jake Widmer on 11/16/13.
//  Copyright (c) 2013 Jake Widmer. All rights reserved.
//


#import "ScannerViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Barcode.h"
#import "SMXMLDocument.h"
#import <CNPPopupController/CNPPopupController.h>
#import "Popup.h"


@import AVFoundation;   // iOS7 only import style

@interface ScannerViewController () <CNPPopupControllerDelegate, PopupDelegate>

@property (nonatomic, strong) CNPPopupController *popupController;
@property (strong, nonatomic) NSMutableArray * foundBarcodes;
//@property (weak, nonatomic) IBOutlet UIView *previewView;


//@property (strong, nonatomic) NSString *urlString;



@end

@implementation ScannerViewController{
   // urlString = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
    
    
    
    /* Here’s a quick rundown of the instance variables (via 'iOS 7 By Tutorials'):
     
     1. _captureSession – AVCaptureSession is the core media handling class in AVFoundation. It talks to the hardware to retrieve, process, and output video. A capture session wires together inputs and outputs, and controls the format and resolution of the output frames.
     
     2. _videoDevice – AVCaptureDevice encapsulates the physical camera on a device. Modern iPhones have both front and rear cameras, while other devices may only have a single camera.
     
     3. _videoInput – To add an AVCaptureDevice to a session, wrap it in an AVCaptureDeviceInput. A capture session can have multiple inputs and multiple outputs.
     
     4. _previewLayer – AVCaptureVideoPreviewLayer provides a mechanism for displaying the current frames flowing through a capture session; it allows you to display the camera output in your UI.
     5. _running – This holds the state of the session; either the session is running or it’s not.
     6. _metadataOutput - AVCaptureMetadataOutput provides a callback to the application when metadata is detected in a video frame. AV Foundation supports two types of metadata: machine readable codes and face detection.
     7. _backgroundQueue - Used for showing alert using a separate thread.
     */
    UIView *previewView;
    AVCaptureSession *_captureSession;
    AVCaptureDevice *_videoDevice;
    AVCaptureDeviceInput *_videoInput;
    AVCaptureVideoPreviewLayer *_previewLayer;
    BOOL _running;
    AVCaptureMetadataOutput *_metadataOutput;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    previewView = [[UIView alloc] init];
    previewView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.navigationController.navigationItem.title = @"";
    self.navigationController.navigationBarHidden = YES;
    
    
    [self.view addSubview:previewView];
    //[self configureRestKit];
    //[self loadBook];
    //AppDelegate *delegate =  [[UIApplication sharedApplication]delegate];
    //[delegate logInStatus];
    
    
    
        [self setupCaptureSession];
    
        _previewLayer.frame = previewView.bounds;
        [previewView.layer addSublayer:_previewLayer];
        self.foundBarcodes = [[NSMutableArray alloc] init];
        
        // listen for going into the background and stop the session
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(applicationWillEnterForeground:)
         name:UIApplicationWillEnterForegroundNotification
         object:nil];
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(applicationDidEnterBackground:)
         name:UIApplicationDidEnterBackgroundNotification
         object:nil];
        
        // set default allowed barcode types, remove types via setings menu if you don't want them to be able to be scanned
        self.allowedBarcodeTypes = [NSMutableArray new];
        [self.allowedBarcodeTypes addObject:@"org.iso.QRCode"];
        [self.allowedBarcodeTypes addObject:@"org.iso.PDF417"];
        [self.allowedBarcodeTypes addObject:@"org.gs1.UPC-E"];
        [self.allowedBarcodeTypes addObject:@"org.iso.Aztec"];
        [self.allowedBarcodeTypes addObject:@"org.iso.Code39"];
        [self.allowedBarcodeTypes addObject:@"org.iso.Code39Mod43"];
        [self.allowedBarcodeTypes addObject:@"org.gs1.EAN-13"];
        [self.allowedBarcodeTypes addObject:@"org.gs1.EAN-8"];
        [self.allowedBarcodeTypes addObject:@"com.intermec.Code93"];
        [self.allowedBarcodeTypes addObject:@"org.iso.Code128"];
        
    
                
    
    
    
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startRunning];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - AV capture methods

- (void)setupCaptureSession {
    // 1
    if (_captureSession) return;
    // 2
    _videoDevice = [AVCaptureDevice
                    defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!_videoDevice) {
        NSLog(@"No video camera on this device!");
        return;
    }
    // 3
    _captureSession = [[AVCaptureSession alloc] init];
    // 4
    _videoInput = [[AVCaptureDeviceInput alloc]
                   initWithDevice:_videoDevice error:nil];
    // 5
    if ([_captureSession canAddInput:_videoInput]) {
        [_captureSession addInput:_videoInput];
    }
    // 6
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc]
                     initWithSession:_captureSession];
    _previewLayer.videoGravity =
    AVLayerVideoGravityResizeAspectFill;
    
    
    // capture and process the metadata
    _metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    dispatch_queue_t metadataQueue =
    dispatch_queue_create("com.1337labz.featurebuild.metadata", 0);
    [_metadataOutput setMetadataObjectsDelegate:self
                                          queue:metadataQueue];
    if ([_captureSession canAddOutput:_metadataOutput]) {
        [_captureSession addOutput:_metadataOutput];
    }
}

- (void)startRunning {
    if (_running) return;
    [_captureSession startRunning];
    _metadataOutput.metadataObjectTypes =
    _metadataOutput.availableMetadataObjectTypes;
    _running = YES;
}
- (void)stopRunning {
    if (!_running) return;
    [_captureSession stopRunning];
    _running = NO;
}

//  handle going foreground/background
- (void)applicationWillEnterForeground:(NSNotification*)note {
    [self startRunning];
}
- (void)applicationDidEnterBackground:(NSNotification*)note {
    [self stopRunning];
}

#pragma mark - Button action functions
- (IBAction)settingsButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"toSettings" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


#pragma mark - Delegate functions

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    [metadataObjects
     enumerateObjectsUsingBlock:^(AVMetadataObject *obj,
                                  NSUInteger idx,
                                  BOOL *stop)
     {
         if ([obj isKindOfClass:
              [AVMetadataMachineReadableCodeObject class]])
         {
             // 3
             AVMetadataMachineReadableCodeObject *code =
             (AVMetadataMachineReadableCodeObject*)
             [_previewLayer transformedMetadataObjectForMetadataObject:obj];
             // 4
             Barcode * barcode = [Barcode processMetadataObject:code];
             
             for(NSString * str in self.allowedBarcodeTypes){
                if([barcode.getBarcodeType isEqualToString:str]){
                    [self validBarcodeFound:barcode];
                    return;
                }
            }
         }
     }];
}

- (void) validBarcodeFound:(Barcode *)barcode{
    [self stopRunning];
    [self.foundBarcodes addObject:barcode];
    [self showBarcodeAlert:barcode];
}
- (void) showBarcodeAlert:(Barcode *)barcode{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Code to do in background processing
        NSString * urlString = @"https://www.googleapis.com/books/v1/volumes?q=isbn:";
        NSString *apiKey = @"&bookclub-1009";
        //alertMessage = [alertMessage stringByAppendingString:[barcode getBarcodeType]];
//        alertMessage = [alertMessage stringByAppendingString:@" and data "];
        NSLog(@"%@", [barcode getBarcodeData]);
        urlString = [urlString stringByAppendingString:[barcode getBarcodeData]];
        urlString = [urlString stringByAppendingString: apiKey];
        NSLog(@"%@", urlString);
        
        NSURL *data = [NSURL URLWithString:urlString];
        NSData *bookData = [NSData dataWithContentsOfURL:data];
        
        NSDictionary* json = nil;
        if (bookData){
            json = [NSJSONSerialization JSONObjectWithData:bookData options:kNilOptions error:nil];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSLog([self isFound:json] ? @"Yes" : @"No");
            
            if ([self isFound:json]){
                [self showBookPopup:[self getTitle:json] subtitle:[self getAuthor:json] imageUrl:[self getImage:json] json:json];
            /*
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            paragraphStyle.alignment = NSTextAlignmentCenter;
            
            NSAttributedString *title = [[NSAttributedString alloc] initWithString:[self getTitle:json] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
            NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:[self getAuthor:json] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
            
            NSLog(@"%@", [self getTitle:json]);
            NSLog(@"%@", [self getAuthor:json]);
            NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"With style, using NSAttributedString" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
            
            CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [button setTitle:@"Add to BookShelf" forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
            button.layer.cornerRadius = 4;
            button.selectionHandler = ^(CNPPopupButton *button){
               // [self startRunning];
                [self updateWithDictionary: json];
                [self.popupController dismissPopupControllerAnimated:YES];
                
                NSLog(@"Block for button: %@", button.titleLabel.text);
            };
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.numberOfLines = 0;
            titleLabel.attributedText = title;
            
            UILabel *lineOneLabel = [[UILabel alloc] init];
            lineOneLabel.numberOfLines = 0;
            lineOneLabel.attributedText = lineOne;
            
            NSURL *imageURL = [NSURL URLWithString:[self getImage:json]];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
            [self downloadImageWithURL:imageURL completionBlock:^(BOOL succeeded, UIImage *image) {
                if (succeeded) {
                    imageView.image = image;
                
                    }
            }];
            /*
             UILabel *lineTwoLabel = [[UILabel alloc] init];
             lineTwoLabel.numberOfLines = 0;
             lineTwoLabel.attributedText = lineTwo;*/
            
            
            /*
            self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, imageView, button]];
            self.popupController.theme = [CNPPopupTheme defaultTheme];
            self.popupController.theme.popupStyle = CNPPopupStyleCentered;
            self.popupController.delegate = self;
                
            
            [self.popupController presentPopupControllerAnimated:YES];
             */
            }
            else{
                
                [self checkGoodreads:[barcode getBarcodeData]];
                //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
               /* UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Didn't Find"                                                                  message:@""
                                                                 delegate:self
                                                        cancelButtonTitle:@"Done"
                                                        otherButtonTitles:@"Try Again",nil];
                
               [message show];*/
            }

            
        });
        
        
        //[self updateWithDictionary: json];
        
        
        
        
        
        /*dispatch_async(dispatch_get_main_queue(), ^{
            // Code to update the UI/send notifications based on the results of the background processing
            
            //[message show];

        });
         */
        
        [self startRunning];
    });
}

- (void)showBookPopup:(NSString*)titleText
             subtitle:(NSString*)subtitle
             imageUrl:(NSString*)imageUrlString
                 json:(NSDictionary*)json{
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleText attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:subtitle attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"Add to BookShelf" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        // [self startRunning];
        [self updateWithDictionary: json];
        [self.popupController dismissPopupControllerAnimated:YES];
        
        NSLog(@"Block for button: %@", button.titleLabel.text);
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    
    NSURL *imageURL = [NSURL URLWithString:imageUrlString];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    [self downloadImageWithURL:imageURL completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            imageView.image = image;
            
        }
    }];
    /*
     UILabel *lineTwoLabel = [[UILabel alloc] init];
     lineTwoLabel.numberOfLines = 0;
     lineTwoLabel.attributedText = lineTwo;*/
    
    
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, imageView, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = CNPPopupStyleCentered;
    self.popupController.delegate = self;
    
    
    [self.popupController presentPopupControllerAnimated:YES];
    
}


- (void)checkGoodreads:(NSString*)scannedBarcode{
    NSString *urlString = @"https://www.goodreads.com/search/index.xml?q=";
    NSString *apiKey = @"&key=CXceuU1Ld0vCJdWnipqa0w";
    //urlString = [urlString stringByAppendingString:[barcode getBarcodeData]];
    urlString = [urlString stringByAppendingString:scannedBarcode];
    urlString = [urlString stringByAppendingString: apiKey];
    NSLog(@"%@", urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *dataSource = [NSData dataWithContentsOfURL:url];
    
    NSError *error;
    SMXMLDocument *document = [SMXMLDocument documentWithData:dataSource error:&error];
    
    // check for errors
    if (error) {
        NSLog(@"Error while parsing the document: %@", error);
        return;
    }
    
    SMXMLElement *books = [document childNamed:@"search"];
    SMXMLElement *results = [books childNamed:@"results"];
    SMXMLElement *work = [results childNamed:@"work"];
    SMXMLElement *bookID = [work childNamed:@"best_book"];
    NSString *titleValue = [bookID valueWithPath:@"title"];
    NSString *imageUrlValue = [bookID valueWithPath:@"image_url"];
    NSArray *authors = [[bookID childNamed:@"author"].children valueForKeyPath:@"value" ];
    
    
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleValue attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:authors[1] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    
    
    CNPPopupButton *button = [[CNPPopupButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [button setTitle:@"Add to BookShelf" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0];
    button.layer.cornerRadius = 4;
    button.selectionHandler = ^(CNPPopupButton *button){
        // [self startRunning];
        //[self updateWithDictionary: json];
        PFObject *bookInfo = [PFObject objectWithClassName:@"Book"];
        PFUser *currentUser = [PFUser currentUser];
        
        bookInfo[@"title"] = titleValue;
        bookInfo[@"searchText"] = [titleValue lowercaseString];
        //bookInfo[@"subtitle"] = [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"subtitle"]];
        //bookInfo[@"description"] = [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"description"]];
        bookInfo[@"author"] = authors[1];
        bookInfo[@"imageUrl"] = imageUrlValue;
        bookInfo[@"user"] = currentUser;
        
        
        [bookInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"%@", bookInfo);
            } else {
                // There was a problem, check error.description
            }
        }];
        [self.popupController dismissPopupControllerAnimated:YES];
        
        NSLog(@"Block for button: %@", button.titleLabel.text);
    };
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.attributedText = title;
    
    UILabel *lineOneLabel = [[UILabel alloc] init];
    lineOneLabel.numberOfLines = 0;
    lineOneLabel.attributedText = lineOne;
    
    NSURL *imageURL = [NSURL URLWithString:imageUrlValue];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    [self downloadImageWithURL:imageURL completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            imageView.image = image;
            
        }
    }];
    /*
     UILabel *lineTwoLabel = [[UILabel alloc] init];
     lineTwoLabel.numberOfLines = 0;
     lineTwoLabel.attributedText = lineTwo;*/
    
    
    
    self.popupController = [[CNPPopupController alloc] initWithContents:@[titleLabel, lineOneLabel, imageView, button]];
    self.popupController.theme = [CNPPopupTheme defaultTheme];
    self.popupController.theme.popupStyle = CNPPopupStyleCentered;
    self.popupController.delegate = self;
    
    
    [self.popupController presentPopupControllerAnimated:YES];
    
    NSLog(@"%@",title);
    
    NSLog(@"%@",authors[1]);
    
}


- (BOOL)isFound:(NSDictionary*)json{
    BOOL isBookFound=NO;
     int foundKey = [[NSString stringWithFormat:@"%@",json[@"totalItems"]] intValue];
    NSLog(@"%d", foundKey);
    
    if (!foundKey == 0){
        isBookFound = YES;
        
    }
    else {
        
    }
    return isBookFound;
}

- (BOOL)duplicateFound{
    __block BOOL isDuplicateFound = NO;
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            if (objects.count == 0){
                isDuplicateFound = NO;
                
                
            }else{
                isDuplicateFound = YES;
                
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    return isDuplicateFound;
}
- (NSString *)getTitle:(NSDictionary*)json{
    
    return [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"title"]];
}
- (NSString *)getAuthor:(NSDictionary*)json{
    return [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"authors"][0]];
}
- (NSString *)getImage:(NSDictionary*)json{
    return [NSString stringWithFormat:@"%@", json[@"items"][0][@"volumeInfo"][@"imageLinks"][@"thumbnail"]];
}



- (void)updateWithDictionary:(NSDictionary*)json{

    
    
    if ([self isFound:json]){
        PFObject *bookInfo = [PFObject objectWithClassName:@"Book"];
        PFUser *currentUser = [PFUser currentUser];
    
        bookInfo[@"title"] = [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"title"]];
        bookInfo[@"searchText"] = [[NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"title"]] lowercaseString];
        bookInfo[@"subtitle"] = [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"subtitle"]];
        bookInfo[@"description"] = [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"description"]];
        bookInfo[@"author"] = [NSString stringWithFormat:@"%@",json[@"items"][0][@"volumeInfo"][@"authors"][0]];
        bookInfo[@"imageUrl"] = [NSString stringWithFormat:@"%@", json[@"items"][0][@"volumeInfo"][@"imageLinks"][@"thumbnail"]];
        
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", json[@"items"][0][@"volumeInfo"][@"imageLinks"][@"thumbnail"]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
        
        
        [self downloadImageWithURL:imageURL completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                NSData *imageData = UIImagePNGRepresentation(image);
                NSLog(@"%@", imageData);
                
                PFFile *imageFile = [PFFile fileWithName:@"image" data:imageData];
                [bookInfo setValue:imageFile forKey:@"coverImage"];
                /*
                [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        if (succeeded) {
                            
                            NSLog(@"worked! %@", bookInfo[@"coverImage"] );
                        }
                    } else {
                        
                    }
                }];
                 */

               /* PFFile *imageFile = [PFFile fileWithData:UIImageJPEGRepresentation(image, 1.0)];
                [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        if (succeeded) {
                            bookInfo[@"coverImage"] = imageFile;
                            NSLog(@"worked! %@", bookInfo[@"coverImage"] );
                        }
                    } else {
                        // Handle error
                    }
                }];
                */
                
                
            }
        }];
        
        /*
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (!error) {
                PFFile *file = [PFFile fileWithData:data];
                [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        if (succeeded) {
                            bookInfo[@"coverImage"] = file;
                            NSLog(@"worked! %@", bookInfo[@"coverImage"] );
                        }
                    } else {
                        // Handle error
                    }        
                }];
                
                
            }
        }];
        */
        
        bookInfo[@"user"] = currentUser;
        
        
        [bookInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"%@", bookInfo);
            } else {
            // There was a problem, check error.description
            }
        }];
    }

}
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        //Code for Done button
        // TODO: Create a finished view
        [self startRunning];
    }
    if(buttonIndex == 1){
        //Code for Scan more button
        [self startRunning];
        
    }
}


- (void) settingsChanged:(NSMutableArray *)allowedTypes{
    for(NSObject * obj in allowedTypes){
        NSLog(@"%@",obj);
    }
    if(allowedTypes){
        self.allowedBarcodeTypes = [NSMutableArray arrayWithArray:allowedTypes];
    }
}

// TODO implement ISBN popup for entering ISBN to add book
- (void)showISBNController{
    Popup *popup = [[Popup alloc] initWithTitle:@"Add Book"
                                       subTitle:@"Enter the your book's ISBN (without dashes)"
                                    cancelTitle:nil
                                   successTitle:@"Success"];
    [popup setRoundedCorners:YES];
    [popup setBackgroundBlurType:PopupBackGroundBlurTypeExtraLight];
    [popup setTapBackgroundToDismiss:YES];
    [popup setTextFieldTypeForTextFields:@[@"DEFAULT"]];
    [popup showPopup];
    
    
}
-(void)popupPressButton:(Popup *)popup buttonType:(PopupButtonType)buttonType{
    if (buttonType == PopupButtonCancel){
        
    }
    else if (buttonType == PopupButtonSuccess){
        
    }
}

-(void)dictionary:(NSMutableDictionary *)dictionary forpopup:(Popup *)popup stringsFromTextFields:(NSArray *)stringArray{
    NSString *textFromBox1 = [stringArray objectAtIndex:0];
    
    
}


@end



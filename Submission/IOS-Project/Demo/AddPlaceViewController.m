//
//  AddPlaceViewController.m
//  Demo
//
//  Created by acp16w on 13/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "AddPlaceViewController.h"
#import "DbAccess.h"
#import "Place.h"
#import "UIImageCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ViewController.h"
#import "GeneralMethods.h"

@interface AddPlaceViewController ()

@end

@implementation AddPlaceViewController

bool isCurrentZoomed = false;
UIImageView* zoomedView = nil;
NSMutableDictionary* alphaTracker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.options = [[PHImageRequestOptions alloc]init];
    self.options.resizeMode = PHImageRequestOptionsResizeModeExact;
    self.options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    self.options.synchronous = YES;
    
    
    //Do we already have an existing model in the db
    Place* model = [self.inserter pullWithId:self.currentPlace.placeId];
    
    self.imageURLS = [self.imageInserter pullWithId:self.currentPlace.placeId];
    
    self.images = [[NSMutableArray alloc]init];
    
    for(NSString* path in self.imageURLS){
        NSURL* url = [NSURL URLWithString:path];
        NSArray* arr = @[url];
        PHAsset* imagePath = [[PHAsset fetchAssetsWithALAssetURLs:arr options:nil]firstObject];
        [self.images addObject:imagePath];
    }
    
    if(model){
        self.website.text = model.placeWebsite;
        self.name.text = model.placeName;
        self.placeId = self.currentPlace.placeId;
        self.phone.text = model.placePhone;
        self.comments.text = model.placeComments;
        self.address.text = model.placeAddress;
    }
    
    //If we don't, create a new model from the source data
    else{
        self.address.text = self.currentPlace.placeAddress;
        self.website.text = self.currentPlace.placeWebsite;
        self.name.text = self.currentPlace.placeName;
        self.placeId = self.currentPlace.placeId;
        self.phone.text = self.currentPlace.placePhone;
    }

    [self stylizeView:self.address width:2 rad:5 color:[UIColor whiteColor]];
    [self stylizeView:self.phone width:2 rad:5 color:[UIColor whiteColor]];
    [self stylizeView:self.name width:2 rad:5 color:[UIColor whiteColor]];
    [self stylizeView:self.comments width:2 rad:5 color:[UIColor whiteColor]];
    [self stylizeView:self.website width:2 rad:5 color:[UIColor whiteColor]];
    
    self.imageView.dataSource = self;
    self.imageView.delegate = self;
    
}

-(void)createInserterForThisView{
    self.inserter = [[FavePlaceInserter alloc]init];
    self.imageInserter = [[ImagePathInserter alloc]init];
}


-(void)stylizeView:(UIView*)view width:(int)boarderWidth rad:(int)radius color:(UIColor*)col{
    [view.layer setBorderColor:[col CGColor]];
    view.layer.borderWidth = boarderWidth;
    view.layer.cornerRadius = radius;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPlace:(Place *)place{
    self.currentPlace = place;
}

-(IBAction)save:(UIButton *)sender{
    if(self.inserter != nil){
        Place* model = [[Place alloc]initWithId:self.placeId];
        model.placeName = self.name.text;
        model.placeComments = self.comments.text;
        model.placePhone = self.phone.text;
        model.placeWebsite = self.website.text;
        model.placeAddress = self.address.text;
        [self.inserter insertWithType:model];
        
        NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
        
        [dict setObject:model.placeId forKey:PLACE_ID];
        [dict setObject:self.imageURLS forKey:PATHS];
        [self.imageInserter insertWithType:dict];
        
    }
}

-(IBAction)takeSnapAddToGal:(UIButton *)sender{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
        }
        else{
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImageCell *cell = [self.imageView dequeueReusableCellWithReuseIdentifier:@"Img_Cell" forIndexPath:indexPath];
    PHImageManager* defaultM = [PHImageManager defaultManager];
    
    UIImage* __block result;
    
    PHAsset* img = [self.images objectAtIndex:[indexPath row]];
    
    [defaultM requestImageForAsset:img
                       targetSize:PHImageManagerMaximumSize
                      contentMode:PHImageContentModeDefault
                          options:self.options
                    resultHandler:^void(UIImage *image, NSDictionary *info) {
                        result = image;
                    }];
    
    cell.imageView.image =result;
    [self popoutView:cell];
    return cell;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    if(![info objectForKey:@"UIImagePickerControllerReferenceURL"]){
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //I do not care these frameworks are deprecated.
        //Using the photos frameworks means I have to piss about with string manipulation to re-construct the url I just saved
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:((UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage]).CGImage
                                     metadata:[info objectForKey:UIImagePickerControllerMediaMetadata]
                              completionBlock:^(NSURL *assetURL, NSError *error) {
                                  NSString* strUrl = [assetURL absoluteString];
                                  
                                  if(![self.imageURLS containsObject:strUrl])
                                  {
                                      [self.imageURLS addObject:strUrl];
                                      PHAsset* imagePath = [[PHAsset fetchAssetsWithALAssetURLs:@[assetURL] options:nil]lastObject];
                                      
                                      [self.images addObject:imagePath];
                                      [self.imageView reloadData];
                                  }
                                  
                              }];
        
        #pragma clang diagnostic pop
    }

    else{
        NSURL* url = info[@"UIImagePickerControllerReferenceURL"];
        NSString* strUrl = [url absoluteString];
        if(![self.imageURLS containsObject:strUrl])
        {
            [self.imageURLS addObject:strUrl];
            PHAsset* imagePath = [[PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil]lastObject];

            [self.images addObject:imagePath];
            [self.imageView reloadData];
        }
    }
}

-(IBAction)browseForImage:(UIButton *)sender{
    UIImagePickerController *imagePicker = [[UIImagePickerController     alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!isCurrentZoomed){
        UIImageCell* cell = (UIImageCell*) [collectionView cellForItemAtIndexPath:indexPath];
        UIImageView * zoomer = [[UIImageView alloc]initWithImage:cell.imageView.image];
        zoomer.frame = cell.bounds;
        zoomer.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:zoomer];
    
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
        singleTap.numberOfTapsRequired = 1;
        [zoomer setUserInteractionEnabled:YES];
        [zoomer addGestureRecognizer:singleTap];
        
        
        CGRect zoomFrameTo = [UIScreen mainScreen].bounds;
        
        [UIView animateWithDuration:0.5 animations:
         ^{
             zoomer.frame = zoomFrameTo;
             
             [GeneralMethods processSubviewsRecur:self.view onFound:^(UIView* foundView){
                 if(foundView != zoomer){
                    foundView.alpha = 0.5;
                 }
             }];
             
         } completion:^(BOOL finished){
             isCurrentZoomed = true;
             zoomedView = zoomer;
         }];
    }

}

-(void)popoutView:(UIView*)view{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(10, 10);
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowRadius = 5.0;
}

-(void)imageTap{
    [zoomedView removeFromSuperview];
    isCurrentZoomed = false;
    [GeneralMethods processSubviewsRecur:self.view onFound:^(UIView* foundView){
        foundView.alpha = 1.0f;
        
    }];
    self.imageView.scrollEnabled = false;
}

-(IBAction)addMarker:(UIButton *)sender{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(self.currentPlace.latitude, self.currentPlace.longitude);
    GMSMarker* marker = [GMSMarker markerWithPosition:position];
    marker.title = self.name.text;
    ViewController *controller = (ViewController*) [self.navigationController.viewControllers firstObject];
    
    if(![controller.markers containsObject:marker])
    {
        [controller.markers addObject:marker];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    isCurrentZoomed = false;
    [zoomedView removeFromSuperview];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

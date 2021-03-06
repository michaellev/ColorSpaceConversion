//
//  ViewController.h
//  ColorSpaceConersion
//

#include <opencv2/core/mat.hpp>
#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>
#import "SettingsViewController.h"
#import "ImagePickerController.h"

@interface ViewController : UIViewController <SettingsViewControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,CvVideoCameraDelegate>
{
    UIActionSheet* actionSheetImageOperations;
    
    ImagePickerController* imagePicker;
    
    BOOL enableProcessing;
	
	CvVideoCamera* videoCamera;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hsvButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *grayButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *binaryButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem * backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem * forwardButton;
@property (weak, nonatomic) IBOutlet UISlider *thresholdSlider;
@property (nonatomic, retain) IBOutlet UIActionSheet * actionSheetImageOperations;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *libraryButton;
@property(retain, nonatomic) IBOutlet UISwitch *camSwitch;



#ifdef __cplusplus
@property (readonly, nonatomic) cv::Mat inputMat;
@property (readwrite,nonatomic) cv::Mat hsvImage;
// @property (readwrite,nonatomic) cv::Mat *imageHistory;
#endif 

- (UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
- (cv::Mat)cvMatFromUIImage:(UIImage *)image;
- (cv::Mat)cvMatGrayFromUIImage:(UIImage *)image;

@property (nonatomic, retain) CvVideoCamera* videoCamera;
@property (nonatomic, retain) ImagePickerController* imagePicker;

-(IBAction)hsvImageAction:(id)sender;
-(IBAction)grayImageAction:(id)sender;
-(IBAction)binaryImageAction:(id)sender;
-(IBAction)binarySliderAction:(id)sender;
-(IBAction)backward:(id)sender;
-(IBAction)forward:(id)sender;
-(IBAction)forwardImageAction:(id)sender;
-(IBAction)showImageOperations:(id)sender;
-(IBAction)resetImage:(id)sender;
-(IBAction)showPhotoLibrary:(id)sender;
-(IBAction)switchCamera:(id)sender;
-(IBAction)switchProcessingOnOff:(id)sender;



@end

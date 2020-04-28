/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageWebPCoder/SDWebImageWebPCoder.h>

@interface MyCustomTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *customTextLabel;
@property (nonatomic, strong) SDAnimatedImageView *customImageView;

@end

@implementation MyCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _customImageView = [[SDAnimatedImageView alloc] initWithFrame:CGRectMake(20.0, 2.0, 60.0, 40.0)];
        [self.contentView addSubview:_customImageView];
        _customTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 12.0, 200, 20.0)];
        [self.contentView addSubview:_customTextLabel];
        
        _customImageView.clipsToBounds = YES;
        _customImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end

@interface MasterViewController ()

@property (nonatomic, strong) NSMutableArray<NSString *> *objects;

@end

@implementation MasterViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"SDWebImage";
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Clear Cache"
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(flushCache)];
        
        [[SDImageCodersManager sharedManager] addCoder:[SDImageWebPCoder sharedCoder]]; // For WebP static/animated image
        [[SDImageCodersManager sharedManager] addCoder:[SDImageHEICCoder sharedCoder]]; // For HEIC static/animated image. Animated image is new introduced in iOS 13, but it contains performance issue for now.
        
        // HTTP NTLM auth example
        // Add your NTLM image url to the array below and replace the credentials
        [SDWebImageDownloader sharedDownloader].config.username = @"httpwatch";
        [SDWebImageDownloader sharedDownloader].config.password = @"httpwatch01";
        [[SDWebImageDownloader sharedDownloader] setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
        [SDWebImageDownloader sharedDownloader].config.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
        
        self.objects = [NSMutableArray arrayWithObjects:
                    @"https://c1c2133e2cc13.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200428/630867313310040576.jpg",
                    @"https://c1c2133e2cc13.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200428/630867312336962048.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630780658226040192",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630780658335092096",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630757709414665344",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630757709624380544",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630757709808929920",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_640,i_frame0,f_webp/pic/20200428/630757491084365184.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630757492279741824",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630757492422348160",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_593,i_frame0,f_webp/pic/20200428/630757177023270016.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630757178134760576",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630757178579356800",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_367,i_frame0,f_webp/pic/20200428/630756944767880576.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630756946848255360",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630756946978278784",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630665695130029184",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630665695583014016",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200428/630665695788534912",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630622892052188544.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630622892656168320.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630622892907826560.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630622893109153152.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200427/630544092031356288",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200427/630544092224294272",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200427/630544092559838592",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200427/630544092954103168",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200427/630543765987134592",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_732,i_frame0,f_webp/pic/20200427/630543766255570048.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_600,i_frame0,f_webp/pic/20200427/630543767874571392.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_470,i_frame0,f_webp/pic/20200427/630543000434379904.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_773,i_frame0,f_webp/pic/20200427/630543001336155264.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_480,i_frame0,f_webp/pic/20200427/630543003022265472.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/pic/20200427/630515717166337408.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_700,i_frame0,f_webp/pic/20200427/630515689706229120.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_700,i_frame0,f_webp/pic/20200427/630515690926771584.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_600,i_frame0,f_webp/pic/20200427/630515693078449536.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_1000,i_frame0,f_webp/pic/20200427/630515693783092608.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200427/630515493886758272",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515420972977536",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515421086223744",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515421207858560",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515421363047808",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515202483293568",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515202625899904",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515202944667008",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200427/630515203217296768",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515050712403072",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515050842426496",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515051077307520",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630515051538680960",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514891651812736",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514891765058944",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514891953802624",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514892138352000",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514710483045760",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514710629846400",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514711007333760",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630514711158328704",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630497158453267840",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630497158662983040",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_430,i_frame0,f_webp/pic/20200427/630490848483609984.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_480,i_frame0,f_webp/pic/20200427/630490849230196096.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_500,i_frame0,f_webp/pic/20200427/630490850027113856.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_480,i_frame0,f_webp/pic/20200427/630490404659137664.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_480,i_frame0,f_webp/pic/20200427/630490405426695296.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488928553536640",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488928712920192",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488603977321856",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488604249951616",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488605445328256",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488365745048960",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200427/630488366286114176",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488181703183488",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488182059699328",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630488182261025920",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487749417241728",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487749685677184",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487593435270528",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487593733066112",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487420361510016",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487420550253696",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487269555309952",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487269773413760",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200427/630487269899242880",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487049203354752",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630487049429847168",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630486741265943680",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630486741454687360",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630486574638828928",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630486574907264384",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630486409102232704",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630486409307753600",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630479468997119360",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630451793926556800.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200427/630451794559896704.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200427/630395458686028928",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630395458832829568",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630395459017378944",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630395073426623616",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630395073632144512",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630395073967688832",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_500,i_frame0,f_webp/pic/20200427/630394786259405952.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200427/630394787026963584",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630394787215707264",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_500,i_frame0,f_webp/pic/20200427/630394439826673024.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630394441168850304",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200427/630394441353399680",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_580,i_frame0,f_webp/pic/20200426/630241836253842816.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_900,i_frame0,f_webp/pic/20200426/630241836924931456.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630241527125249408.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/pic/20200426/630241399178005888.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_600,i_frame0,f_webp/pic/20200426/630241334556364160.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630241336049536384.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/pic/20200426/630241184656133248.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630236734302456960.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165972602326144",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165779869863296",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165534175923328",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165534452747392",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165345205751168",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165345377717632",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165211587808384",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165212019821696",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165212678327424",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164977277209728",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630164977751166080",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200426/630164978044767360",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164773421452672",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164773996072320",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164598695136384",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164599366225024",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164441803001216",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164442314706304",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164273766599808",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164274009869440",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164773421452672",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164773996072320",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164977277209728",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630164977751166080",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200426/630164978044767360",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165211587808384",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165212019821696",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630165212678327424",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164598695136384",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164599366225024",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164441803001216",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164442314706304",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164273766599808",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164274009869440",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164117461666944",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630164117637827712",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163961429363840",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163961588747392",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_820,i_frame0,f_webp/pic/20200426/630163887890631808.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163889576742016",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630163890054892672",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163766645886336",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163766981430656",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_515,i_frame0,f_webp/pic/20200426/630163537183903104.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163539687902592",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163540098944384",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_700,i_frame0,f_webp/pic/20200426/630163241376419200.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163242521464192",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630163242714402176",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154574950305152",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154575067745664",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154575281655168",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154575474593152",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154446185172352",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154446319390080",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630154447158250880",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154447573486976",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154267956612224",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154268086635648",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154268480900224",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630154268757724288",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630153557592509824",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630153557844168064",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630153174442839424",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630153174551891328",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630153174677720448",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630153175067790720",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630153073389473152",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200426/630153073506913664",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630153073624354176",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630153073821486464",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630152838143544448",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630152838248402048",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630152838382619776",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630152838655249536",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_462,i_frame0,f_webp/pic/20200426/630152714101198208.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_360,i_frame0,f_webp/pic/20200426/630152714537405824.gif",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630152609151323520",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630152609285541248",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630152609423953280",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630152609629474176",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630152469002849664",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630152469141261696",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630152469309033856",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630152469770407296",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200426/630150420563496064",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200426/630150420773211264",
                    @"https://d040779c2cd49.cdn.sohucs.com/q_mini,f_webp,q_75,a_auto/pic/20200426/630150420978732160",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630124424992918912",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630124425550761344",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630124425722727808",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630124289571425664.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,w_694,f_webp,q_75,a_auto/pic/20200426/630124289873415552.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630124290263485824.jpg",
                    @"https://d040779c2cd49.cdn.sohucs.com/c_zoom,h_694,f_webp,q_75,a_auto/pic/20200426/630124290531921280.jpg",

                    nil];

        for (int i=1; i<25; i++) {
            // From http://r0k.us/graphics/kodak/, 768x512 resolution, 24 bit depth PNG
            [self.objects addObject:[NSString stringWithFormat:@"http://r0k.us/graphics/kodak/kodak/kodim%02d.png", i]];
        }
    }
    return self;
}

- (void)flushCache {
    [SDWebImageManager.sharedManager.imageCache clearWithCacheType:SDImageCacheTypeAll completion:nil];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    static UIImage *placeholderImage = nil;
    if (!placeholderImage) {
        placeholderImage = [UIImage imageNamed:@"placeholder"];
    }
    
    MyCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.customImageView.sd_imageTransition = SDWebImageTransition.fadeTransition;
        cell.customImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayIndicator;
    }
    
    cell.customTextLabel.text = [NSString stringWithFormat:@"Image #%ld", (long)indexPath.row];
    __weak SDAnimatedImageView *imageView = cell.customImageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.objects[indexPath.row]]
                 placeholderImage:placeholderImage
                          options:indexPath.row == 0 ? SDWebImageRefreshCached : 0
                          context:@{SDWebImageContextImageThumbnailPixelSize : @(CGSizeMake(180, 120))}
                         progress:nil
                        completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        SDWebImageCombinedOperation *operation = [imageView sd_imageLoadOperationForKey:imageView.sd_latestOperationKey];
        SDWebImageDownloadToken *token = operation.loaderOperation;
        if (@available(iOS 10.0, *)) {
            NSURLSessionTaskMetrics *metrics = token.metrics;
            if (metrics) {
                printf("Metrics: %s download in (%f) seconds\n", [imageURL.absoluteString cStringUsingEncoding:NSUTF8StringEncoding], metrics.taskInterval.duration);
            }
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *largeImageURLString = [self.objects[indexPath.row] stringByReplacingOccurrencesOfString:@"small" withString:@"source"];
    NSURL *largeImageURL = [NSURL URLWithString:largeImageURLString];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailViewController.imageURL = largeImageURL;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}

@end

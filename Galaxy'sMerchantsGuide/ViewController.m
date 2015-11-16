//
//  ViewController.m
//  Galaxy'sMerchantsGuide
//
//  Created by jsonmess on 15/11/11.
//  Copyright © 2015年 jsonmess. All rights reserved.
//

#import "ViewController.h"
#import "IntergalacticConversionRuleTool.h"
#import "IntergalacticConversionRule.h"
#import "fileContentObject.h"
#define screenBounds [UIScreen mainScreen].bounds

@interface ViewController ()<UIScrollViewDelegate,UITextViewDelegate>
//缓存输出结果
@property (nonatomic,strong) NSString * currentOutputStr;
//处理从文件中读取的内容
@property (nonatomic,strong) fileContentObject *fileObject;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputView;
@property (weak, nonatomic) IBOutlet UITextView *outputView;
@property (weak, nonatomic) IBOutlet UIButton *convertBtn;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UIButton *inputBtn;
@property (weak, nonatomic) IBOutlet UIButton *outPutBtn;
//开始转换
- (IBAction)beginToConvert:(id)sender;
//清除内容
- (IBAction)clearTheContent:(id)sender;
//从文件读取
- (IBAction)loadFromFile:(id)sender;
//输出到文件
- (IBAction)outputToFile:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    //默认执行文件中的命令
    [self loadFromFile:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initViews
{
    [self.outputView setEditable:NO];
    self.outputView.delegate = self;
    self.inputView.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  开始转换
 */
- (IBAction)beginToConvert:(id)sender
{
    self.currentOutputStr = @"";
    self.fileObject = [[fileContentObject alloc] init];
    //开始读取输入内容进行转换
    NSArray *sentencesArray = [self.inputView.text componentsSeparatedByString:@"\n"];
    for (NSString *sentence in sentencesArray) {
       NSLog(@"the text is \n%@",sentence);
        [self solveTheAnalysisSentence:sentence];
    }
}
/**
 *  清除内容
 */
- (IBAction)clearTheContent:(id)sender
{
   self.inputView.text = @"";
}
/**
 *  从文件读取
 */
- (IBAction)loadFromFile:(id)sender
{
    NSError * error = nil;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"sentences.txt" ofType:nil];
    NSString *sentencesStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    self.inputView.text = sentencesStr;
}
/**
 *  输出到文件
 */
- (IBAction)outputToFile:(id)sender
{
    NSError * error = nil;
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"outPutFile.txt"];
    [self.outputView.text writeToFile:path atomically:YES
                             encoding:NSUTF8StringEncoding
                                error:&error];
    NSString * alertStr = @"save to file success";
    if (error)
    {
       alertStr = @"save to file faild";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:alertStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
/**
 *  点击隐藏键盘
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.outputView resignFirstResponder];
    [self.inputView resignFirstResponder];
}

-(void)textViewDidChange:(UITextView *)textView
{}
/**
 *  用于滚动textView时候，隐藏键盘
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.outputView resignFirstResponder];
    [self.inputView resignFirstResponder];
}

-(void)setCurrentOutputStr:(NSString *)currentOutputStr
{
    _currentOutputStr = currentOutputStr;
    self.outputView.text = self.currentOutputStr;
}

/**
 *  处理单个句子
 *
 *  @param sentence 句子
 */
-(void)solveTheAnalysisSentence:(NSString *)sentence
{
    IntergalacticConversionRule *conversionRule = [[IntergalacticConversionRule alloc] init];
    //1.把句子按照空格拆分
    NSArray *wordsArray = [sentence componentsSeparatedByString:@" "];
    NSMutableArray *wordsMutableArray = [NSMutableArray arrayWithArray:wordsArray];
    for (NSString *word in wordsArray) {
        if ([word isEqualToString:@""] || [word isEqualToString:@" "])
        {
            [wordsMutableArray removeObject:word];
        }
    }
    if (wordsMutableArray.count <= 0)
    {
        return;
    }
    //单个单词，则直接是星际文字和数字之间的转换
    if (wordsMutableArray.count == 1)
    {
       //1.正则匹配是否为纯数字
        NSString * tmpStr = wordsMutableArray[0];
      BOOL isNumberStr =  [IntergalacticConvaersionRuleTool checkIsTheAvailableNumberStr:tmpStr];
        if (isNumberStr)
        {
           NSString *romanNumber = [conversionRule getRomanNumberWithArabicNumber:[tmpStr integerValue]];
            self.currentOutputStr = [NSString stringWithFormat:@"%@%@",self.currentOutputStr,romanNumber];
        }
        else
        {
            NSInteger number = [conversionRule getArabicNumberWithRomanNumber:tmpStr];
            NSString * outputStr = @"you input the wrong Galaxy word,please check.";
            if (number != -1)
            {
                outputStr = [NSString stringWithFormat:@"%ld",number];
            }
            self.currentOutputStr = [NSString stringWithFormat:@"%@%@",self.currentOutputStr,outputStr];
        }
    }
    else
    {
        //相关句子
        [self.fileObject AnalysisTheDescribeSentence:sentence];
        self.currentOutputStr = self.fileObject.resultStr;
    }
}

@end

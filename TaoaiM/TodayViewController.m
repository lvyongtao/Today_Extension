//
//  TodayViewController.m
//  Taoai_Mday
//
//  Created by lvyongtao on 16/7/27.
//  Copyright © 2016年 lvyongtao. All rights reserved.
//

#import "TodayViewController.h"
//#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *todayLable;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSDate *date=[NSDate date];
    NSDateFormatter *pickerFormatter=[[NSDateFormatter alloc] init];
    [pickerFormatter setDateFormat:@"MM-dd"];
    NSString *dateStr=[pickerFormatter stringFromDate:date];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
    NSMutableString *mutableDateStr = [NSMutableString stringWithString:dateStr];
    
    if ([[mutableDateStr substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"] ) {
        [mutableDateStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    NSArray *mutablearr = [mutableDateStr componentsSeparatedByString:@"月"];
    if (mutablearr.count) {
        if ([[mutablearr[1] substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
              [mutablearr[1] deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        mutableDateStr = [NSMutableString stringWithFormat:@"%@月%@",mutablearr[0],mutablearr[1]];
        
    }
    dateStr = [mutableDateStr copy];
    dateStr = [dateStr stringByAppendingString:@"日"];
    dateStr = [dateStr stringByAppendingString:[self returnWeekDay]];
    
    _todayLable.attributedText = [self setFontAndColorWithString1:dateStr withstring2:[self getChineseCalendarWithDate:[NSDate date]] withFont1:35 withFont2:18 withColor1:[UIColor blackColor] withColor2:[UIColor blackColor]];
    // Do any additional setup after loading the view from its nib.
}

- (NSMutableAttributedString *)setFontAndColorWithString1:(NSString *)str1 withstring2:(NSString *)str2  withFont1:(float)size1 withFont2:(float)size2 withColor1:(UIColor *)color1 withColor2:(UIColor *)color2
{
    
    NSString *sumStr = [NSString stringWithFormat:@"%@\n%@",str1,str2];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:sumStr];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size1] range:NSMakeRange(0, str1.length)];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size2] range:NSMakeRange(str1.length + 1, str2.length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, str1.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(str1.length + 1, str2.length )];
    
    
    return attributedStr;
    
}
- (NSString *)returnWeekDay
{
    NSDate *todaydate=[NSDate date];
    NSDateFormatter *pickerFormatter=[[NSDateFormatter alloc] init];
    [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:todaydate];
    NSArray *weeks = [NSArray arrayWithObjects:@" 星期日",@" 星期一",@" 星期二",@" 星期三",@" 星期四",@" 星期五",@" 星期六", nil];
    NSInteger week = [comps weekday];
    NSString *weekDayStr;
    switch (week) {
        case 1:
            weekDayStr =weeks[0];
            break;
        case 2:
            weekDayStr =weeks[1];
            break;
        case 3:
            weekDayStr =weeks[2];
            break;
        case 4:
            weekDayStr =weeks[3];
            break;
        case 5:
            weekDayStr =weeks[4];
            break;
        case 6:
            weekDayStr =weeks[5];
            break;
        case 7:
            weekDayStr =weeks[6];
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
}
- (NSString*)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@年%@%@",y_str,m_str,d_str];
    
    return chineseCal_str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

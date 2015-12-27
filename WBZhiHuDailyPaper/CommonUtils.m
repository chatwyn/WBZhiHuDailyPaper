
#import "CommonUtils.h"
#define kdefaultFont [UIFont systemFontOfSize:15.0f]
//无数据时的文字颜色
#define kNoDataTitleColor      kColor(160,160,160,1)
#define kBackGrayColor         kColor(221,221,221,1)
//无数据时的文字大小
#define kNoDataTitleSize 18
@implementation CommonUtils


+ (UILabel*)createLabelWithText:(NSString*)string frame:(CGRect)frame {
    UILabel *result = [[UILabel alloc] initWithFrame:frame];
    result.numberOfLines = 0;
    result.backgroundColor = [UIColor clearColor];
    result.textColor = [UIColor whiteColor];
    result.text = string;
    result.font = kdefaultFont;
    
    return result ;
}

+ (UITextView*)createTextViewWithText:(NSString*)string frame:(CGRect)frame {
    UITextView *result = [[UITextView alloc] initWithFrame:frame];
    result.text = string;
    result.backgroundColor = [UIColor clearColor];
    result.textColor = [UIColor whiteColor];
    result.font = kdefaultFont;
    
    return result;
}

+ (UITextField*)createTextFieldWithText:(NSString*)string frame:(CGRect)frame {
    UITextField *result = [[UITextField alloc] initWithFrame:frame];
    result.text = string;
    result.backgroundColor = [UIColor clearColor];
    result.textColor = [UIColor whiteColor];
    result.font = kdefaultFont;
    
    return result;
}

+ (UIButton*)createButtonWithText:(NSString*)string frame:(CGRect)frame {
    UIButton *result = [UIButton buttonWithType:UIButtonTypeCustom];
    [result setFrame:frame];
    [result setTitle: string forState:UIControlStateNormal];
    result.backgroundColor = [UIColor clearColor];
    [result setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return result;
}

 @end

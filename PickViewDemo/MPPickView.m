//
//  MPPickView.m
//  PickViewDemo
//
//  Created by 金汕汕 on 16/12/3.
//  Copyright © 2016年 ccs. All rights reserved.
//



#import "MPPickView.h"

#define textLabelColor  [UIColor redColor]
#define textSizeColor  16.0

@interface MPPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *mpPickView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger selectedRow;
//记录数据内部元素类型
@property (assign, nonatomic) Evetype type;
@property (strong, nonatomic) NSMutableArray *selectArray;
@end

@implementation MPPickView

+ (MPPickView *)instanceMPPickView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"MPPickView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

/**
 *  判断是否    所有元素都是数组
 *
 *  @param arr    要判断的数组
 *
 *  @return 返回判断结果
 */
- (BOOL)kWeatherArrayEve:(id)sender isArray:(NSMutableArray *)arr{
    for (int i = 0 ; i < arr.count; i++) {
        if (![_dataArray[i] isKindOfClass:[NSArray class]]) {
            NSLog(@"isArray－－数组内元素类型不统一");
            return NO;
        }
    }
    return YES;
}

- (BOOL)kWeatherArrayEve:(id)sender isNSString:(NSMutableArray *)arr{
    for (int i = 0 ; i < arr.count; i++) {
        if (![_dataArray[i] isKindOfClass:[NSString class]]) {
            NSLog(@"isNSString－－数组内元素类型不统一");
            return NO;
        }
    }
    return YES;
}



- (void)createView:(NSMutableArray *)datas{
    _dataArray = datas;
    _mpPickView.delegate = self;
    _mpPickView.dataSource = self;
}



#pragma mark- 设置数据
//一共多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (![self kWeatherArrayEve:self isArray:_dataArray] && ![self kWeatherArrayEve:self isNSString:_dataArray]) {
        return 0;
    }
    if ([_dataArray[0] isKindOfClass:[NSArray class]]) {
        _type = EvetypeOfNSArray;
        return _dataArray.count;
    }else if ([_dataArray[0] isKindOfClass:[NSString class]]){
        _type = EvetypeOfNSString;
        return 1;
    }else{
        _type = EvetypeOfError;
        return 0;
    }
}

//每列对应多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component <= (_dataArray.count-1)) {
        if (_type == EvetypeOfNSArray) {
            NSMutableArray *arr = _dataArray[component];
            return arr.count;
        }else{
            return _dataArray.count;
        }
        
    }else{
        return 0;
    }
}

//每列每行对应显示的数据是什么
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_type == EvetypeOfNSArray) {
        NSMutableArray *arr = _dataArray[component];
        NSString *name=arr[row];
        return name;
    }else{
        return _dataArray[row];
    }
}

////自定义view
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
//          forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *mycom1 = view ? (UILabel *) view : [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 20.0f)];
//    
//    NSMutableArray *arr = _dataArray[component];
//    NSString *imgstr1 = [arr objectAtIndex:row];
//    mycom1.text = imgstr1;
//    [mycom1 setFont:[UIFont systemFontOfSize: textSizeColor]];
//    mycom1.backgroundColor = [UIColor clearColor];
//    mycom1.textColor = textLabelColor;
//    mycom1.textAlignment = NSTextAlignmentCenter;
//    CFShow((__bridge CFTypeRef)(mycom1));
//    
//    return mycom1;
//}


#pragma mark-设置下方的数据刷新
// 当选中了pickerView的某一行的时候调用
// 会将选中的列号和行号作为参数传入
// 只有通过手指选中某一行的时候才会调用
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_type == EvetypeOfNSArray) {
        self.selectArray [component] = [NSString stringWithFormat:@"%ld",row];
    }else if (_type == EvetypeOfNSString) {
        _selectedRow =row;
    }
}

#pragma mark-隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}




- (IBAction)sureButtonClick:(id)sender {
    if (_type == EvetypeOfNSArray) {
        NSMutableArray *selectedArray = [NSMutableArray new];
        for (int i = 0 ; i < _dataArray.count; i++) {
            NSMutableArray *linShiArray = _dataArray[i];
            NSInteger selectRow = [self.selectArray[i] integerValue];
            [selectedArray addObject:linShiArray[selectRow ]];
        }
        _returnArrayBlock(selectedArray);
        
    }else{
        _returnTextBlock(_dataArray[_selectedRow]);
    }
}

- (IBAction)cancelButtonClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.alpha = 1;
        self.hidden = YES;
    }];
    
}




-(NSMutableArray *)selectArray{
    self.hidden = YES;
    if (!_selectArray) {
        _selectArray = [NSMutableArray new];
        for (int i = 0 ; i < _dataArray.count; i++) {
            [_selectArray addObject:@"0"];
        }
    }
    return _selectArray;
}

@end

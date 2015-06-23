//
//  ViewController.m
//  ObjectiveCTourScreens
//
//  Created by Vania Kurniawati on 6/23/15.
//  Copyright (c) 2015 vivavania. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) UIPageControl *dots;
@property (assign) CGRect screen;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //backgroundcolor input
  [self.view setBackgroundColor:[UIColor colorWithRed:52/255.0 green:73/255.0 blue:94/255.0 alpha:1.0]];
  //slides input
  NSArray *slides = @[
                      @{ @"image" : @"finances.png", @"text" : @"Having problems with your finances?"},
                      @{ @"image" : @"brunch.jpg", @"text" : @"Maybe you should stop going to boozy brunches!"},
                      @{ @"image" : @"firstdate.jpg", @"text" : @"And buy those giant wine bottles at Costco instead of going to happy hour at bougie wine bars"}
                      ];
  
  self.screen = [UIScreen mainScreen].bounds;
  self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.screen.size.width, self.screen.size.height * 0.9)];
  self.scroll.showsHorizontalScrollIndicator = NO;
  self.scroll.showsVerticalScrollIndicator = NO;
  self.scroll.pagingEnabled = YES;
  [self.view addSubview:self.scroll];
  
  if (slides.count > 1) {
    self.dots = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0, self.screen.size.height * 0.9, self.screen.size.width, self.screen.size.height * 0.05)];
    self.dots.numberOfPages = slides.count;
    [self.view addSubview:self.dots];
  }
  
  for (int i = 0; i < slides.count; i++) {
    UIImage *image = [UIImage imageNamed:slides[i][@"image"]];
    UIImageView *imageView = [[UIImageView alloc] init];
    
    
    imageView.frame = [self getFrame:image.size.width andiH:image.size.height andSlide:i andOffset:self.screen.size.height * 0.15];
    
    imageView.image = image;
    [self.scroll addSubview:imageView];
    
    NSString *text = slides[i][@"text"];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(self.screen.size.width * 0.1 + (CGFloat)i * self.screen.size.width, self.screen.size.height * 0.75, self.screen.size.width * 0.8, 100.0)];
    textView.text = text;
    textView.editable = NO;
    textView.selectable = NO;
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
    textView.textColor = [UIColor whiteColor];
    textView.backgroundColor = [UIColor clearColor];
    [self.scroll addSubview:textView];
  }
  
  self.scroll.contentSize = CGSizeMake((CGFloat)((int)self.screen.size.width * slides.count), self.screen.size.height * 0.5);
  self.scroll.delegate = self;
  [self.dots addTarget:self action:@selector(swipe:) forControlEvents:UIControlEventValueChanged];
  
}

- (CGRect)getFrame:(CGFloat)iW andiH:(CGFloat)iH andSlide:(int)slide andOffset:(CGFloat)offset {
  CGFloat mH = self.screen.size.height * 0.50;
  CGFloat mW = self.screen.size.width;
  CGFloat r = iW/iH;
  CGFloat h = 0;
  CGFloat w = 0;
  if (r <= 1) {
    h = MIN(mH, iH);
    w = h * r;
  } else {
    w = MIN(mW, iW);
    h = w / r;
  }
  return CGRectMake(MAX(0, (mW - w)/2 + (CGFloat)slide * self.screen.size.width), MAX(0, (mH - h)/2 + offset), w, h);
}

- (void)swipe:(id)sender {
  UIScrollView *scrollView = self.scroll;
  CGFloat x = (CGFloat)self.dots.currentPage * scrollView.frame.size.width;
  [self.scroll setContentOffset:CGPointMake(x, 0) animated:YES];
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  float pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width);
  self.dots.currentPage = (int)pageNumber;
}

- (BOOL)prefersStatusBarHidden {
  [super prefersStatusBarHidden];
  return YES;
}


@end

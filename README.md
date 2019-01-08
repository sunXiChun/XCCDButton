# XCCDButton

简单的带有冷却时间的按钮

用法：

```

v = [[XCCDButton alloc] initWithFrame:(CGRectMake(100, 100, 100, 100))
                                  bgImage:[UIImage imageNamed:@"button_bg"]
                                maskImage:[UIImage imageNamed:@"button_shadow"]
                                 duration:3];
    [self.view addSubview:v];
    
```

效果：

![avatar](https://github.com/sunXiChun/XCCDButton/blob/master/XCCDButton.gif)
//
//  UIButton+setHighlighted.m
//  Task 6
//
//  Created by Антон Потапчик on 6/20/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

#import "UIButton+setHighlighted.h"
#import "UIColor+HexString.h"


@implementation UIButton (setHighlighted)

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.backgroundColor = [UIColor appYellowHighlightedColor];
    } else {
        self.backgroundColor = [UIColor appYellowColor];
    }
}
@end

//
//  Book+TableRepresentation.h
//  iOS-Design-Patterns
//
//  Created by Crazyfree on 12/12/15.
//  Copyright © 2015 Crazyfree. All rights reserved.
//

#import "Book.h"

@interface Book (TableRepresentation)

- (NSDictionary*)tr_tableRepresentation;

@end

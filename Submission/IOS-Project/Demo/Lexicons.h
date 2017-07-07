//
//  Lexicons.h
//  Demo
//
//  Created by acp16w on 06/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lexicons : NSObject

-(id)initWithPositiveLexiconFile:(NSString*)pos negativeLexiconFile:(NSString*)neg withNegationWords:(NSString*)negationWordsPath withPresup:(NSString*)preSupWords;

@property (strong) NSSet* positiveLexicons;
@property (strong) NSSet* negativeLexicons;
@property (strong) NSSet* negationWords;
@property (strong) NSSet* generalShifters;

@end

//
//  Lexicons.m
//  Demo
//
//  Created by acp16w on 06/12/2016.
//  Copyright © 2016 Will. All rights reserved.
//

#import "Lexicons.h"

@implementation Lexicons

-(id)initWithPositiveLexiconFile:(NSString *)pos negativeLexiconFile:(NSString *)neg withNegationWords:(NSString *)negationWordsPath withPresup:(NSString *)preSupWords{
    self = [super init];
    
    if(self){
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //We're only loading from file dealing with file parsing at this point, therefore ignore deprecated frameworks
        NSString *posWordsPath = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                     pathForResource:pos ofType:@"txt"]];
        
        NSArray *arrayPos = [posWordsPath componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        
        NSString *negWordsPath = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                     pathForResource:neg ofType:@"txt"]];
        
        NSArray *arrayNeg = [negWordsPath componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        
        NSString *negationWords = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                     pathForResource:negationWordsPath ofType:@"txt"]];
        
        NSArray *arrayNegation = [negationWords componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        
        
        NSString *presupWords = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                      pathForResource:preSupWords ofType:@"txt"]];
        
        
        NSArray *arrayPresup = [presupWords componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        #pragma clang diagnostic pop
        
        self.positiveLexicons = [[NSSet alloc]initWithArray:arrayPos];
        self.negativeLexicons = [[NSSet alloc]initWithArray:arrayNeg];
        self.negationWords = [[NSSet alloc]initWithArray:arrayNegation];
        self.generalShifters = [[NSSet alloc]initWithArray:arrayPresup];
        
    }
    
    return self;
}


@end

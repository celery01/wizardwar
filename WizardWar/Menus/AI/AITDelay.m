//
//  AITacticDelay.m
//  WizardWar
//
//  Created by Sean Hess on 8/25/13.
//  Copyright (c) 2013 Orbital Labs. All rights reserved.
//

#import "AITDelay.h"
#import "Spell.h"
#import "NSArray+Functional.h"

@implementation AITDelay

-(AIAction*)suggestedAction:(AIGameState *)game {
    
    AIAction * action;
    
    if (!game.isCooldown) {
        NSString * randomType = [self.spells randomItem];
        Spell * spell = [Spell fromType:randomType];
        
        if (self.delay)
            action = [AIAction spell:spell time:self.delay];
        else
            action = [AIAction spell:spell];
    }
    
    return action;
}


+(id)random:(NSArray*)spells delay:(NSTimeInterval)delay {
    AITDelay * tactic = [AITDelay new];
    tactic.spells = spells;
    tactic.delay = delay;
    return tactic;
}

+(id)random:(NSArray*)spells {
    AITDelay * tactic = [AITDelay new];
    tactic.spells = spells;
    return tactic;
}

@end

//
//  AIGameState.m
//  WizardWar
//
//  Created by Sean Hess on 8/24/13.
//  Copyright (c) 2013 Orbital Labs. All rights reserved.
//

#import "AIGameState.h"
#import "NSArray+Functional.h"

@implementation AIGameState

-(NSTimeInterval)timeSinceLastCast {
    return (self.currentTick - self.lastSpellCast.createdTick) * self.interval;
}

-(BOOL)isCooldown {
    return (self.lastSpellCast && self.timeSinceLastCast < self.lastTimeRequired);
}

-(NSArray*)mySpells {
    return [self.spells filter:^BOOL(Spell*spell) {
        return (spell.creator == self.wizard);
    }];
}

-(NSArray*)opponentSpells {
    return [self.spells filter:^BOOL(Spell*spell) {
        return (spell.creator == self.opponent);
    }];
}

-(Spell *)activeWall {
    return [self.mySpells find:^BOOL(Spell*spell) {
        return spell.isWall;
    }];
}


-(NSArray*)sortSpellsByDistance:(NSArray*)spells {
    return [spells sortedArrayUsingComparator:^NSComparisonResult(Spell* spell1, Spell* spell2) {
        float distance1 = [spell1 distance:self.wizard];
        float distance2 = [spell2 distance:self.wizard];
        if (distance1 < distance2) return NSOrderedDescending;
        else if (distance1 > distance1) return NSOrderedAscending;
        else return NSOrderedSame;
    }];
}


@end
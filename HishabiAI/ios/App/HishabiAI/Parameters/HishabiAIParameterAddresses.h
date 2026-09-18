//
//  HishabiAIParameterAddresses.h
//  HishabiAI
//
//  Created by Md. Nahidul Islam on 18/9/26.
//

#pragma once

#include <AudioToolbox/AUParameters.h>

typedef NS_ENUM(AUParameterAddress, HishabiAIParameterAddress) {
    sendNote = 0,
    midiNoteNumber = 1
};

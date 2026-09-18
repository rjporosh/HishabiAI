//
//  HishabiAIMainView.swift
//  HishabiAI
//
//  Created by Md. Nahidul Islam on 18/9/26.
//

import SwiftUI

struct HishabiAIMainView: View {
    var parameterTree: ObservableAUParameterGroup
    
    var body: some View {
        VStack {
            ParameterSlider(param: parameterTree.global.midiNoteNumber)
                .padding()
            MomentaryButton(
                "Play note",
                param: parameterTree.global.sendNote
            )
        }
    }
}

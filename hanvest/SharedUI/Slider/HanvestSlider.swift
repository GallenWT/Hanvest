//
//  HanvestSlider.swift
//  hanvest
//
//  Created by Benedick Wijayaputra on 11/10/24.
//

import SwiftUI

struct HanvestSlider: View {
    @Binding var value: Int
    var minimum: Int
    var maximum: Int
    
    func calculateProgressPercentage() -> CGFloat {
        guard maximum > minimum else { return 0 }
        
        let percentage = CGFloat(value - minimum) / CGFloat(maximum - minimum)
        return min(max(percentage, 0), 1)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(height: 8)
                        .foregroundStyle(.fillSecondary)
                    
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: geometry.size.width * calculateProgressPercentage() , height: 8)
                        .foregroundStyle(.seagull400)
                    
                    Circle()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.seagull100)
                        .position(x: geometry.size.width * calculateProgressPercentage(), y: 14)
                        .gesture(DragGesture()
                            .onChanged { value in
                                let dragPercentage = value.location.x / geometry.size.width
                                let newValue = Int(dragPercentage * CGFloat(maximum - minimum)) + minimum
                                self.value = min(max(newValue, minimum), maximum)
                            }
                        )
                }
            }
        }
        .frame(height: 28)
    }
}

#Preview {
    @Previewable @State var value: Int = 50
    HanvestCardBackground {
        HanvestSlider(value: $value, minimum: 0, maximum: 100)
            .padding(24)
        
        Text("Value: \(Int(value))")
    }
}

//
//  RadarChartView.swift
//  GoonAi
//
//  Radar chart for 6 dimensions
//

import SwiftUI

struct RadarChartView: View {
    let dimensions: [DimensionStat]
    let selectedDimension: DimensionType?
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.8
            
            ZStack {
                // Background rings
                ForEach([0.2, 0.4, 0.6, 0.8, 1.0], id: \.self) { scale in
                    RadarPolygonShape(sides: 6, scale: scale)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .frame(width: radius * 2, height: radius * 2)
                }
                
                // Data polygon
                RadarDataShape(values: dimensions.map { $0.value })
                    .fill(
                        LinearGradient(
                            colors: [Color.cyan.opacity(0.3), Color.green.opacity(0.2)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: radius * 2, height: radius * 2)
                
                RadarDataShape(values: dimensions.map { $0.value })
                    .stroke(Color.cyan, lineWidth: 2)
                    .frame(width: radius * 2, height: radius * 2)
                
                // Dimension labels
                ForEach(Array(dimensions.enumerated()), id: \.element.id) { index, dimension in
                    let angle = Double(index) * (360.0 / Double(dimensions.count)) - 90
                    let labelRadius = radius + 30
                    let x = center.x + cos(angle * .pi / 180) * labelRadius
                    let y = center.y + sin(angle * .pi / 180) * labelRadius
                    
                    Text(dimension.type.rawValue)
                        .font(.caption)
                        .fontWeight(selectedDimension == dimension.type ? .bold : .regular)
                        .foregroundColor(selectedDimension == dimension.type ? .cyan : .white.opacity(0.7))
                        .position(x: x, y: y)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// MARK: - Radar Polygon Shape

struct RadarPolygonShape: Shape {
    let sides: Int
    let scale: Double
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 * scale
        
        var path = Path()
        
        for i in 0..<sides {
            let angle = Double(i) * (360.0 / Double(sides)) - 90
            let x = center.x + cos(angle * .pi / 180) * radius
            let y = center.y + sin(angle * .pi / 180) * radius
            
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Radar Data Shape

struct RadarDataShape: Shape {
    let values: [Double] // 0.0 to 1.0 for each dimension
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        var path = Path()
        
        for (index, value) in values.enumerated() {
            let angle = Double(index) * (360.0 / Double(values.count)) - 90
            let distance = radius * value
            let x = center.x + cos(angle * .pi / 180) * distance
            let y = center.y + sin(angle * .pi / 180) * distance
            
            if index == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Recovery Radar Card

struct RecoveryRadarCard: View {
    let dimensions: [DimensionStat]
    let selectedDimension: DimensionType?
    
    var body: some View {
        VStack(spacing: 0) {
            if let selected = selectedDimension {
                Text(selected.rawValue)
                    .font(.headline)
                    .foregroundColor(.cyan)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
            }
            
            RadarChartView(dimensions: dimensions, selectedDimension: selectedDimension)
                .frame(height: 280)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .glassEffect()
        .padding(.horizontal)
    }
}


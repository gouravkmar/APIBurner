import SwiftUI

// Main ResultView
struct ResultView: View {
    @ObservedObject var viewModel: ResultViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                titleView
                ResultHeaderView(viewModel: viewModel)
                TimeStats(viewModel: viewModel)
                
                // Simple bar chart for latency
                LatencyGraphView(viewModel: viewModel)
                    .padding(.top, 20)
            }
        }
        .padding()
        .background(
            VisualEffectBlur(style: .systemMaterialDark)
                .cornerRadius(20)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.05)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .cornerRadius(20)
                    .blur(radius: 5)
                )
        )
        .cornerRadius(20)
        .shadow(radius: 10)
    }

    var titleView: some View {
        Text("Test Results")
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .padding(.top, 20)
    }
}

// Header View displaying success and failure counts
struct ResultHeaderView: View {
    @ObservedObject var viewModel: ResultViewModel
    
    var body: some View {
        VStack {
            Text("Sent").foregroundColor(.white)
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(.green)
                    .frame(width: 12, height: 12)
                Text("Success").foregroundColor(.white)
                Spacer()
                Text("\(viewModel.successCount)").foregroundColor(.white)
            }
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(.red)
                    .frame(width: 12, height: 12)
                Text("Failure").foregroundColor(.white)
                Spacer()
                Text("\(viewModel.failureCount)").foregroundColor(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .stroke(Color.mint, lineWidth: 1)
                .background(
                    VisualEffectBlur(style: .systemMaterialDark)
                        .cornerRadius(10)
                )
        )
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Time stats for response times (Min, Max, Avg)
struct TimeStats: View {
    @ObservedObject var viewModel: ResultViewModel
    
    var body: some View {
        VStack {
            Text("Response Time (ms)")
                .font(.headline)
                .foregroundColor(.white)
            
            HStack {
                Text("Min")
                    .foregroundColor(.white)
                Spacer()
                Text("\(viewModel.minResTime)")
                    .foregroundColor(.white)
            }
            HStack {
                Text("Max")
                    .foregroundColor(.white)
                Spacer()
                Text("\(viewModel.maxResTime)")
                    .foregroundColor(.white)
            }
            HStack {
                Text("Avg")
                    .foregroundColor(.white)
                Spacer()
                Text("\(viewModel.avgResTime)")
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .stroke(Color.mint, lineWidth: 1)
                .background(
                    VisualEffectBlur(style: .systemMaterialDark)
                        .cornerRadius(10)
                )
        )
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

import Charts

// Updated LatencyGraphView using Line Chart
struct LatencyGraphView: View {
    @ObservedObject var viewModel: ResultViewModel

    var body: some View {
        VStack {
            Text("API Response Latency")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 20)

            Chart {
                ForEach(viewModel.testResults.indices, id: \.self) { index in
                    let result = viewModel.testResults[index]
                    
                    LineMark(
                        x: .value("Request", index),
                        y: .value("Latency (ms)", result.responseTime)
                    )
                    .interpolationMethod(.catmullRom) // Makes the line smooth
                    .foregroundStyle(result.isSuccess ? Color.green : Color.red)
                    .symbol(Circle()) // Optional dots
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisGridLine().foregroundStyle(.clear) // Hide grid
                    AxisTick().foregroundStyle(.white.opacity(0.5))
                    AxisValueLabel()
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.caption2)
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisGridLine().foregroundStyle(.white.opacity(0.1))
                    AxisTick().foregroundStyle(.white.opacity(0.5))
                    AxisValueLabel()
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.caption2)
                }
            }
            .frame(height: 200)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.mint, lineWidth: 1)
                    .background(
                        VisualEffectBlur(style: .systemMaterialDark)
                            .cornerRadius(10)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.05)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .cornerRadius(10)
                                .blur(radius: 3)
                            )
                    )
            )
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}


#Preview {
    ResultView(viewModel: ResultViewModel(requestData: RequestDataModel(
        urlString: "",
        requestMethod: .get,
        numberOfRequests: 1,
        batchSize: 1,
        requestInterval: 1,
        useURlComponents: true,
        queryParams: [],
        headerParams: [],
        usesURLComponents: false
    ), uuid: UUID()))
}

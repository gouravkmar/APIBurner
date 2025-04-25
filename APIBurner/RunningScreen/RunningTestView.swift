//
//  RunningTestView.swift
//  APIBurner
//
//  Created by Gourav Kumar on 26/04/25.
//

import SwiftUI

struct RunningTestView: View {
    @ObservedObject var viewModel : ResultViewModel
    @State var isResultPresent : Bool = false
    var body: some View {
        VStack{
            ZStack {
                // Background circle (inactive part)
                Circle()
                    .stroke(lineWidth: 20)
                    .foregroundColor(.gray.opacity(0.3))
                
                // Foreground circle (progress part)
                Circle()
                    .trim(from: 0,to: min(CGFloat(viewModel.totalRunningCount / viewModel.totalCount),1.0))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90)) // Rotate to start at the top
                    .animation(
                        .easeInOut,
                        value: viewModel.totalCount
                    )
            }
            .frame(width: 200, height: 200)
            .padding()
            Text("Running Tests").font(.title).fontWeight(.heavy)
            ResultHeaderView()
            
        }.padding(25)
            .sheet(isPresented: $isResultPresent,content: {
                ResultView(viewModel: viewModel)
            })
            .onChange(of: viewModel.totalRunningCount, {
                if viewModel.totalRunningCount == viewModel.totalCount {
                    
                }
            })
    }
}

#Preview {
    RunningTestView(viewModel: ResultViewModel(requestData: RequestDataModel(
        urlString: "",
        requestMethod: .get,
    numberOfRequests:1,
        batchSize: 1,
        requestInterval: 1,
        useURlComponents: true,
        queryParams: [],
        headerParams: []
    )))
}

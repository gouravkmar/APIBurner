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
                    .trim(from: 0,to: min(CGFloat(viewModel.totalRunningCount) / CGFloat(viewModel.totalCount),1.0))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90)) // Rotate to start at the top
                    .animation(
                        .easeInOut,
                        value: viewModel.totalRunningCount
                    )
            }
            .frame(width: 200, height: 200)
            .padding()
            Text("Running Tests").font(.title).fontWeight(.heavy)
            ResultHeaderView(viewModel: viewModel)
            if viewModel.totalCount == viewModel.totalRunningCount {
                showResultButton
            }
            
            
        }.padding(25)
            .sheet(isPresented: $viewModel.shouldPresent,content: {
                ResultView(viewModel: viewModel)
            })
        
    }
    var showResultButton : some View {
        Button {
            viewModel.shouldPresent = true
        } label: {
            Text("Show Results")
                .font(.headline)
                .padding()
                .background(Color.blue)
                .foregroundStyle(.white)
            
        }

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
        headerParams: [], usesURLComponents: true
    )))
}


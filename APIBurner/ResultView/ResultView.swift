//
//  ResultView.swift
//  APIBurner
//
//  Created by Gourav Kumar on 26/04/25.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: ResultViewModel
    var body: some View {
        ScrollView{
            VStack(spacing : 20){
                titleView
                ResultHeaderView(viewModel: viewModel)
                TimeStats(viewModel: viewModel)
            }
        }.padding()
    }
    var titleView : some View {
        return Text("Test Results").font(.title).fontWeight(.heavy)
    }
}

#Preview {
    ResultView(
        viewModel: ResultViewModel(
            requestData: RequestDataModel(
                urlString: "",
                requestMethod: .get,
            numberOfRequests:1,
                batchSize: 1,
                requestInterval: 1,
                useURlComponents: true,
                queryParams: [],
                headerParams: [], usesURLComponents: false
            )
        )
    )
}
struct ResultHeaderView : View {
    @ObservedObject var viewModel : ResultViewModel
    var body: some View {
        VStack{
            Text("Sent")
            HStack{
                Image(systemName: "circle.fill")
                    .foregroundColor(.green)
                    .frame(width: 12, height: 12)
                Text("Success")
                Spacer()
                Text("\(viewModel.successCount)")
            }
            HStack{
                Image(systemName: "circle.fill")
                    .foregroundColor(.red)
                    .frame(width: 12, height: 12)
                Text("Failure")
                Spacer()
                Text("\(viewModel.failureCount)")
            }
        }.padding()
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.mint,lineWidth: 1)
            )
            
    }
}
struct TimeStats : View {
    @ObservedObject var viewModel : ResultViewModel
    var body: some View {
        VStack{
            Text("Response Time(ms)")
            HStack{
                Text("Min")
                Spacer()
                Text("\(viewModel.minResTime)")
            }
            HStack{
                Text("Max")
                Spacer()
                Text("\(viewModel.maxResTime)")
            }
            HStack{
                Text("Avg")
                Spacer()
                Text("\(viewModel.avgResTime)")
            }
        }.padding()
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.mint,lineWidth: 1)
            )
    }
}


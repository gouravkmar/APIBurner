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
                ResultHeaderView()
                TimeStats()
            }
        }.padding()
    }
    var titleView : some View {
        return Text("Test Results").font(.title).fontWeight(.heavy)
    }
}

#Preview {
    ResultView(viewModel: ResultViewModel())
}
struct ResultHeaderView : View {
    var body: some View {
        VStack{
            Text("Sent")
            HStack{
                Image(systemName: "circle.fill")
                    .foregroundColor(.green)
                    .frame(width: 12, height: 12)
                Text("Success")
                Spacer()
                Text("20")
            }
            HStack{
                Image(systemName: "circle.fill")
                    .foregroundColor(.red)
                    .frame(width: 12, height: 12)
                Text("Failure")
                Spacer()
                Text("20")
            }
        }.padding()
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.mint,lineWidth: 1)
            )
            
    }
}
struct TimeStats : View {
    var body: some View {
        VStack{
            Text("Response Time(ms)")
            HStack{
                Text("Min")
                Spacer()
                Text("150")
            }
            HStack{
                Text("Max")
                Spacer()
                Text("150")
            }
            HStack{
                Text("Avg")
                Spacer()
                Text("150")
            }
        }.padding()
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .stroke(Color.mint,lineWidth: 1)
            )
    }
}


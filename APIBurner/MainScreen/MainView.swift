//
//  MainView.swift
//  APIBurner
//
//  Created by Gourav Kumar on 25/04/25.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mainViewModel : MainViewModel
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(spacing: 25){
                    mainTitle
                    UseStructuredURLSwitch(useURLComponents: $mainViewModel.useURlComponents)
                    URLField(urlString: $mainViewModel.urlString)
                    if mainViewModel.useURlComponents{
                        QueryView(queryParams: $mainViewModel.queryParams)
                    }
                    HeaderView(headerParams: $mainViewModel.headerParams)
                    RequestField(method: $mainViewModel.requestMethod)
                    NumberRequestsPicker(numberOfRequests: $mainViewModel.numberOfRequests)
                    BatchSizePicker(batchSize: $mainViewModel.batchSize)
                    IntervalPicker(interval: $mainViewModel.requestInterval)
                    NavigationLink(destination: RunningTestView(viewModel: ResultViewModel()), label: {
                        StartButton
                    }
                    )
                    
                }.padding(40)
                
            }
        }
    }
    var mainTitle : some View {
        Text("Test Configuration")
            .font(.title)
            .fontWeight(.bold)
    }
    var StartButton : some View{
        Text("Start Test")
            .frame(width: 150, height: 50)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 50, height: 50)))
            .foregroundStyle(Color.white)
    }
}

#Preview {
    MainView(mainViewModel: MainViewModel())
}

struct URLField : View {
    @Binding var urlString : String
    var body: some View{
        VStack{
            HStack{
                Text("URL")
                Spacer()
            }
            TextField(" url", text: $urlString)
                .frame(height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}
struct RequestField : View {
    @Binding var method : RequestMethod
    var body: some View {
        HStack {
            Text("Method")
            Spacer()
            Picker("Method", selection: $method, content: {
                ForEach(RequestMethod.allCases, content: { method in
                    Text("\(method.id)").tag(method)
                })
            }).pickerStyle(.menu)
                .background(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
    
}
struct UseStructuredURLSwitch : View {
    @Binding var useURLComponents : Bool
    var body: some View {
        HStack{
            Text("Use Structured URL")
            Toggle("", isOn: $useURLComponents)
        }
    }
}
struct NumberRequestsPicker : View {
    @Binding var numberOfRequests : Int
    var body: some View {
        HStack{
            Text("Number of requests")
            Spacer()
            Picker("Number of requests", selection: $numberOfRequests, content: {
                ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { num in
                    Text("\(num)")
                }
                
                
            })
        }
    }
}
struct BatchSizePicker : View {
    @Binding var batchSize : Int
    var body: some View {
        HStack{
            Text("Batch Size")
            Spacer()
            Picker("Batch Size", selection: $batchSize, content: {
                ForEach(1...10, id: \.self, content: { num in
                    Text("\(num)").tag(num)
                })
                
            })
        }
    }
}
struct IntervalPicker : View {
    @Binding var interval : Int
    var body: some View {
        HStack{
            Text("Request Interval (sec)")
            Spacer()
            Picker("Request Interval", selection: $interval, content: {
                ForEach(0...5, id: \.self, content: { num in
                    Text("\(num)")
                })
            })
        }
    }
}

struct ParamsField : View {
    @Binding var keyValuePair : KeyValPair
    var body: some View{
        HStack{
            TextField("Key",text: $keyValuePair.key)
                .border(.gray)
            Spacer()
            TextField("Value",text: $keyValuePair.value)
                .border(.gray)
            
            
        }
    }
}
struct QueryView : View {
    @Binding var queryParams : [KeyValPair]
    var body: some View{
        VStack(alignment: .leading) {
            Text("Add Query Params")
            ForEach($queryParams) { $query in
                ParamsField(keyValuePair: $query)
            }
            Button {
                queryParams.append(KeyValPair(key: "", value: "" ))
            } label: {
                HStack(alignment: .center){
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                }.frame(maxWidth: .infinity)
            }
            
        }
    }
}

struct HeaderView : View {
    @Binding var headerParams : [KeyValPair]
    var body: some View{
        VStack(alignment: .leading) {
            Text("Add Header Params")
            ForEach($headerParams) { $query in
                ParamsField(keyValuePair: $query)
            }
            Button {
                headerParams.append(KeyValPair(key: "", value: "" ))
            } label: {
                HStack(alignment: .center){
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                }.frame(maxWidth: .infinity)
            }
            
        }
    }
}

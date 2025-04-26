import SwiftUI

struct VisualEffectBlur: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return effectView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isNavigationActive = false
    @State private var resultViewModel: ResultViewModel? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    mainTitle
                    UseStructuredURLSwitch(useURLComponents: $viewModel.useURlComponents)
                    URLField(isEndpoint: $viewModel.useURlComponents, urlString: $viewModel.urlString)
                    if viewModel.useURlComponents {
                        QueryView(queryParams: $viewModel.queryParams)
                    }
                    HeaderView(headerParams: $viewModel.headerParams)
                    RequestField(method: $viewModel.requestMethod)
                    NumberRequestsPicker(numberOfRequests: $viewModel.numberOfRequests)
                    BatchSizePicker(batchSize: $viewModel.batchSize)
                    IntervalPicker(interval: $viewModel.requestInterval)
                    
                    NavigationLink(
                        destination: Group {
                            if let viewModel = resultViewModel {
                                RunningTestView(viewModel: viewModel)
                            }
                        },
                        isActive: $isNavigationActive,
                        label: {
                            StartButton
                                .onTapGesture {
                                    resultViewModel = ResultViewModel(requestData: viewModel.toRequestDataModel(), uuid: UUID())
                                    isNavigationActive = true
                                }.onChange(of: isNavigationActive, {
                                    if !isNavigationActive {
                                        resultViewModel?.cancelAllRequests()
                                    }
                                })
                        }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                .background(
                    VisualEffectBlur(style: .systemMaterialDark)
                        .cornerRadius(20)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.1)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(20)
                            .blur(radius: 5)
                        )
                )
                .cornerRadius(20) // Rounded corners for ScrollView content
                .shadow(radius: 10)
            }
            .background(Color.white) // White background for ScrollView
            .cornerRadius(20)
            .ignoresSafeArea() // Make content ignore the safe area (including the navigation bar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Remove custom toolbar item and let default behavior handle navigation items
                ToolbarItem(placement: .navigationBarLeading) {
                    // Custom button or other content can go here
                    EmptyView()
                }
            }
        }
        .ignoresSafeArea() // Ensures that even the NavigationStack ignores safe area
    }

    var mainTitle: some View {
        Text("Test Configuration")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.top, 20)
    }

    var StartButton: some View {
        Text("Start Test")
            .frame(width: 180, height: 50)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
            .foregroundColor(.white)
            .cornerRadius(25)
            .shadow(radius: 10)
            .font(.title2)
            .padding(.top, 20)
    }
}

struct URLField: View {
    @Binding var isEndpoint: Bool
    @Binding var urlString: String

    var body: some View {
        VStack {
            HStack {
                Text(isEndpoint ? "Endpoint" : "URL")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            ZStack {
                if urlString.isEmpty {
                    Text("Enter URL")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                }
                TextField("", text: $urlString)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.black)
            }
        }
        .padding(.bottom, 10)
    }
}

struct RequestField: View {
    @Binding var method: RequestMethod

    var body: some View {
        HStack {
            Text("Method")
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Picker(selection: $method, label: Text(method.id).foregroundColor(.white)) {
                ForEach(RequestMethod.allCases, id: \.self) { method in
                    Text(method.id)
                        .foregroundColor(.white)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding(.bottom, 10)
    }
}


struct UseStructuredURLSwitch: View {
    @Binding var useURLComponents: Bool

    var body: some View {
        HStack {
            Text("Use Structured URL")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: $useURLComponents)
                .toggleStyle(SwitchToggleStyle(tint: .green))
                .padding()
        }
        .padding(.bottom, 10)
    }
}

struct NumberRequestsPicker: View {
    @Binding var numberOfRequests: Int

    var body: some View {
        HStack {
            Text("Number of requests")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Picker("Number of requests", selection: $numberOfRequests) {
                ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .foregroundColor(.black)
        }
        .padding(.bottom, 10)
    }
}

struct BatchSizePicker: View {
    @Binding var batchSize: Int

    var body: some View {
        HStack {
            Text("Batch Size")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Picker("Batch Size", selection: $batchSize) {
                ForEach(1...10, id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .foregroundColor(.black)
        }
        .padding(.bottom, 10)
    }
}

struct IntervalPicker: View {
    @Binding var interval: Int

    var body: some View {
        HStack {
            Text("Request Interval (sec)")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Picker("Request Interval", selection: $interval) {
                ForEach(0...5, id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            .foregroundColor(.black)
        }
        .padding(.bottom, 10)
    }
}

struct ParamsField: View {
    @Binding var keyValuePair: KeyValPair

    var body: some View {
        HStack {
            ZStack {
                if keyValuePair.key.isEmpty {
                    Text("Key")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                TextField("", text: $keyValuePair.key)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
            }
            Spacer()
            ZStack {
                if keyValuePair.value.isEmpty {
                    Text("Value")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }
                TextField("", text: $keyValuePair.value)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 10)
    }
}

struct QueryView: View {
    @Binding var queryParams: [KeyValPair]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Add Query Params")
                .font(.headline)
                .foregroundColor(.white)
            ForEach($queryParams) { $query in
                ParamsField(keyValuePair: $query)
            }
            Button(action: {
                queryParams.append(KeyValPair(key: "", value: ""))
            }) {
                HStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.cyan)
                    Text("Add Query Param")
                        .font(.subheadline)
                        .foregroundColor(.cyan)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
            }
        }
        .padding(.bottom, 20)
    }
}

struct HeaderView: View {
    @Binding var headerParams: [KeyValPair]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Add Header Params")
                .font(.headline)
                .foregroundColor(.white)
            ForEach($headerParams) { $query in
                ParamsField(keyValuePair: $query)
            }
            Button(action: {
                headerParams.append(KeyValPair(key: "", value: ""))
            }) {
                HStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.cyan)
                    Text("Add Header Param")
                        .font(.subheadline)
                        .foregroundColor(.cyan)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}

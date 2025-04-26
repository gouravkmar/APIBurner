import SwiftUI

struct RunningTestView: View {
    @ObservedObject var viewModel: ResultViewModel
    @State var isResultPresent: Bool = false
    
    var body: some View {
        ZStack {
            // Full screen Blur background
            VisualEffectBlur(style: .systemMaterialDark)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                ZStack {
                    // Background Circle
                    Circle()
                        .stroke(lineWidth: 20)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    // Foreground Progress/Status Circle
                    Circle()
                        .trim(from: 0, to: min(CGFloat(viewModel.totalRunningCount) / CGFloat(viewModel.totalCount), 1.0))
                        .stroke(
                            AngularGradient(
                                gradient: currentGradient,
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut, value: viewModel.totalRunningCount)
                }
                .frame(width: 220, height: 220)
                .padding()
                .shadow(radius: 10)
                
                Text(statusText)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                ResultHeaderView(viewModel: viewModel)
                
                if viewModel.totalCount == viewModel.totalRunningCount {
                    showResultButton
                }
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.shouldPresent, content: {
            ResultView(viewModel: viewModel)
        })
    }
    
    // MARK: - Dynamic Properties
    
    private var currentGradient: Gradient {
        if viewModel.testResults.contains(where: { !$0.isSuccess }) {
            return Gradient(colors: [Color.red, Color.orange])
        } else if viewModel.totalRunningCount == viewModel.totalCount {
            return Gradient(colors: [Color.green, Color.mint])
        } else {
            return Gradient(colors: [Color.blue, Color.purple])
        }
    }
    
    private var statusText: String {
        if viewModel.testResults.contains(where: { !$0.isSuccess }) {
            return "Some Failed"
        } else if viewModel.totalRunningCount == viewModel.totalCount {
            return "All Successful"
        } else {
            return "Running Tests"
        }
    }
    
    var showResultButton: some View {
        Button {
            viewModel.shouldPresent = true
        } label: {
            Text("Show Results")
                .font(.headline)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .padding(.top, 10)
    }
}

#Preview {
    RunningTestView(viewModel: ResultViewModel(requestData: RequestDataModel(
        urlString: "",
        requestMethod: .get,
        numberOfRequests: 1,
        batchSize: 1,
        requestInterval: 1,
        useURlComponents: true,
        queryParams: [],
        headerParams: [],
        usesURLComponents: true
    ), uuid: UUID()))
}

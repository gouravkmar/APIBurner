# 🔥 APIBurner Documentation

---

## 🔄 Overview

**API Burner** is an iOS application designed to perform load testing on APIs.  
It allows users to configure API request parameters, send multiple concurrent requests, and monitor results in an intuitive way.

---

## 🔍 Features

- **📅 Request Configuration**
  - Input target URL.
  - Select HTTP method (GET, POST).
  - Add query parameters manually.
  - Add header fields manually.

- **⏱️ Load Testing**
  - Configure the number of requests.
  - Set batch size (number of parallel requests).
  - Define request intervals (seconds between batches).

- **📊 Results Monitoring**
  - Navigate to a result screen after starting the test.
  - View request performance and completion status.

---

## 📈 UI Structure

| 📄 Section | 🔍 Description |
|:--------|:------------|
| **Test Configuration** | URL, method, query params, headers, number of requests, batch size, interval settings |
| **Structured URL Mode** | Toggle to enable key-value structured URL input |
| **Start Test** | Button to initiate the load test |
| **Result View** | Displays real-time test progress and results |

---
## 📸 Screenshots



- **Test Configuration Screen**  
  <img src="https://drive.google.com/uc?id=1KoUhqDVuU1NRrlZpzcCpwmRNrUw_bWgF" alt="Test Configuration" width="200"/>

- **Test Configuration Screen 2**  
  <img src="https://drive.google.com/uc?id=1ON0-Uc2OlXGSFBKQygSiYYAleGgj_ppX" alt="Test Configuration" width="200"/>

- **Running Test Progress**  
  <img src="https://drive.google.com/uc?id=1RB-UPZVWFerLtAmydW9MjRODOmCeD2Tn" alt="Running Test" width="200"/>

- **Running Test Completion**  
  <img src="https://drive.google.com/uc?id=1R5YUak7WTMwhjPyFHGSUXvH1N07HARKK" alt="Running Test" width="200"/>

- **Result View**  
  <img src="https://drive.google.com/uc?id=1IG7BbZYE7RW6mNGeKtBypYre-t5QhZtc" alt="Result View" width="200"/>




## 🔹 Usage Instructions

### 🔧 How to Build and Run

1. Clone the repository.
2. Open the project with **Xcode 15** or newer.
3. Run the app on an **iOS 16+** simulator or device.

### 🔄 How to Use

- Enter the **API URL** manually or use **Structured URL Mode**.
- Select the **HTTP Method**.
- (Optional) Add **Query Parameters** and **Header Fields**.
- Set:
  - **Number of Requests**
  - **Batch Size**
  - **Request Interval**
- Tap **Start Test** to begin the load test.

---

## 💻 Technical Stack

| 📈 Component | 📊 Technology |
|:----------|:-----------|
| UI Framework | SwiftUI |
| State Management | `@ObservedObject`, `@Published` |
| Navigation | `NavigationStack` (iOS 16+) |
| Animations | SwiftUI Animations (for progress indicators) |

---

## 📊 Roadmap

- ✅ Real-time analytics (e.g., success rate, response times).
- ✅ Add support for additional HTTP methods (PUT, DELETE, PATCH).
- ✅ Exportable test logs and reports.
- ✅ Dark Mode support.

---

## 📚 License

API Burner is licensed under the **MIT License**.

---

## 🔔 Notes

- Ensure network permissions (`App Transport Security`) are properly configured.
- Excessive testing may trigger server rate limiting or IP bans.

---

# 🎉 End of Document


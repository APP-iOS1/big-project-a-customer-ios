//
//  QnAView.swift
//  big-project-a-customer-ios
//
//  Created by 고도 on 2023/01/02.
//

import SwiftUI

struct QnA: Identifiable {
    let id = UUID().uuidString
    var question: String
    var answer: String
}

struct QnAListView: View {
    @ObservedObject var questionViewModel: QuestionViewModel = QuestionViewModel()
    @ObservedObject var customerServiceStore: CustomerServiceStore = CustomerServiceStore()
    let tempItemId: String = "watch1"
    
    var body: some View {
        if items.isEmpty {
            ProgressView()
            // 앱을 처음 실행했을 때만 ProgressView를 보여줌
                .task {
                    do {
                        // try await lectureVM.getLecturesOnServer()
                    } catch (let error) {
                        print("Unable to get data : \(error)")
                    }
                }
        } else {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach($questionViewModel.questionItems) { item in
                            VStack {
                                QuestionDetailView(item: item)
                                
                                Divider()
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                }
                
                AddQnAButton(csStore: customerServiceStore)
            }
            
            .navigationTitle("상품 문의")
            .onAppear {
                Task {
                    
                    await customerServiceStore.requestCustomerServiceList(itemId: tempItemId)
                }
            }
        }
            
    }
}

struct AddQnAButton: View {
    @ObservedObject var csStore: CustomerServiceStore

    var body: some View {
        NavigationLink(destination: QnARegistView(customerServiceStore: csStore)) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 48))
                .foregroundColor(.accentColor)
                .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                .padding(24)
        }
    }
}

struct QnAListView_Previews: PreviewProvider {
    static var previews: some View {
        QnAListView()
    }
}

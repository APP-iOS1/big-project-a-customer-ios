//
//  SignUpView.swift
//  big-project-a-customer-ios
//
//  Created by geonhyeong on 2022/12/27.
//
import SwiftUI

struct SignUpView: View {
    //MARK: Property wrapper
    @State private var isTermsClick: [Bool] = [Bool](repeating: false, count: 4)

    //MARK: Property
    let totalTerm = TermType.total
    let terms: [TermType] = [.total, .service, .privacy, .emailAndAd]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 30) {
                    Image(systemName: "globe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        
                    Text("고객님 \n환영합니다!")
                        .lineLimit(2)
                        .font(.title)
                } // HStack
                Spacer()
            } // HStack
            
            Spacer()
            Spacer()
            Spacer()
            
            VStack(spacing: 20) {
                ForEach(Array(terms.enumerated()), id: \.offset) { i, term in
                    TermCellView(isTermsClick: $isTermsClick, isClick: $isTermsClick[i], term: term)
                    
                    if term == .total {
                        Divider().frame(width: UIScreen.main.bounds.width)
                    }
                } // ForEach
            } // VStack
            
            Spacer()
            Divider().frame(width: UIScreen.main.bounds.width)
            
            Button {
                
            } label: {
                HStack {
                    Text("다음")
                    Image(systemName: "arrow.right")
                        .fontWeight(.none)
                }
                .modifier(SignUpNextButtonModifier(isDisable: !(isTermsClick[1] && isTermsClick[2])))
            }
        } // VStack
        .padding()
    }
}

//MARK: - TermCellView
struct TermCellView: View {
    //MARK: Property wrapper
    @Binding var isTermsClick: [Bool]
    @Binding var isClick: Bool

    //MARK: Property
    let term: TermType
    
    var body: some View {
        HStack {
            Button {
                isClick.toggle()
                
                if term == .total {
                    isTermsClick = isTermsClick.map{ _ in isClick}
                } else {
                    isTermsClick[0] = !isTermsClick[1...].contains(false) ? true : false
                }
            } label: {
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(
                            Circle()
                                .stroke(isClick ? .clear : Color.secondary, lineWidth: 2)
                                .background(
                                    Circle()
                                        .fill(isClick ? .accentColor : Color.white)
                                )
                        )
                    
                    HStack(spacing: 5) {
                        Text(term.display)
                        Text(term.isNecessary ? term == .total ? "" : "(필수)" : "(옵션)")
                            .foregroundColor(term.isNecessary ? .red : .black)
                        Spacer()
                        if term.isNecessary && term != .total {
                            Image(systemName: "chevron.right")
                        }
                    } // HStack
                    .lineLimit(1)
                    .foregroundColor(.black)
                } // HStack
            }
            Spacer()
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

// MARK: -Modifier : LoginView 버튼 속성
struct SignUpNextButtonModifier : ViewModifier {
    let isDisable: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
            .foregroundColor(.white)
            .bold()
            .background(isDisable ? .gray : Color.accentColor)
            .cornerRadius(15)
    }
}

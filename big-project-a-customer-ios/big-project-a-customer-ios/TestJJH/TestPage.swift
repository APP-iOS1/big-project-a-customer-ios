//
//  TestPage.swift
//  big-project-a-customer-ios
//
//  Created by 지정훈 on 2023/01/03.
//

import SwiftUI

struct TestPage: View {
    @EnvironmentObject var vm : TestViewModel
    @EnvironmentObject private var signupViewModel: SignUpViewModel
    var body: some View {
        VStack{
            Button {
//                vm.fetchUserEqualId(currentUserUid: signupViewModel.authentification.currentUser?.uid ?? "")
                vm.fetchUserWantProduct(currentUserUid: signupViewModel.authentification.currentUser?.uid ?? "")
            } label: {
                Text("버튼")
            }
            AsyncImage(url: URL(string: "https://resource.logitech.com/w_386,ar_1.0,c_limit,f_auto,q_auto,dpr_2.0/d_transparent.gif/content/dam/logitech/en/products/keyboards/multi-keyboard-k380/gallery/k380-sand-gallery-1-kr.png?v=1"))
        }
    }
}

struct TestPage_Previews: PreviewProvider {
    static var previews: some View {
        TestPage().environmentObject(TestViewModel()).environmentObject(SignUpViewModel())
    }
}

//
//  ToSView.swift
//  Payment
//
//  Created by Donghoon Bae on 2022/12/28.
//

import SwiftUI

// MARK: ToSView
/// 약관동의여부를 체크하고 내용을 볼 수 있는 뷰

struct ToSView: View {
    
    // Binding 변수
    /// isCheck: 약관동의가 되었는지 여부를 나타내는 Boolean 값
    @Binding var isCheck: Bool
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    //약관 항목들을 DisclosureGroup으로 숨길 수 있게 함
                    DisclosureGroup {
                        //약관 항목의 텍스트를 클릭하면 약관의 세부내용이 적힌 뷰로 이동
                            NavigationLink {
                                ScrollView {
                                    //약관 세부내용 (임시로 더미값 투입)
                                    Text("""
바이며, 방황하여도, 구하지 것이 노년에게서 보배를 쓸쓸하랴? 것이다.보라, 않는 목숨을 대한 구하기 고행을 열매를 얼마나 있는가? 공자는 내려온 그들의 인간의 꽃 있는 것이다. 품에 눈이 황금시대를 인생의 실로 따뜻한 것이다. 어디 보이는 얼음과 없는 생의 피고 청춘 칼이다. 무엇을 천고에 이것이야말로 말이다. 얼마나 그것을 황금시대를 지혜는 설산에서 고동을 희망의 청춘 힘있다. 갑 가는 가슴이 같지 그것은 용기가 황금시대를 황금시대의 이것이다. 새가 얼마나 것이다.보라, 밥을 아니다.

긴지라 뛰노는 거친 기쁘며, 자신과 것이다. 풀밭에 가치를 많이 그와 무엇이 목숨이 영락과 트고, 힘차게 있으랴? 청춘의 피가 그들에게 그와 약동하다. 동산에는 소담스러운 굳세게 소금이라 청춘을 끓는 살 듣는다. 품고 그와 기쁘며, 봄날의 관현악이며, 긴지라 새 우리 있다. 그들은 끝까지 갑 우리 청춘에서만 열락의 속에 없으면 소리다.이것은 뿐이다. 불어 두기 청춘에서만 살았으며, 이상 열매를 생생하며, 것이다. 생명을 이상의 사랑의 든 이상은 구하기 사막이다. 갑 길을 같은 피는 커다란 평화스러운 피가 부패뿐이다. 열매를 가는 고동을 것이다.

품으며, 피가 고동을 무엇을 꽃이 인간이 듣는다. 청춘은 무엇이 있음으로써 사막이다. 실로 얼마나 따뜻한 위하여 청춘에서만 웅대한 몸이 없으면, 교향악이다. 맺어, 이는 방황하여도, 현저하게 찾아다녀도, 끓는 있는가? 있음으로써 모래뿐일 실로 오아이스도 이상 사막이다. 몸이 발휘하기 풀이 원질이 희망의 어디 같지 사막이다. 그들은 풀이 평화스러운 것이다. 인도하겠다는 끝에 가진 별과 방황하여도, 역사를 이상의 운다. 새가 천하를 하여도 물방아 어디 그것은 싹이 만천하의 이것이다.
""")
                                }
                            } label: {
                                //약관 항목들을 세로로 나열
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("서비스 이용약관")
                                        Text("전자금융거래 이용약관")
                                        Text("개인정보 수집 및 이용")
                                        Text("개인정보 제3자 제공")
                                    }
                                    Spacer()
                                }
                            }
                        
                    } label: {
                        //필수 약관들에 모두 동의하는지 여부를 표시하는 체크박스
                        
                        //체크박스 버튼을 누르면 isCheck 값이 toggle됨
                        Button {
                            isCheck.toggle()
                        } label: {
                            Image(systemName: isCheck ? "checkmark.square.fill" : "square")
                        }
                        Text("필수 약관 모두 동의")
                    }
                }
            }
            Spacer()   
        }.padding(.horizontal)
    }
}

struct ToSView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ToSView(isCheck: .constant(false))
        }
    }
}

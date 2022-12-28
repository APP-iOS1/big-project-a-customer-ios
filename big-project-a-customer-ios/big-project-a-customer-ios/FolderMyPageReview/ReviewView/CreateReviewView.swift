//
//  CreateReviewView.swift
//  big-project-a-customer-ios
//
//  Created by 박진형 on 2022/12/27.
//

import SwiftUI
import PhotosUI

struct CreateReviewView: View {
    // MARK: 별점 위치를 정할 때 사용되는 변수
    @State var selected = -1
    
    // MARK: 작성한 리뷰가 저장될 변수
    @State var reviewText = ""
    
    // MARK: 앨범에 나타날 item을 담아둘 변수
    @State private var selectedItems = [PhotosPickerItem]()
    
    // MARK: imagePicker에서 선택한 image가 들어갈 변수
    @State private var selectedImages  = [UIImage]()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                
                // MARK: 상품 품질 평가 제목이 들어간 Label
                Label {
                    Text("상품 품질 평가")
                    
                } icon: {
                    Image(systemName: "doc.append")
                }
                .font(.title2)
                .fontWeight(.regular)
                //Label
                Spacer()
            }.padding(.leading)
            
            // MARK: 상품의 정보가 들어간 HStack
            HStack{
                
                /// 실제 정보가 들어온다면 고쳐야 할 부분
                Image("Notebook")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                Text("MacBook Pro 14")
                    .font(.title3)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                
            }.padding()
            
            // MARK: 별점 뷰 구현부
            VStack{
                HStack{
                    Text("이 상품의 품질에 대해 얼마나 만족하시나요?")
                    Spacer()
                }
                .padding(.leading)
                HStack(spacing: 10){
                    ForEach(0..<5){ i in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(self.selected >= i ? .yellow : .gray)
                            .onTapGesture {
                            self.selected = i
                            
                        }
                    }
                    Spacer()
                }
                .padding([.leading, .bottom])
            }
            
            // MARK: 리뷰 작성 구현부
            HStack{
                Text("이 상품을 상세히 평가해주세요")
                
            }.padding(.leading)
            .padding(.bottom, -10)
            TextField("  리뷰를 작성해주세요.", text: $reviewText, axis: .vertical)
                        .lineLimit(4...)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .opacity(selected >= 0 ? 1 : 0)
                        .animation(.easeInOut, value: selected)
            
            // MARK: imagePicker 구현부
            ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center, spacing: 20.0) {
                                selectionImageButton

                                ForEach(selectedImages, id: \.self) { uiImage in
                                    imageCard(from: uiImage)
                                }
                            }
                            .padding(.vertical, 20.0)
                        }
            .padding(.leading)
            .padding(.top, -35)
            .opacity(selected >= 0 ? 1 : 0)
            .animation(.easeInOut, value: selected)
            /// imagePicker
            
            /// 리뷰 등록 버튼
            Button {
                print("button pressed")
            } label: {
                Text("리뷰 등록하기")
            }
            .frame(width: UIScreen.main.bounds.width)

            
        }
    }
    
    // MARK: -imagePickerView의 버튼 모양
    var selectionImageButton: some View {
            VStack(alignment: .center, spacing: 7) {
                PhotosPicker(selection: $selectedItems,  matching: .any(of: [.images, .not(.videos)])) {
                    Label("Pick Photo", systemImage: "camera")
                        .labelStyle(.iconOnly)
                        .font(.system(size: 20))
                }
                .onChange(of: selectedItems) { newValues in
                    Task {
                        selectedImages = []
                        for value in newValues {
                            if let imageData = try? await value.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                                selectedImages.append(image)
                            }
                        }
                    }
                }
                Text("\(selectedImages.count)/10")
                           .font(.callout)
                           .fontWeight(.regular)
                           .tracking(5)
                   }
                   .frame(width: 70, height: 70)
                   .background {
                       RoundedRectangle(cornerRadius: 4)
                           .stroke(Color(.systemGray5), lineWidth: 1)
                   }
               }
               
               // MARK: Update Scroll View with Selected Image
               /// imagePicker에서 선택한 이미지를 밖의 scrollView로 반환해 주는 함수
               func imageCard(from data: UIImage ,isMainImage: Bool = false) -> some View {
                   Image(uiImage: data)
                       .resizable()
                       .scaledToFill()
                       .frame(width: 70, height: 70)
                       .cornerRadius(4)
                       .overlay {
                           RoundedRectangle(cornerRadius: 4)
                               .stroke(.gray, lineWidth: 1)
                       }
                       .overlay(alignment: .topTrailing) {
                           Circle()
                               .frame(width: 20, height: 20)
                               .overlay {
                                   Image(systemName: "xmark")
                                       .font(.system(size: 10))
                                       .foregroundColor(.white)
                               }
                               .offset(x: 10, y: -10)
                       }
                       .overlay(alignment: .bottom) {
                           if isMainImage {
                               Text("대표 사진")
                                   .font(.callout)
                                   .fontWeight(.regular)
                                   .frame(maxWidth: .infinity)
                                   .frame(height: 20)
                                   .foregroundColor(Color.white)
                                   .background { Color.black }
                                   .cornerRadius(4)
                           }
                       }
                   
               }
}

struct CreateReviewView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReviewView()
    }
}

//
//  ShareSocialMediaView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 04.08.24.
//

import SwiftUI
import UIKit

struct ShareSocialMediaView: View {
    @Binding var count: Int
    var historyRecord: HistoryRecord
    @State private var isImageSaveScreenActivated = false
    var onDismiss: () -> Void

    @State private var capturedImage: UIImage?

    var body: some View {
            VStack {
                ShareableView(historyRecord: historyRecord)
                    .padding(.bottom, 50)
                    .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                            captureView(viewSize: geometry.size)
                        }
                    })
                
                HStack(spacing: 10) {
                    
                    Button(action: {
                        if let image = capturedImage {
                            shareToSocialMedia(image)
                        }
                    }) {
                        ZStack{
                            Group{
                                Image("facebookLogo").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .rotationEffect(Angle(degrees: -30))
                                    .offset(x: -40, y: 10)
                                    .blur(radius: 5)
                                Image("instagramLogo").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .rotationEffect(Angle(degrees: -30))
                                    .offset(x: 50, y: 10)
                                    .blur(radius: 10)
                                Image("xLogo").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 30)
                                    .rotationEffect(Angle(degrees: -30))
                                    .offset(x: -30, y: -10)
                                    .blur(radius: 4)
                            }
                            Image(systemName: "square.and.arrow.up")
                                .frame(width: 70, height: 70)
                        }.frame(width: (UIScreen.main.bounds.width-60)/2, height: 50)
                            .cornerRadius(25)
                    }
                    Button(action: {
                        isImageSaveScreenActivated = true
                    }) {
                        ZStack{
                            Image(systemName: "square.and.arrow.down")
                                .frame(width: 70, height: 70)
                        }.frame(width: (UIScreen.main.bounds.width-60)/2, height: 50)
                            .cornerRadius(25)
                    }
                    
                }
                .padding(.bottom, 50)
                
                Button(action: {
                    count = historyRecord.count
                    onDismiss()
                }) {
                    Text("Continue")
                        .bold()
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 25)
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(25)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .sheet(isPresented: $isImageSaveScreenActivated){
                if let capturedImage = capturedImage {
                    SaveImageView(capturedImage: capturedImage, isImageSaveScreenActivated:$isImageSaveScreenActivated)
                }
            }
    }

    private func captureView(viewSize: CGSize) {
        let snapshotView = ShareableView(historyRecord: historyRecord)
            .frame(width: viewSize.width, height: viewSize.height)
            .background(Color.clear)

        let hostingController = UIHostingController(rootView: snapshotView)
        let view = hostingController.view!
        view.frame = CGRect(origin: .zero, size: viewSize)
        
        let renderer = UIGraphicsImageRenderer(size: viewSize)
        let image = renderer.image { context in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }

        DispatchQueue.main.async {
            self.capturedImage = image
        }
    }

    private func shareToSocialMedia(_ image: UIImage) {
        let message = "Check out my score! #CounterApp"
        let activityViewController = UIActivityViewController(activityItems: [image, message], applicationActivities: nil)
        
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
}

struct SocialMediaButton: View {
    var title: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
            }
            .frame(width: 70, height: 70)
        }
    }
}

#Preview {
    ShareSocialMediaView(count: .constant(40), historyRecord: HistoryRecord(count: 42, date: Date(), name: "Sample Record", backgroundTheme: .animatedBWTheme, textBackgroundTheme: .circleTextBackground, isCountTextBlack: true), onDismiss: {})
}




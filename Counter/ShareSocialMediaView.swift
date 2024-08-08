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
    var onDismiss: () -> Void

    @State private var capturedImage: UIImage?

    var body: some View {
        VStack {
//            if let capturedImage = capturedImage {
//                Image(uiImage: capturedImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding(.bottom, 50)
//            } else {
                ShareableView(historyRecord: historyRecord)
                    .padding(.bottom, 50)
                    .background(GeometryReader { geometry in
                        Color.clear.onAppear {
                            captureView(viewSize: geometry.size)
                        }
                    })
            

            HStack {
                SocialMediaButton(title: "Facebook", imageName: "facebookLogo") {
                    shareImageToSocialMedia(platform: "Facebook")
                }
                SocialMediaButton(title: "Instagram", imageName: "instagramLogo") {
                    shareImageToSocialMedia(platform: "Instagram")
                }
                SocialMediaButton(title: "X", imageName: "xLogo") {
                    shareImageToSocialMedia(platform: "X")
                }
                Button(action: {
                    if let capturedImage = capturedImage {
                        saveImageToPhotoLibrary(capturedImage)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .padding()
                        .cornerRadius(10)
                        .frame(width: 70, height: 70)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 25)
            .background(Color.black.opacity(0.1))
            .cornerRadius(25)
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

    private func saveImageToPhotoLibrary(_ image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            if let presentedVC = viewController.presentedViewController {
                presentedVC.present(activityViewController, animated: true, completion: nil)
            } else {
                viewController.present(activityViewController, animated: true, completion: nil)
            }
        }
    }

    private func shareImageToSocialMedia(platform: String) {
        if let image = capturedImage {
            let activityViewController = UIActivityViewController(activityItems: [image, "Check out my score! #CounterApp", URL(string: "https://apps.apple.com/de/app/einb%C3%BCrgerungstest/id6470721198?l=en-GB")!], applicationActivities: nil)
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                if let presentedVC = viewController.presentedViewController {
                    presentedVC.present(activityViewController, animated: true, completion: nil)
                } else {
                    viewController.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
    }
}

#Preview {
    ShareSocialMediaView(count: .constant(40), historyRecord: HistoryRecord(count: 42, date: Date(), name: "Sample Record", backgroundTheme: .animatedBWTheme, textBackgroundTheme: .circleTextBackground, isCountTextBlack: true), onDismiss: {})
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



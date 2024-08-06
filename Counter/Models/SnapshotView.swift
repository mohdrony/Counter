//
//  SnapshotView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 07.08.24.
//

import SwiftUI

struct SnapshotView<Content: View>: UIViewRepresentable {
    let content: Content
    let completion: (UIImage) -> Void

    func makeUIView(context: Context) -> UIView {
        let controller = UIHostingController(rootView: content)
        let view = controller.view!
        view.backgroundColor = .clear

        DispatchQueue.main.async {
            let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
            let image = renderer.image { context in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
            completion(image)
            view.removeFromSuperview()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}




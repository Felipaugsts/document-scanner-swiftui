import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: ([UIImage]?) -> Void

    init(completion: @escaping ([UIImage]?) -> Void) {
        self.completionHandler = completion
    }

    typealias UIViewControllerType = VNDocumentCameraViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<ScannerView>) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: UIViewControllerRepresentableContext<ScannerView>) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(completion: completionHandler)
    }

    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([UIImage]?) -> Void

        init(completion: @escaping ([UIImage]?) -> Void) {
            self.completionHandler = completion
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            var images: [UIImage] = []

            // Iterate through scan pages
            for index in 0..<scan.pageCount {
                let pageImage = scan.imageOfPage(at: index)
                images.append(pageImage)
            }
            completionHandler(images)
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera error: \(error.localizedDescription)")
            completionHandler(nil)
        }
    }
}

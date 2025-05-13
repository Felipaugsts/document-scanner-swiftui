import SwiftUI
import VisionKit

struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: (UIImage?) -> Void

    init(completion: @escaping (UIImage?) -> Void) {
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

    // MARK: - Coordinator
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: (UIImage?) -> Void

        init(completion: @escaping (UIImage?) -> Void) {
            self.completionHandler = completion
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // Capture apenas a primeira página do documento escaneado
            if scan.pageCount > 0 {
                let image = scan.imageOfPage(at: 0) // Captura a primeira imagem
                completionHandler(image) // Retorna a imagem capturada
            } else {
                completionHandler(nil) // Retorna nil se não houver páginas
            }
            controller.dismiss(animated: true, completion: nil) // Fecha o scanner
        }

        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil) // Retorna nil se o usuário cancelar
            controller.dismiss(animated: true, completion: nil) // Fecha o scanner
        }

        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera error: \(error.localizedDescription)")
            completionHandler(nil) // Retorna nil em caso de falha
            controller.dismiss(animated: true, completion: nil) // Fecha o scanner
        }
    }
}

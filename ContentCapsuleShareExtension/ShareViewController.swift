import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    var urlToShare: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        extractContentURL()
    }

    override func isContentValid() -> Bool {
        // Validate the contentText and return true if the content is valid
        return !contentText.isEmpty && urlToShare != nil
    }

    override func didSelectPost() {
        // This is called after the user selects Post
        print("didSelectPost called")
        if let content = contentText, let url = urlToShare {
            print("Content: \(content)")
            print("URL: \(url)")
            ContentSavingService.saveContent(title: content, url: url.absoluteString)
        } else {
            print("No content or URL found")
        }
        
        // Inform the host that we're done, so it un-blocks its UI
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // Return an array of SLComposeSheetConfigurationItem if needed
        return []
    }

    private func extractContentURL() {
        print("Extracting content URL")
        guard let items = extensionContext?.inputItems as? [NSExtensionItem] else { return }
        for item in items {
            if let itemProvider = item.attachments?.first {
                if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                    itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] (item, error) in
                        if let error = error {
                            print("Error loading item: \(error)")
                            return
                        }
                        if let url = item as? URL {
                            self?.urlToShare = url
                            print("URL found: \(url)")
                        }
                    }
                    break
                }
            }
        }
    }
}

import SwiftUI

struct SaveView: View {
    @State private var title: String = ""
    @State private var url: String = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                Section(header: Text("URL")) {
                    TextField("Enter URL", text: $url)
                }
            }
            .navigationBarTitle("Save Content", displayMode: .inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        }
    }
    
    private var saveButton: some View {
        Button(action: saveContent) {
            Text("Save")
        }
        .disabled(title.isEmpty || url.isEmpty)
    }
    
    private func saveContent() {
        let newContent = SavedContent(context: managedObjectContext)
        newContent.title = title
        newContent.url = url
        newContent.dateAdded = Date()  // Use dateAdded instead of timestamp
        
        do {
            try managedObjectContext.save()
            print("Content saved: \(newContent)")
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save content: \(error.localizedDescription)")
        }
    }
}

struct SaveView_Previews: PreviewProvider {
    static var previews: some View {
        SaveView().environment(\.managedObjectContext, CoreDataStack.shared.context)
    }
}

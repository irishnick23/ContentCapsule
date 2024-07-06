import SwiftUI
import CoreData

struct SavedContentListView: View {
    @FetchRequest(
        entity: SavedContent.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \SavedContent.dateAdded, ascending: false)]  // Use dateAdded instead of timestamp
    ) var savedContents: FetchedResults<SavedContent>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(savedContents, id: \.self) { content in
                    VStack(alignment: .leading) {
                        Text(content.title ?? "No Title")
                            .font(.headline)
                        Text(content.url ?? "No URL")
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("Saved Content")
        }
        .onAppear {
            print("Loaded saved contents: \(savedContents.count)")
        }
    }
}

struct SavedContentListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedContentListView().environment(\.managedObjectContext, CoreDataStack.shared.context)
    }
}

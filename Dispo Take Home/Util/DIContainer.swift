import Foundation

class DIContainer {
    
   static func makeDetailsViewModel(gifId: String) -> DetailsViewModel {
        let detailsViewModel = DetailsViewModel()
        detailsViewModel.giphID = gifId
        return detailsViewModel
    }
}

import Foundation

extension DetailViewController {
    
    func addToView() {
        view.addSubview(gifImage)
        view.addSubview(gifTitleLabel)
        view.addSubview(gifTitle)
        view.addSubview(sourceLabel)
        view.addSubview(ratingsLabel)
    }
    
    func configureView() {
        title = "Gif Info Details"
        addToView()
        addConstraintsToGifImage()
        addConstraintsToGifTitleLabel()
        addConstraintsToGifTitle()
        addConstraintsToSourceLabel()
        addConstraintsToRatingsLabel()
    }
    
    func addConstraintsToGifImage() {
        gifImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }
    }
    
    func addConstraintsToGifTitleLabel() {
        gifTitleLabel.snp.makeConstraints({ make in
            make.top.equalTo(gifImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
        })
    }
    
    func addConstraintsToGifTitle() {
        gifTitle.snp.makeConstraints { make in
            make.top.equalTo(gifImage.snp.bottom).offset(20)
            make.leading.equalTo(gifTitleLabel).inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    func addConstraintsToSourceLabel() {
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(gifTitle.snp.bottom).offset(10)
            make.centerXWithinMargins.equalTo(gifTitle.snp_centerXWithinMargins)
        }
    }
    
    func addConstraintsToRatingsLabel() {
        ratingsLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceLabel.snp.bottom).offset(10)
            make.centerXWithinMargins.equalTo(sourceLabel.snp_centerXWithinMargins)
        }
    }
    
}

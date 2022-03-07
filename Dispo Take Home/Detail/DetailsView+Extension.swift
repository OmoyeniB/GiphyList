import Foundation

extension DetailViewController {
    
    func addToView() {
        view.addSubview(gifImage)
        view.addSubview(titleStackView)
        view.addSubview(sourceStackView)
        view.addSubview(ratingStackView)
    }
    
    func configureView() {
        title = "Gif Info Details"
        addToView()
        addConstraintsToGifImage()
        configureTitleStackView()
        addConstraintsToGifTitleLabel()
        addConstraintsToGifTitle()
        configureSourceStackView()
        addConstraintToGifSourceLabel()
        addConstraintsToSourceLabel()
        addConstraintsToratingStackView()
        addConstraintToRatingsLabel()
        addConstraintsToRatings()
    }
    
    func addConstraintsToGifImage() {
        gifImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(400)
        }
    }
    
    func configureTitleStackView() {
        titleStackView.snp.makeConstraints({make in
            make.top.equalTo(gifImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        })
    }
    
    //gifTitleLabel gifSourceLabel gifRatingsLabel
    func addConstraintsToGifTitleLabel() {
        gifTitleLabel.snp.makeConstraints({ make in
            make.top.equalTo(titleStackView)
            make.leading.equalTo(titleStackView)
        })
    }
    
    func addConstraintsToGifTitle() {
        gifTitle.snp.makeConstraints { make in
            make.top.equalTo(titleStackView)
            make.leading.equalTo(gifTitleLabel.snp.trailing).offset(3)
            make.trailing.equalTo(titleStackView)
        }
    }
    func configureSourceStackView() {
        sourceStackView.snp.makeConstraints({make in
            make.top.equalTo(titleStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        })
    }
//
    func addConstraintToGifSourceLabel() {
        gifSourceLabel.snp.makeConstraints({ make in
            make.top.equalTo(sourceStackView)
            make.leading.equalTo(sourceStackView)
        })
    }
    func addConstraintsToSourceLabel() {
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceStackView)
            make.leading.equalTo(gifSourceLabel.snp.trailing).offset(3)
            make.trailing.equalTo(sourceStackView)
        }
    }
    //ratingStackView
    func addConstraintsToratingStackView() {
        ratingStackView.snp.makeConstraints({make in
            make.top.equalTo(sourceStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        })
    }

    func addConstraintToRatingsLabel() {
       gifRatingsLabel.snp.makeConstraints({ make in
            make.top.equalTo(ratingStackView)
            make.leading.equalTo(ratingStackView)
        })
    }
    
    func addConstraintsToRatings() {
        ratingsLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingStackView)
            make.leading.equalTo(gifRatingsLabel.snp.trailing).offset(3)
            make.trailing.equalTo(ratingStackView)
        }
    }
    
}

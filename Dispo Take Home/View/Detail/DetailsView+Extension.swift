import Foundation

extension DetailViewController {
    
    func addToView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(gifImage)
        containerView.addSubview(gifTitleLabel)
        containerView.addSubview(gifTitle)
        containerView.addSubview(sourceStackView)
        containerView.addSubview(gifRatingsLabel)
        containerView.addSubview(ratingsLabel)
    }
    
    func configureView() {
        title = Constants.detailsTitle
        addToView()
        configureScrollView()
        configureContainer()
        addConstraintsToGifImage()
        addConstraintsToGifTitleLabel()
        addConstraintsToGifTitle()
        addConstraintsToGifSourceLabel()
        addConstraintsToSourceLabel()
        addConstraintsToGifRatingsLabel()
        configureSourceStackView()
        addConstraintsToRatingsLabel()
    }
    
    func configureScrollView() {
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func configureContainer() {
        containerView.snp.makeConstraints({ make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.centerX.equalTo(scrollView)
            make.centerY.equalTo(scrollView)
        })
    }
    
    func addConstraintsToGifImage() {
        
        gifImage.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(40)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.height.equalTo(400)
        }
    }
    
    func addConstraintsToGifTitleLabel() {
        gifTitleLabel.snp.makeConstraints({ make in
            make.top.equalTo(gifImage.snp.bottom).offset(20)
            make.leading.equalTo(containerView).offset(25)
        })
    }
    
    func addConstraintsToGifTitle() {
        gifTitle.snp.makeConstraints { make in
            make.top.equalTo(gifImage.snp.bottom).offset(20)
            make.leading.equalTo(gifTitleLabel.snp.trailingMargin).offset(10)
            make.trailing.equalTo(containerView).inset(20)
        }
    }
    
    func configureSourceStackView() {
        sourceStackView.snp.makeConstraints({ make in
            make.top.equalTo(gifTitle.snp.bottom).offset(20)
            make.centerX.equalTo(containerView.snp.centerX)
        })
    }
    
    func addConstraintsToGifSourceLabel() {
        gifSourceLabel.snp.makeConstraints({ make in
            make.leading.equalTo(sourceStackView)
            make.top.equalTo(sourceStackView)
        })
    }
    
    func addConstraintsToSourceLabel() {
        sourceLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceStackView)
            make.leading.equalTo(gifSourceLabel.snp.trailing).offset(10)
        }
    }
    
    func addConstraintsToGifRatingsLabel() {
        gifRatingsLabel.snp.makeConstraints({ make in
            make.top.equalTo(sourceStackView.snp.bottom).offset(20)
            make.centerX.equalTo(containerView.snp.centerX)
        })
    }
    
    func addConstraintsToRatingsLabel() {
        ratingsLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceStackView.snp.bottom).offset(20)
            make.leading.equalTo(gifRatingsLabel.snp.trailing).offset(5)
        }
    }
    
}

import Foundation

extension MainViewCell {
    
    func configureViewCell() {
        configureGifImage()
        configureGifTitle()
    }
    
    func configureGifImage() {
        gifImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(100)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    func configureGifTitle() {
        gifTitle.numberOfLines = 1
        gifTitle.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.height.equalTo(50)
            make.leading.equalTo(gifImage.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

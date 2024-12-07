import UIKit

final class NoteViewController: UIViewController {
    @IBOutlet private weak var noteTV: UITextView!
    private var rightBtn: UIButton!
    var note: NoteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTV.textColor = .white
        noteTV.delegate = self
        
        navigationController?.navigationBar.tintColor = .yellowApp
        view.backgroundColor = .black
        setupData()
        setupNavi()
    }
    
    private func setupData() {
        noteTV.text = note.content
    }
    
    private func setupNavi() {
        rightBtn = UIButton()
        rightBtn.setTitle("Done", for: .normal)
        rightBtn.setTitleColor(.gray, for: .normal)
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        rightBtn.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        rightBtn.isUserInteractionEnabled = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    
    @objc private func saveNote() {
        note.content = noteTV.text ?? ""
        rightBtn.setTitleColor(.gray, for: .normal)
        rightBtn.isUserInteractionEnabled = false
        NotificationCenter.default
            .post(name: .noteUpdate, object: note)
    }
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            rightBtn.setTitleColor(.gray, for: .normal)
            rightBtn.isUserInteractionEnabled = false
        } else if note.content != textView.text {
            rightBtn.setTitleColor(.yellowApp, for: .normal)
            rightBtn.isUserInteractionEnabled = true
        } else {
            rightBtn.setTitleColor(.gray, for: .normal)
            rightBtn.isUserInteractionEnabled = false
        }
    }
}

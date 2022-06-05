//
//  StatisticViewController.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 8.05.22.
//

import UIKit
import RealmSwift

struct DifferenceWorkout {
    let name: String
    let lastReps: Int
    let firstReps: Int
    let lastTimer: Int
    let firstTimer: Int
    let unique: Bool
}

class StatisticViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let statisticsLabel: UILabel = {
        let label = UILabel()
        label.text = "STATISTICS"
        label.textColor = .specialGray
        label.font = .robotoMedium24()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField = UITextField(text: "")
    
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Week", "Month"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = .specialGreen
        control.selectedSegmentTintColor = .specialYellow
        let font = UIFont(name: "Roboto-Medium", size: 16)
        control.setTitleTextAttributes([NSAttributedString.Key.font:font as Any,
                                        NSAttributedString.Key.foregroundColor: UIColor.white],
                                        for: UIControl.State.normal)
        control.setTitleTextAttributes([NSAttributedString.Key.font:font as Any,
                                        NSAttributedString.Key.foregroundColor: UIColor.specialGray],
                                        for: UIControl.State.selected)
        control.addTarget(self, action: #selector (segmentedValueChanged), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let exercisesLabel = UILabel(text: "Exercises")
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false//чтобы не ездила таблица и зажатии и когда тянешь вниз
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.delaysContentTouches = false
        return tableView
    }()
    
    private let idStatisticTableViewCell = "idStatisticTableViewCell"
    
    let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    
    private var differenceArray = [DifferenceWorkout]()
    private var filteredArray = [DifferenceWorkout]()
    
    let dateToday = Date().localDate()
    private var isFiltered = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTableViewData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        setStartScreen()
    }
    
    deinit {
        print ("StatisticViewController was deinited")
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        nameTextField.delegate = self
    }
    
    private func setStartScreen(){
        getDifferenceModel(dateStart: dateToday.offsetDays(days: 7))
        tableView.reloadData()
    }
    
    private func updateTableViewData() {
        differenceArray = [DifferenceWorkout]()// обнуляем массив при смене сегмента
        
        if segmentedControl.selectedSegmentIndex == 0{
            let dateStart = dateToday.offsetDays(days: 7)
            getDifferenceModel(dateStart: dateStart)
        } else {
            let dateStart = dateToday.offsetMonths(months: 1)
            getDifferenceModel(dateStart: dateStart)
        }
        
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(statisticsLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(exercisesLabel)
        scrollView.addSubview(tableView)
        
        tableView.register(ExercisesTableViewCell.self, forCellReuseIdentifier: idStatisticTableViewCell)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl)
        {
            updateTableViewData()
        }
    
    private func getWorkoutsName() -> [String] {
        
        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName){
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        
        let dateEnd = Date().localDate()
        let nameArray = getWorkoutsName()
        
        for name in nameArray {
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else { return }
            
            guard let lastTimer = workoutArray.last?.workoutTimer,
                  let firstTimer = workoutArray.first?.workoutTimer else { return }
            
            let unique: Bool
            unique = workoutArray.count == 1
            
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first, lastTimer: lastTimer, firstTimer: firstTimer, unique: unique)
            differenceArray.append(differenceWorkout)
        }
    }
    
    private func filtringWorkouts(text: String) {
        
        for workout in differenceArray {
            if workout.name.lowercased().contains(text.lowercased()){
                filteredArray.append(workout)
            }
        }
    }
}

//MARK: -UITextFieldDelegate

extension StatisticViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text){
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            filteredArray = [DifferenceWorkout]()// обнуляем
            isFiltered = updatedText.count > 0 ? true : false
            filtringWorkouts(text: updatedText)
            tableView.reloadData()
        }
        return true
    }//будем ли мы заменять текст в текстфилде на какой-нибудь текст, range по умолчанию = 0, текстфилд с опозданием на 1 символ
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()// скрывается клавиатура
    }
}

//MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

//MARK: - UITableViewDataSource

extension StatisticViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltered ? filteredArray.count : differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticTableViewCell, for: indexPath) as! ExercisesTableViewCell
        let differenceModel = isFiltered ? filteredArray[indexPath.row] : differenceArray[indexPath.row]
        cell.cellConfigure(differenceWorkout: differenceModel)
        return cell
    }
}
//MARK: - SetConstraints

extension StatisticViewController {
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            statisticsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            statisticsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            statisticsLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: statisticsLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            exercisesLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            exercisesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercisesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: exercisesLabel.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

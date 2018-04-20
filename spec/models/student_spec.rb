require 'rails_helper'

describe "Student" do
  it "uses a formatter to display its name" do
    # Files defining formatters must be located in /lib
    # For instance: /code/lib/upper_case_formatter.rb
    # If they are not, THE CLASS WILL NOT LOAD

    student = Student.new(name: "Alice Bridge")

    expect(
      student.display_name([UpperCaseFormatter])
    ).to eq("ALICE BRIDGE")

    expect(
      student.display_name([YellingFormatter])
    ).to eq("Alice Bridge!!")

    expect(
      student.display_name([OnlyFirstNameFormatter])
    ).to eq("Alice")
  end

  it "can chain formatters" do
    student = Student.new(name: "Alan Bladen")

    expect(
      student.display_name([OnlyFirstNameFormatter, YellingFormatter, UpperCaseFormatter])
    ).to eq("ALAN!!")


    student = Student.new(name: "Abraham Baltimore")

    expect(
      student.display_name([OnlyFirstNameFormatter, UpperCaseFormatter])
    ).to eq("ABRAHAM")
  end

  it "can display all exams a student took" do
    bob = Student.new(name: "Bob")

    ruby = Exam.new(name: "Partiel Final", subject: "Ruby")
    design = Exam.new(name: "TP 2", subject: "Design")
    Exam.new(name: "Pop Quizz", subject: "Mobile")

    Grade.create(student: bob, exam: ruby, score: 15)
    Grade.create(student: bob, exam: design, score: 12)

    expect(bob.formatted_exams).to eq(
      "2 exams: Ruby (Partiel Final), Design (TP 2)"
    )
  end

  it "can compute the average grade of a student" do
    ruby = Exam.new(name: "Partiel Final", subject: "Ruby")
    design = Exam.new(name: "TP 2", subject: "Design")

    bob = Student.create(name: "Bob")
    bob.grades.create(exam: ruby, score: 16)
    bob.grades.create(exam: design, score: 10)
    expect(bob.average).to eq(13)

    alice = Student.create(name: "Alice")
    alice.grades.create(exam: ruby, score: 20)
    alice.grades.create(exam: design, score: 10)
    expect(alice.average).to eq(15)
  end
end

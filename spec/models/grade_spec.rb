require 'rails_helper'

describe "Grade" do

  # Grade is used to store the actual grade (here refered to as "score")
  # It is also used to link students to exams

  it "is linked to students and exams" do
    expect(Grade.count).to eq(0)
    alice = Student.create(name: "Alice #{rand(1000)}")
    exam = Exam.new(name: "Partiel Final #{rand(1000)}", subject: "Ruby")

    Grade.create(
      student: alice,
      exam: exam,
      score: 19
    )

    expect(Grade.count).to eq(1)
    grade = Grade.last

    expect(grade.student.name).to eq(alice.name)
    expect(grade.exam.name).to eq(exam.name)
  end

  it "can retrieve all grades for a student" do
    alice = Student.create(name: "Alice")
    ruby_exam = Exam.new(name: "Partiel", subject: "Ruby")
    design_exam = Exam.new(name: "Partiel Final", subject: "Design")
    communication_exam = Exam.new(name: "TP 3", subject: "Communication")

    grade_ruby = Grade.create(student: alice,exam: ruby_exam, score: rand(20))
    grade_design = Grade.create(student: alice,exam: design_exam, score: rand(20))
    grade_communication = Grade.create(student: alice,exam: communication_exam, score: rand(20))

    expect(Grade.for_student(alice)).to eq([grade_ruby, grade_design, grade_communication])
  end

  it "displays all grades for a student" do
    alice = Student.create(name: "Alice")
    ruby_exam = Exam.new(name: "Final Exam", subject: "Ruby")
    Grade.create(student: alice,exam: ruby_exam, score: "18")

    expect(Grade.formatted_for_student(alice)).to eq(
      "Grades for Alice: 18/20 in the Ruby Final Exam"
    )

    design_exam = Exam.new(name: "Workshop", subject: "Design")
    Grade.create(student: alice,exam: design_exam, score: "12")

    expect(Grade.formatted_for_student(alice)).to eq(
      "Grades for Alice: 18/20 in the Ruby Final Exam, 12/20 in the Design Workshop"
    )
  end
end

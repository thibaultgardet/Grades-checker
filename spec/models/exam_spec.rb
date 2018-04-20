require 'rails_helper'

describe "Exam" do
  it "has a name and a subject" do
    exam = Exam.new
    expect(exam.valid?).to eq(false)

    exam = Exam.new(subject: "Ruby")
    expect(exam.valid?).to eq(false)

    exam = Exam.new(name: "Partiel Final")
    expect(exam.valid?).to eq(false)

    exam = Exam.new(name: "Partiel Final", subject: "Ruby")
    expect(exam.valid?).to eq(true)
  end

  it "only accepts valid subjects" do
    ["Ruby", "Design", "Mobile"].each do |exam_subject|
      exam = Exam.new(name: "Partiel", subject: exam_subject)
      expect(exam.valid?).to eq(true)
    end

    [".NET", "X86", "Pole Vaulting"].each do |exam_subject|
      exam = Exam.new(name: "Partiel", subject: exam_subject)
      expect(exam.valid?).to eq(false)
    end
  end

  it "can return information about exams" do
    expect(Exam.info).to eq(
      "There are 3 subjects possible: Ruby, Design, Mobile"
    )

    exam = Exam.new(name: "Partiel", subject: "Ruby")
    expect(exam.info).to eq(
      "This is a Ruby exam. There are 2 other subjects possible: Design, Mobile"
    )

    exam = Exam.new(name: "Partiel", subject: "Design")
    expect(exam.info).to eq(
      "This is a Design exam. There are 2 other subjects possible: Ruby, Mobile"
    )
  end

  it "has students taking the exam" do
    alice = Student.new(name: "Alice")
    bob = Student.new(name: "Bob")

    exam = Exam.create(
      name: "Partiel", subject: "Ruby", students: [alice, bob]
    )
    expect(exam.students.count).to eq(2)

    other_exam = Exam.create(
      name: "Partiel", subject: "Ruby", students: [bob]
    )
    expect(other_exam.students.count).to eq(1)
  end

end

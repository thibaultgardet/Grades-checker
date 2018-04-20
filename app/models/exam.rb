class Exam < ActiveRecord::Base

  has_many :grades
  has_many :students, through: :grades

  VALID_SUBJECTS = ["Ruby", "Design", "Mobile"]

  validates :name, presence: true
  validates :subject, presence: true

  validates :subject, inclusion: { in: Exam::VALID_SUBJECTS,
    message: "%{value} is not a valid exam subject." }

  def self.info
    "There are 3 subjects possible: #{Exam::VALID_SUBJECTS.join(', ')}"
  end

  def info
    "This is a #{subject} exam. There are 2 other subjects possible: #{Exam::VALID_SUBJECTS.reject{|i| i == subject}.join(', ')}"
  end
end

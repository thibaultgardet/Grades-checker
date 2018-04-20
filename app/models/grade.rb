class Grade < ActiveRecord::Base
  belongs_to :student
  belongs_to :exam

  def self.for_student(student)
    where(student: student)
  end

  def self.formatted_for_student(student)
    "Grades for Alice: " + for_student(student).map{|g| "#{g.score}/20 in the #{g.exam.subject} #{g.exam.name}"}.join(', ')    
  end
end

class UpperCaseFormatter
  def self.format(text)
    text.upcase
  end
end

class YellingFormatter
  def self.format(text)
    "#{text}!!"
  end
end

class OnlyFirstNameFormatter
  def self.format(text)
    text.split(" ")[0]
  end
end



class Student < ActiveRecord::Base

  has_many :grades
  has_many :exams, through: :grades

  validates :name, presence: true

  def display_name(formater)
    formated = self.name
    formater.each do |f|
      formated = eval("f.send(:format,'#{formated}')")
    end
    formated
  end

  def formatted_exams
    "#{exams.count} exams: #{exams.map{|e| "#{e.subject} (#{e.name})"}.join(', ')}"
  end

  def average
    grades = exams.pluck(:score)
    grades.sum / grades.size
  end
end

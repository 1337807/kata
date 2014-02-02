require 'test/unit'

class Student
  attr_accessor :grades

  def average_grade
    self.grades.inject(&:+) / self.grades.length
  end
end

class StudentTest < Test::Unit::TestCase
  def setup
    @student = Student.new
  end

  def test_average_reports_the_average_of_a_students_grades
    @student.grades = [10, 11, 12]
    assert_equal 11, @student.average_grade
  end
end

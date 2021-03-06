require 'test/unit'

class Cli
  def run
    puts "Please enter number of students (N) and grades per student (M)\nN M:\n"
  end
end

class CliTest < Test::Unit::TestCase
  def setup
    @cli = Cli.new
  end

  def test_run_prompts_users_for_number_of_students_and_number_of_grades
    prompt = ''
    @cli.singleton_class.send(:define_method, :puts, ->(phrase) { prompt = phrase })
    @cli.run

    expected = "Please enter number of students (N) and grades per student (M)\nN M:\n"
    assert_equal expected, prompt
  end
end

class Course
  attr_accessor :students

  def average_grade
    self.students.map(&:average_grade).inject(&:+) / self.students.length
  end
end

class Student
  attr_accessor :grades

  def average_grade
    self.grades.inject(&:+) / self.grades.length
  end
end

class CourseTest < Test::Unit::TestCase
  def setup
    @course = Course.new
  end

  def test_average_reports_the_average_of_all_student_grades
    students = [
      Student.new.tap { |s| s.grades = [1, 2, 3] },
      Student.new.tap { |s| s.grades = [2, 3, 4] },
      Student.new.tap { |s| s.grades = [3, 4, 5] }
    ]
    @course.students = students

    assert_equal 3, @course.average_grade
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

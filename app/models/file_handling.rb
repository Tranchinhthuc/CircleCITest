class FileHandling
  require 'roo'
  def import_questions params
    files = params[:question][:files]
    question_type = params[:question][:type]
    send("import_#{question_type}", files)
  end

  private
  def get_correct_option option
    correct_option_by_string = {"a" => 0, "b" => 1, "c" => 2, "d" => 3}
    correct_option_by_string.each do |key, val|
      return val if option.include?(key)
    end
    nil
  end

  def import_part_one files
    spreadsheet = spreadsheet files
    audio_files = files.select{|f|File.extname(f.original_filename).in? [".mp3", ".wav"]}
    image_files = files.select{|f|File.extname(f.original_filename).in? [".png", ".bmp", ".jpeg", ".gif", ".jpg"]}
    total_of_rows = spreadsheet.last_row
    steps = (2..total_of_rows).to_a.select{|e| (e - 2)%4==0}

    steps.each_with_index do |question, index|
      content = ""
      correct_option = ""
      explanation = ""
      options = []
      4.times do |j|
        content += spreadsheet.row(question + j)[1] if spreadsheet.row(question + j)[1]
        options << spreadsheet.row(question + j)[2]
        correct_option += spreadsheet.row(question + j)[3] if spreadsheet.row(question + j)[3]
        explanation += spreadsheet.row(question + j)[4] if spreadsheet.row(question + j)[4]
      end
      part_one = PartOne.new(content: content, explanation: explanation,
        audio: audio_files.find{|audio| File.basename(audio.original_filename, File.extname(audio.original_filename)) == (index + 1).to_s},
        photo: image_files.find{|image| File.basename(image.original_filename, File.extname(image.original_filename)) == (index + 1).to_s})
      part_one.save(validate: false)
      sub_question = part_one.sub_questions.build
      options.each_with_index do |option, index|
        sub_question.options.build(content: option, correct: get_correct_option(correct_option) == index)
        sub_question.save(validate: false)
      end
    end
  end

  def import_part_two files
    spreadsheet = spreadsheet files
    audio_files = files.select{|f|File.extname(f.original_filename).in? [".mp3", ".wav"]}

    total_of_rows = spreadsheet.last_row
    steps = (2..total_of_rows).to_a.select{|e| (e - 2)%3==0}

    steps.each_with_index do |question, index|
      content = ""
      correct_option = ""
      explanation = ""
      options = []
      3.times do |j|
        content += spreadsheet.row(question + j)[1] if spreadsheet.row(question + j)[1]
        options << spreadsheet.row(question + j)[2]
        correct_option += spreadsheet.row(question + j)[3] if spreadsheet.row(question + j)[3]
        explanation += spreadsheet.row(question + j)[4] if spreadsheet.row(question + j)[4]
      end
      part_two = PartTwo.new(content: content, explanation: explanation,
        audio: audio_files.find{|audio| File.basename(audio.original_filename, File.extname(audio.original_filename)) == (index + 1).to_s})
      part_two.save(validate: false)
      sub_question = part_two.sub_questions.build
      options.each_with_index do |option, index|
        sub_question.options.build(content: option, correct: get_correct_option(correct_option) == index)
        sub_question.save(validate: false)
      end
    end
  end

  def import_part_three files
    spreadsheet = spreadsheet files
    audio_files = files.select{|f|File.extname(f.original_filename).in? [".mp3", ".wav"]}

    total_of_rows = spreadsheet.last_row
    steps = (3..total_of_rows).to_a.select{|e| (e - 3)%4==0}

    steps.each_with_index do |question_index, index|
      content = ""
      explanation = ""

      sub_questions = Array.new(3) do
        {
          content: "",
          option_correct: "",
          options: Array.new(4){ {content: ""} }
        }
      end
      3.times do |sub_question_index|
        options = []
        4.times do |j|
          content += spreadsheet.row(question_index + j)[2] if spreadsheet.row(question_index + j)[2]
          explanation += spreadsheet.row(question_index + j)[12] if spreadsheet.row(question_index + j)[12]

          sub_questions[sub_question_index][:content] += spreadsheet.row(question_index + j)[3*(sub_question_index+1)] if spreadsheet.row(question_index + j)[3*(sub_question_index+1)]
          sub_questions[sub_question_index][:option_correct] += spreadsheet.row(question_index + j)[5 + 3*sub_question_index] if spreadsheet.row(question_index + j)[5 + 3*sub_question_index]
          sub_questions[sub_question_index][:options][j][:content] = spreadsheet.row(question_index + j)[ 4 + 3*sub_question_index]
        end
      end
      part_three = PartThree.new(content: content, explanation: explanation,
        audio: audio_files.find{|audio| File.basename(audio.original_filename, File.extname(audio.original_filename)) == (index + 1).to_s})
      part_three.save(validate: false)
      sub_questions.each do |sub_question_hash|
        sub_question = part_three.sub_questions.build(content: sub_question_hash[:content])
        sub_question_hash[:options].each_with_index do |option, index|
          sub_question.options.build(content: option[:content], correct: get_correct_option(sub_question_hash[:option_correct]) == index)
          sub_question.save(validate: false)
        end
      end
    end
  end

  def import_part_four files
        spreadsheet = spreadsheet files
    audio_files = files.select{|f|File.extname(f.original_filename).in? [".mp3", ".wav"]}

    total_of_rows = spreadsheet.last_row
    steps = (3..total_of_rows).to_a.select{|e| (e - 3)%4==0}

    steps.each_with_index do |question_index, index|
      content = ""
      explanation = ""

      sub_questions = Array.new(3) do
        {
          content: "",
          option_correct: "",
          options: Array.new(4){ {content: ""} }
        }
      end
      3.times do |sub_question_index|
        options = []
        4.times do |j|
          content += spreadsheet.row(question_index + j)[2] if spreadsheet.row(question_index + j)[2]
          explanation += spreadsheet.row(question_index + j)[12] if spreadsheet.row(question_index + j)[12]

          sub_questions[sub_question_index][:content] += spreadsheet.row(question_index + j)[3*(sub_question_index+1)] if spreadsheet.row(question_index + j)[3*(sub_question_index+1)]
          sub_questions[sub_question_index][:option_correct] += spreadsheet.row(question_index + j)[5 + 3*sub_question_index] if spreadsheet.row(question_index + j)[5 + 3*sub_question_index]
          sub_questions[sub_question_index][:options][j][:content] = spreadsheet.row(question_index + j)[ 4 + 3*sub_question_index]
        end
      end
      part_three = PartFour.new(content: content, explanation: explanation,
        audio: audio_files.find{|audio| File.basename(audio.original_filename, File.extname(audio.original_filename)) == (index + 1).to_s})
      part_three.save(validate: false)
      sub_questions.each do |sub_question_hash|
        sub_question = part_three.sub_questions.build(content: sub_question_hash[:content])
        sub_question_hash[:options].each_with_index do |option, index|
          sub_question.options.build(content: option[:content], correct: get_correct_option(sub_question_hash[:option_correct]) == index)
          sub_question.save(validate: false)
        end
      end
    end
  end

  def import_part_five files
    spreadsheet = spreadsheet files
    total_of_rows = spreadsheet.last_row
    steps = (2..total_of_rows).to_a.select{|e| (e - 2)%4==0}

    steps.each_with_index do |question, index|
      content = ""
      correct_option = ""
      explanation = ""
      options = []
      4.times do |j|
        content += spreadsheet.row(question + j)[1] if spreadsheet.row(question + j)[1]
        options << spreadsheet.row(question + j)[2]
        correct_option += spreadsheet.row(question + j)[3] if spreadsheet.row(question + j)[3]
        explanation += spreadsheet.row(question + j)[4] if spreadsheet.row(question + j)[4]
      end
      part_five = PartFive.new(explanation: explanation)
      part_five.save(validate: false)
      sub_question = part_five.sub_questions.build(content: content)
      options.each_with_index do |option, index|
        sub_question.options.build(content: option, correct: get_correct_option(correct_option) == index)
        sub_question.save(validate: false)
      end
    end
  end

  def import_part_six files
    spreadsheet = spreadsheet files

    total_of_rows = spreadsheet.last_row
    steps = (3..total_of_rows).to_a.select{|e| (e - 3)%4==0}

    steps.each_with_index do |question_index, index|
      content = ""
      explanation = ""

      sub_questions = Array.new(3) do
        {
          content: "",
          option_correct: "",
          options: Array.new(4){ {content: ""} }
        }
      end
      3.times do |sub_question_index|
        options = []
        4.times do |j|
          content += spreadsheet.row(question_index + j)[2] if spreadsheet.row(question_index + j)[2]
          explanation += spreadsheet.row(question_index + j)[9] if spreadsheet.row(question_index + j)[9]

          sub_questions[sub_question_index][:option_correct] += spreadsheet.row(question_index + j)[4 + 2*sub_question_index] if spreadsheet.row(question_index + j)[4 + 2*sub_question_index]
          sub_questions[sub_question_index][:options][j][:content] = spreadsheet.row(question_index + j)[ 3 + 2*sub_question_index]
        end
      end
      part_six = PartSix.new(content: content, explanation: explanation)
      part_six.save(validate: false)
      sub_questions.each do |sub_question_hash|
        sub_question = part_six.sub_questions.build(content: sub_question_hash[:content])
        sub_question_hash[:options].each_with_index do |option, index|
          sub_question.options.build(content: option[:content], correct: get_correct_option(sub_question_hash[:option_correct]) == index)
          sub_question.save(validate: false)
        end
      end
    end
  end

  def import_part_seven_one files
    spreadsheet = spreadsheet files

    total_of_rows = spreadsheet.last_row
    steps = (3..total_of_rows).to_a.select{|e| (e - 3)%4==0}

    steps.each_with_index do |question_index, index|
      content = ""
      explanation = ""

      sub_questions = Array.new(5) do
        {
          content: "",
          option_correct: "",
          options: Array.new(4){ {content: ""} }
        }
      end
      5.times do |sub_question_index|
        options = []
        4.times do |j|
          content += spreadsheet.row(question_index + j)[2] if spreadsheet.row(question_index + j)[2]
          explanation += spreadsheet.row(question_index + j)[19] if spreadsheet.row(question_index + j)[19]

          sub_questions[sub_question_index][:content] += spreadsheet.row(question_index + j)[3*(sub_question_index+1)] if spreadsheet.row(question_index + j)[3*(sub_question_index+1)]
          sub_questions[sub_question_index][:option_correct] += spreadsheet.row(question_index + j)[5 + 3*sub_question_index] if spreadsheet.row(question_index + j)[5 + 3*sub_question_index]
          sub_questions[sub_question_index][:options][j][:content] = spreadsheet.row(question_index + j)[ 4 + 3*sub_question_index]
        end
      end
      part_seven_one = PartSevenOne.new(content: content, explanation: explanation)
      part_seven_one.save(validate: false)
      sub_questions.each do |sub_question_hash|
        if sub_question_hash[:content].present?
          sub_question = part_seven_one.sub_questions.build(content: sub_question_hash[:content])
          sub_question_hash[:options].each_with_index do |option, index|
            sub_question.options.build(content: option[:content], correct: get_correct_option(sub_question_hash[:option_correct]) == index)
            sub_question.save(validate: false)
          end
        end
      end
    end
  end

  def import_part_seven_two files
    spreadsheet = spreadsheet files

    total_of_rows = spreadsheet.last_row
    steps = (3..total_of_rows).to_a.select{|e| (e - 3)%4==0}

    steps.each_with_index do |question_index, index|
      passage_1 = ""
      passage_2 = ""
      explanation = ""

      sub_questions = Array.new(5) do
        {
          content: "",
          option_correct: "",
          options: Array.new(4){ {content: ""} }
        }
      end
      5.times do |sub_question_index|
        options = []
        4.times do |j|
          passage_1 += spreadsheet.row(question_index + j)[2] if spreadsheet.row(question_index + j)[2]
          passage_2 += spreadsheet.row(question_index + j)[3] if spreadsheet.row(question_index + j)[3]
          explanation += spreadsheet.row(question_index + j)[19] if spreadsheet.row(question_index + j)[19]

          sub_questions[sub_question_index][:content] += spreadsheet.row(question_index + j)[4 + 3*sub_question_index] if spreadsheet.row(question_index + j)[4 + 3*sub_question_index]
          sub_questions[sub_question_index][:option_correct] += spreadsheet.row(question_index + j)[6 + 3*sub_question_index] if spreadsheet.row(question_index + j)[6 + 3*sub_question_index]
          sub_questions[sub_question_index][:options][j][:content] = spreadsheet.row(question_index + j)[ 5 + 3*sub_question_index]
        end
      end
      part_seven_two = PartSevenTwo.new(content: "<p>#{passage_1}</p><p>#{passage_2}</p>", explanation: explanation)
      part_seven_two.save(validate: false)
      sub_questions.each do |sub_question_hash|
        sub_question = part_seven_two.sub_questions.build(content: sub_question_hash[:content])
        sub_question_hash[:options].each_with_index do |option, index|
          sub_question.options.build(content: option[:content], correct: get_correct_option(sub_question_hash[:option_correct]) == index)
          sub_question.save(validate: false)
        end
      end
    end
  end

  def spreadsheet files
    question_file = files.find{|f|File.extname(f.original_filename) == ".xlsx"}
    case File.extname(question_file.original_filename)
    when ".csv" then Roo::Csv.new(question_file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(question_file.path)
    else raise "Unknown file type: #{question_file.original_filename}"
    end
  end
end

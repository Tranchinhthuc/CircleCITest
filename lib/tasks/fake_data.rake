namespace :db do
  desc "Remaking data"
  task fake_data: :environment do

    puts "Fake data"
    puts "Reset"
    Rake::Task["db:migrate:reset"].invoke

    puts "Create users"

    10.times { |i| User.create(email: "thuc#{i}@gmail.com", password: "12341234", full_name: "tran thuc #{i}") }
    
    puts "Create Part 5-6-7 questions"

    [PartFive, PartSix, PartSevenOne, PartSevenTwo].each do |klass|
      10.times do
        object = klass.new content: Faker::Lorem.sentence
        if klass.in? [PartFive, PartSix, PartSevenTwo]
          number_of_sub_questions = SysConst::NUMBER_OF_SUB_QUESTIONS[ActiveModel::Naming.singular(klass).to_sym]
        else
          number_of_sub_questions = [2, 3, 4, 5].sample
        end
        number_of_sub_questions.times do
          sub_question = object.sub_questions.build content: Faker::Lorem.sentence
          correct_option = [0,1,2,3].sample
          4.times { |i| sub_question.options.build content: Faker::Lorem.sentence, correct: (i==correct_option) }
        end
        object.save
      end
    end
  end
end

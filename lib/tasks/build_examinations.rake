namespace :db do
  desc "Build examination"
  task build_examinations: :environment do

    puts "Build examination"

    # 10.times do |i|
    part_ones = PartOne.all.sample(10)
    part_twos = PartTwo.all.sample(30)
    part_threes = PartThree.all.sample(30)
    part_fours = PartFour.all.sample(30)
    part_fives = PartFive.all.sample(40)
    part_sixes = PartSix.all.sample(4)
    part_seven_ones = PartSevenOne.for_standard_examination
    part_seven_twos = PartSevenTwo.all.sample(4)
    listening_questions = part_ones + part_twos + part_threes + part_fours
    reading_questions = part_fives + part_sixes + part_seven_ones + part_seven_twos
    reading = Reading.create(questions: reading_questions)
    listening = Listening.create(questions: listening_questions)

    Examination.create reading: reading, listening: listening
    # end
  end
end

class SysConst
  PART_2_OPTIONS = {
    "A" => 1,
    "B" => 2,
    "C" => 3,
  }

  PART_1_OPTIONS = {
    "A" => 1,
    "B" => 2,
    "C" => 3,
    "D" => 4
  }

  QUESTION_LEVELS = {
    less_than_300: 1,
    from_300_to_450: 2,
    from_450_to_600: 3,
    from_600_to_750: 4,
    greater_than_750: 5
  }

  QUESTION_LEVELS_TO_S = {
    less_than_300: "0-300",
    from_300_to_450: "300-450",
    from_450_to_600: "450-600",
    from_600_to_750: "600-750",
    greater_than_750: "750-990",
  }

  NUMBER_OF_SUB_QUESTIONS = {
    part_one: 1,
    part_two: 1,
    part_three: 3,
    part_four: 3,
    part_five: 1,
    part_six: 3,
    part_seven_one: 2,
    part_seven_two: 5
  }

  OPTION_TO_STRING = ["A", "B", "C", "D"]

  PART_TWO_OPTION_TO_STRING = ["A", "B", "C"]

  TABLE_NAME = ["part_ones", "part_twos", "part_threes", "part_fours", "part_fives",
                "part_sixes", "part_seven_ones", "part_seven_twos"]

  QUESTION_TYPE_TO_STRING_1 = {
    part_one: "Photo",
    part_two: "Question-Response",
    part_three: "Short conversation",
    part_four: "Short Talks",
    part_five: "Incomplete Sentences",
    part_six: "Text Completion",
    part_seven_one: "Single passage",
    part_seven_two: "Double passage"
  }

  QUESTION_TYPE_TO_STRING_2 = {
    part_one: "Part 1",
    part_two: "Part 2",
    part_three: "Part 3",
    part_four: "Part 4",
    part_five: "Part 5",
    part_six: "Part 6",
    part_seven_one: "Part 7(Single passage)",
    part_seven_two: "Part 7(Double passage)"
  }

  QUESTION_TYPES = [:part_one, :part_two, :part_three, :part_four, :part_five, :part_six, :part_seven_one, :part_seven_two]

  QUESTION_TYPE_TO_STRING_3 = {
    part_one: "Part 1 - Photo",
    part_two: "Part 2 - Question-Response",
    part_three: "Part 3 - Short conversation",
    part_four: "Part 4 - Short Talks",
    part_five: "Part 5 - Incomplete Sentences",
    part_six: "Part 6 - Text Completion",
    part_seven_one: "Part 7 - Single passage",
    part_seven_two: "Part 7 - Double passage",
    reading: "Reading",
    listening: "Listening"
  }

  LESSON_TYPE_TO_STRING = {
    part_one_lesson: "Part 1 - Photo",
    part_two_lesson: "Part 2 - Question-Response",
    part_three_lesson: "Part 3 - Short conversation",
    part_four_lesson: "Part 4 - Short Talks",
    part_five_lesson: "Part 5 - Incomplete Sentences",
    part_six_lesson: "Part 6 - Text Completion",
    part_seven_one_lesson: "Part 7 - Single passage",
    part_seven_two_lesson: "Part 7 - Double passage",
    reading_lesson: "Reading",
    listening_lesson: "Listening"
  }

  COUNT_OF_OPTIONS = {
    part_one: 4,
    part_two: 3,
    part_three: 4,
    part_four: 4,
    part_five: 4,
    part_six: 4,
    part_seven_one: 4,
    part_seven_two: 4
  }

  RESOURCES_TOEIC_QUESTION_TYPES = [
    :part_ones, :part_twos, :part_threes, :part_fours,
    :part_fives, :part_sixes, :part_seven_ones, :part_seven_twos,
    :reading, :listening
  ]

  USER_SIDE_RESOURCES_TOEIC_QUESTION_TYPES = [
    :part_ones, :part_twos, :part_threes, :part_fours,
    :part_fives, :part_sixes, :part_seven_ones, :part_seven_twos
  ]

  LISTENING_TYPES = [:part_one, :part_two, :part_three, :part_four, :part_one_lesson, :part_two_lesson, :part_three_lesson, :part_four_lesson]
  READING_TYPES = [:part_five, :part_six, :part_seven_one, :part_seven_two]
  HAS_MANY_SUB_QUESTIONS = [:part_three, :part_four, :part_six, :part_seven_one, :part_seven_two]

  DIRECTIONS_BY_PART = {
    part_one: "Part 1",
    part_two: "Part 2",
    part_three: "Part 3",
    part_four: "Part 4",
    part_five: "Part 5",
    part_six: "Part 6",
    part_seven_one: "Part 7(Single passage)",
    part_seven_two: "Part 7(Double passage)"
  }

  TEST_TIME_BY_TYPE = {
    listening_lesson: 45*60,
    reading_lesson: 75*60,
    part_one_lesson: 10*60,
    part_two_lesson: 10*60,
    part_three_lesson: 15*60,
    part_four_lesson: 15*60,
    part_five_lesson: 10*60,
    part_six_lesson: 15*60,
    part_seven_one_lesson: 20*60,
    part_seven_two_lesson: 25*60
  }

  LESSON_TYPES = [  :part_one_lessons, :part_two_lessons, :part_three_lessons,
                    :part_four_lessons, :part_five_lessons, :part_six_lessons,
                    :part_seven_one_lessons, :part_seven_two_lessons,
                    :reading_lessons, :listening_lessons
  ]

  MERCHANT_ID = 47668
  MERCHANT_ACCOUNT = "thuctc91@gmail.com"
  MERCHANT_PASSWORD = Digest::MD5.hexdigest('47668' + "|" + "7f8040ee2a1462014f03d5cd1d57c3aa")
  MERCHANT_MOBILE = "01649614008"

  AVAILABLE_TYPE_CARDS = {
    viettel: ["Thẻ cào Viettel", "VIETTEL"],
    vinaphone: ["Thẻ cào VinaPhone", "VNP"],
    mobilephoe: ["Thẻ cào MobiFone", "VMS"],
    vtc_gate: ["Thẻ cào FPT Gate", "GATE"]
  }
end

require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
  # in order to score the dice you need to check for grouped values
  # I'd like to start by sorting the numbers so that we know how many of a number we have if we get to the next number

  # seq | pts
  # ___________
  # 111  ==  1000
  # xxx  == x * 100
  # 1  ==  100
  # 5  == 50


  # set total var
  total = 0 


    
  puts '-------'
  puts 'dice: '
  puts dice 
  puts '-------'

  puts '-------'
  puts 'length'
  puts dice.length
  puts '-------'

  # edge cases
  # 0 dice 
  if dice.length == 0 
    total
  end 
  # no dice
  if dice.length == 1
    total = calculate_die_score(dice[0], 1)
  end

  if dice.length > 1
  # step 1 order dice by num asc
    sorted = dice.sort
    puts '-------'
    puts 'sorted: '
    puts sorted 
    puts '-------'


    #step 2 establish two pointers
    counter = 0 

    while counter < sorted.length do 
      p1 = counter
      p2 = counter + 1
      puts 'counter 1: ', p1 
      puts 'counter 2: ' ,p2 


      #step 3 get value of first die
      d1 = sorted[p1]
      
      # step 4 check second die
      d2 = sorted[p2]

      puts '---------'
      puts 'd1 = ', d1
      puts 'd2 = ', d2
      puts '---------'

      #step 5 compare die 
      match = d1 == d2

      # if the values of the die don't match 
      if(!match) 
        total += calculate_die_score(d1, 1)
        counter += 1
      end

      if(match)
        # create pointer for third die
        p3 = counter + 2

        # get value of third die
        d3 = sorted[p3]

        # check if third die matches 
        match_2 = d2 == d3
        if(!match_2)
          # this means the first 2 die were the same but the third wasn't
          # so we will add the points of the first 2 die 
          total += calculate_die_score(d1, 2)

          # then we set pointer to third die
          counter += 2

        else
          # add triple score to total
          total += calculate_die_score(d1, 3)

          # set pointer 1 to fourth die
          counter += 3

        end


      end 


    end 

  end 

  puts 'total: ', total
  total

end

def calculate_die_score(num, multiplier)
  total = 0


  puts 'num', num
  puts 'multiplier', multiplier
  # for non triples
  if multiplier != 3 
    # only 1's and 5's have value
    if num == 1 
      total += 100 * multiplier 
    end
    if num == 5 
      total += 50 * multiplier 
    end 
  end 
  
  # for triples
  if multiplier == 3
    if num != 1
     total =  num * 100
    else 
      total = 1000
    end 
  end

  total 
end 



class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end

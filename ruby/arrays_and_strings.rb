class Arrays_And_Strings
  require 'set'

  def initialize()
     @name = name.capitalize
  end

  #Implement an algorithm to determine if a string has all unique characters.
  #What if you cannot use additional data structures?
  def unique?(string, additional_data_structures=true)
    if(additional_data_structures)
      unique_chars = Set.new()
      string.each do |char|
        unique_chars.add(char)
      end

      return unique_chars.length == string.length
    else
      (0..(string.length - 2)).each do |i|
        ((i + 1)..(string.length - 1)).each do |j|
          if(string[i] == string[j]) 
            return false
          end
        end
      end

      return true
    end
  end

  #given 2 strings decide if 1 is permutation of another
  def permutation?(a, b)
    if(a.length != b.length)
      false
    else
      char_counts(a) == char_counts(b)
    end
  end

  def char_counts(string)
    counts = Hash.new
    string.each do |char|
      if(counts.key?(char))
        counts[char] += 1
      else
        counts[char] = 1
      end
    end
  end

  #replace all spaces in a string with '%20'
  def urlify(string)
    string.strip.gsub(/ /, '%20')
  end

  def palindrome_permutation?(string)
    string.split("").uniq.length == ceil(string.length / 2.0)
  end
end

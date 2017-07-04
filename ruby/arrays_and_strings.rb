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

  #check if strings are 1 insertion, deletion, or replacement away from being the same
  def one_away?(a, b)
    if(abs(a.length - b.length) > 1)
      false
    #replacement?
    elsif(a.length == b.length)
      if(a == b)
        true
      else
        one_replacement?(a, b)
      end
    #insertion or deletion
    else
      if(a.length > b.length)
        one_deletion?(a, b)
      else
        one_deletion?(b, 1)
      end
    end
  end

  #based on length check we know if statement will always execute once
  def one_deletion?(one_delete, verifier)
    (0..(verifier.length - 1)).each do |i|
      if(one_delete[i] != verifier[i])
        return one_delete.insert(i, verifier[i]) == verifier
      end
    end
  end

  def one_replacement?(a, b)
    replacement? = false
    (0..(a.length - 1)).each do |i|
      if(a[i] != b[i])
        if(replacement?)
          return false;
        else
          replacement? = true
        end
      end
    end

    return true
  end
end

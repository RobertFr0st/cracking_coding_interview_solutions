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
        one_operation?(a, b, :setbyte)
      end
    #insertion or deletion
    else
      if(a.length > b.length)
        one_operation?(a, b, :insert)
      else
        one_operation?(b, a, :insert)
      end
    end
  end

  def one_operation?(target, verifier, operation)
    diff_index = target.zip(verifier).find_index { |x| x[0] != x[1] }
    operation.to_proc.call(target, diff_index, verifier[diff_index]) == verifier
  end

  #perform basic string compression using counts, aabcccccaaa -> a2b1c5a3
  #only compress if result is actually smaller
  def compress(string) 
    result = ""
    count = 0

    (0..(string.length - 2)).each do |i|
      count += 1
      if(string[i] != string[i + 1])
        result << "#{string[i]}#{count}"
        count = 0
      end
    end

    (result.length < string.length) ? result : string
  end

  #given an image representing an NxN matrix where each pixel is 4 bytes
  #rotate the image by 90 degrees.  Prefereably in place
  #since this is ruby we are going to assert each integer is 4 bytes even though it may not be
  def rotate_matrix(image, direction=:right)
    0..(image.length / 2 - 1) do |i|
      ((0 + i)..(image.length - 1 - i)).each do |j|
        ij0 = rotate_destination([i, j], direction)
        ij1 = rotate_destination(ij0, direction)
        ij2 = rotate_destination(ij0, direction)
        
        register              = image[ij0[0]]][ij0[1]]
        image[ij0[0]][ij0[1]] = image[i][j]
        image[i][j]           = image[ij2[0]]][ij2[1]]
        image[ij2[0]][ij3[1]] = image[ij1[0]]][ij1[1]]
        image[ij1[0]][ij1[1]] = register
      end
    end

    image
  end

  #thanks to negative index's we don't care about length
  def rotate_destination(ij, direction)
    i = ij[0]
    j = ij[1]

    if(direction == :right)
      [-1 - j, i]
    elsif(direction == :left)
      [j, -1 - i]
    else
     nil
    end
  end
end

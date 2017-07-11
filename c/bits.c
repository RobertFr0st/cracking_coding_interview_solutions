#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

//given a positive integer print the next largest & smallest number
//with same number of 1 bits
int* next_number(int number)
{
  int* high_low = (int*) malloc((2)*sizeof(int));


  //find lowest bit which is 1 and next bit is 0
  int high_bit;
  for(high_bit = 0; (1 << high_bit) <= number; high_bit++)
    if(((1 << high_bit) & number) && !((1 << (high_bit + 1)) & number))
      break;
  high_low[0] = number + (1 << high_bit);

  //find lowest bit where 1 is before 0
  int low_bit;
  for(low_bit = 0; (1 << low_bit) <= number; low_bit++)
    if(((1 << (low_bit + 1)) & number) && !((1 << low_bit) & number))
      break;

  //special case for all 1's need to shift by 1 then decrement
  if((1 << low_bit) > number)
    high_low[1] = (number << 1) - 1;
  else
    high_low[1] = number - (1 << (low_bit + 1));

  return high_low;
}

int set_bit(int bits, int bit_position)
{
  return bits | (1 << bit_position);
}

int is_bit_set(int bits, int bit_position)
{
  return (bits & (1 << bit_position)) != 0;
}

int score(int bits)
{
  int best_score = 0;
  int score = 0;
  int i;
  for(i = 0; (bits >> i) != 0; i++)
  {
    if(is_bit_set(bits, i))
    {
      score++;
    }
    else
    {
      if(score > best_score)
        best_score = score;
      score = 0;
    }
  }

  return best_score;
}

//find length of longest set of 1's, can only flip 1 bit
int flip_bit_to_win(int bits)
{
  int best_score = 0;
  int score;
  int i;
  for(i = 0; (bits >> i) != 0; i++)
  {
    score = score(set_bit(bits, i));
    if(score > best_score) best_score = score;
  }
  return best_score;
}

//given real number between 0 and 1
//convert to string representation if more than 32 chars print error
char* binary_to_sting(double decimal)
{
  char* binstring = (char*) malloc((32+1)*sizeof(char));

  int length = 0;
  while(decimal > 0)
  {
    if(length > 32)
      return strcpy(binstring, "ERROR");

    decimal *= 2;
    if(decimal > 1)
    {
      binstring[length] = '1';
      decimal -= 1;
    }
    else
    {
      binstring[length] = '0'
    }

    length++;
  }

  binstring[length] = '\0'

  return binstring;
}

//insert the parasite within the host such that parasite starts on 
//start should be the larger bit value (indexed from right)
//end should be the smaller bit value (indexed from right)
//parasite should not exceed host in size
int32_t insertion(int32_t host, int32_t parasite, int start, int end)
{
  //host: 000, parasite: 1, start = 1, end = 1
  int32_t mask = ~0;//111
  mask <<= start + 1;//100
  mask |= (~0) >> (32 - end);//101
  host &= mask;
  return host | (parasite << end);
}


//expected input format is function name then its arguments
int main(int argc, char **argv)
{
  if(strcmp(argv[1], "insertion") == 0)
    printf("%d\n", insertion(atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5])));
  else if(argv[1] == "binary_to_string")
    printf("%s\n", binary_to_string(atof(argv[2])));
  else if(argv[1] == "flip_bit_to_win")
    printf("%d\n", flip_bit_to_win(atoi(argv[2])));
  else if(argv[1] == "next_number")
  {
    int* next_numbers = next_number(argv[2]);
    printf("%d %d\n", next_numbers[0], next_numbers[1]);
  }
/*  else if(argv[1] == "debugger")
    return debugger()
  else if(argv[1] == "conversion")
    return conversion()
  else if(argv[1] == "pairwise_swap")
    return pairwise_swap()
  else
    return draw_line()
*/
  return 0;
}

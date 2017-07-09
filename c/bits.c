#include <stdint.h>
#include <stdlib.h>

//insert the parasite within the host such that parasite starts on 
//start should be the larger bit value (indexed from right)
//end should be the smaller bit value (indexed from right)
//parasite should not exceed host in size
int32_t insertion(int32_t host, int32_t parasite, int start, int end)
{
  //host: 000, parasite: 1, start = 1, end = 1
  int32_t mask = ~0;//111
  mask <<= start + 1//100
  mask |= (~0) >> (32 - end)//101
  host &= mask
  host |= (parasite << end)
}


//expected input format is function name then its arguments
int main(int argc, char **argv)
{
//  if(argv[1] == "insertion")
    return insertion(atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]))
/*  else if(argv[1] == "binary_to_string")
    return binary_to_string()
  else if(argv[1] == "flip_bit_to_win")
    return flip_bit_to_win()
  else if(argv[1] == "next_number")
    return next_number()
  else if(argv[1] == "debugger")
    return debugger()
  else if(argv[1] == "conversion")
    return conversion()
  else if(argv[1] == "pairwise_swap")
    return pairwise_swap()
  else
    return draw_line()
*/
}

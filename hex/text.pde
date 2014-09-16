
class Text
{
  Text c(char nextChar)
  {
    list.add(nextChar);
    return this;
  }
  
  Character get(int n)
  {
    return list.get(n);
  }
  
  ArrayList<Character> list = new ArrayList<Character>();
};

Text assembleSolution()
{
  Text t = new Text();

                        t.c('A').c('B').c('D').c('E').c('F').c('G').c('H')
                      .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
                  .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
               .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
           .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
        .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
    .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
        .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
           .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
               .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
                  .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
                      .c('I').c('J').c('J').c('J').c('J').c('J').c('J').c('J')
                         .c('A').c('B').c('D').c('E').c('F').c('G').c('H');
   
   println(t.list.size());
   
   return t;
}


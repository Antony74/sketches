
Text solution;

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

void assembleSolution()
{
  Text t = new Text();

                        t.c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
                      .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
                  .c('F').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
               .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
           .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
        .c('C').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
    .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
        .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
           .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
               .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
                  .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
                      .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ')
                         .c(' ').c(' ').c(' ').c(' ').c(' ').c(' ').c(' ');
   
   solution = t;
}


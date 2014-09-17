
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
   
   println(t.list.size());
   
   return t;
}


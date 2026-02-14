# fortify works for anosim objects

    Code
      fortify(dune_ano)
    Output
      # A tibble: 190 x 2
          rank class  
         <dbl> <fct>  
       1  37   Between
       2  34   SF     
       3  52   SF     
       4  91   Between
       5  88   Between
       6  61.5 Between
       7  96   Between
       8  77.5 Between
       9  70   Between
      10  66   Between
      # i 180 more rows

# tidy works for anosim objects

    Code
      tidy(dune_ano)
    Output
      # A tibble: 190 x 2
          rank class  
         <dbl> <fct>  
       1  37   Between
       2  34   SF     
       3  52   SF     
       4  91   Between
       5  88   Between
       6  61.5 Between
       7  96   Between
       8  77.5 Between
       9  70   Between
      10  66   Between
      # i 180 more rows


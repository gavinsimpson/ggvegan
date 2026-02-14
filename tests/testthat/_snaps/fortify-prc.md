# fortify works for prc objects

    Code
      fortify(pyrifos_prc)
    Output
      # A tibble: 222 x 5
         score  label   time  treatment response
         <fct>  <chr>   <fct> <fct>        <dbl>
       1 Sample 0.1|-4  -4    0.1        -0.133 
       2 Sample 0.1|-1  -1    0.1        -0.253 
       3 Sample 0.1|0.1 0.1   0.1        -0.188 
       4 Sample 0.1|1   1     0.1        -0.0748
       5 Sample 0.1|2   2     0.1        -0.386 
       6 Sample 0.1|4   4     0.1        -0.251 
       7 Sample 0.1|8   8     0.1        -0.149 
       8 Sample 0.1|12  12    0.1        -0.282 
       9 Sample 0.1|15  15    0.1        -0.206 
      10 Sample 0.1|19  19    0.1        -0.398 
      # i 212 more rows

# tidy works for prc objects

    Code
      tidy(pyrifos_prc)
    Output
      # A tibble: 222 x 5
         score  label   time  treatment response
         <fct>  <chr>   <fct> <fct>        <dbl>
       1 Sample 0.1|-4  -4    0.1        -0.133 
       2 Sample 0.1|-1  -1    0.1        -0.253 
       3 Sample 0.1|0.1 0.1   0.1        -0.188 
       4 Sample 0.1|1   1     0.1        -0.0748
       5 Sample 0.1|2   2     0.1        -0.386 
       6 Sample 0.1|4   4     0.1        -0.251 
       7 Sample 0.1|8   8     0.1        -0.149 
       8 Sample 0.1|12  12    0.1        -0.282 
       9 Sample 0.1|15  15    0.1        -0.206 
      10 Sample 0.1|19  19    0.1        -0.398 
      # i 212 more rows


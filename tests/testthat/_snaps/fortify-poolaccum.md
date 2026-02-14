# fortify works for poolaccum objects

    Code
      fortify(bci_pool)
    Output
      # A tibble: 240 x 6
         index  size richness lower upper std_dev
         <fct> <dbl>    <dbl> <dbl> <dbl>   <dbl>
       1 S         3     140.  129.  152.    6.60
       2 S         4     151.  143   163.    5.62
       3 S         5     159.  149   170     5.73
       4 S         6     166.  156   176.    5.30
       5 S         7     171.  161.  181     5.07
       6 S         8     176.  167   184.    4.63
       7 S         9     179.  170.  187     4.65
       8 S        10     183.  174   189     4.50
       9 S        11     186.  177   193     4.23
      10 S        12     188.  180   195     4.04
      # i 230 more rows

# tidy works for poolaccum objects

    Code
      tidy(bci_pool)
    Output
      # A tibble: 240 x 6
         index  size richness lower upper std_dev
         <fct> <dbl>    <dbl> <dbl> <dbl>   <dbl>
       1 S         3     140.  129.  152.    6.60
       2 S         4     151.  143   163.    5.62
       3 S         5     159.  149   170     5.73
       4 S         6     166.  156   176.    5.30
       5 S         7     171.  161.  181     5.07
       6 S         8     176.  167   184.    4.63
       7 S         9     179.  170.  187     4.65
       8 S        10     183.  174   189     4.50
       9 S        11     186.  177   193     4.23
      10 S        12     188.  180   195     4.04
      # i 230 more rows


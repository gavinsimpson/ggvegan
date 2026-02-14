# fortify works for decorana objects

    Code
      fortify(dune_dca)
    Output
      # A tibble: 50 x 6
         score label    dca1    dca2    dca3    dca4
         <fct> <chr>   <dbl>   <dbl>   <dbl>   <dbl>
       1 sites 1     -0.758  -1.34   -0.103  -0.0361
       2 sites 2     -0.533  -0.771   0.469  -0.298 
       3 sites 3      0.0669 -0.502  -0.0855 -0.479 
       4 sites 4      0.0803 -0.280   0.664  -0.0898
       5 sites 5     -1.04   -0.438  -0.207  -0.244 
       6 sites 6     -0.915  -0.184  -0.637   0.0348
       7 sites 7     -0.916  -0.415  -0.261   0.0284
       8 sites 8      0.775   0.0804 -0.103   0.0102
       9 sites 9      0.245  -0.218  -0.339  -0.124 
      10 sites 10    -0.927  -0.439   0.549   0.111 
      # i 40 more rows

# tidy works for decorana objects

    Code
      tidy(dune_dca)
    Output
      # A tibble: 50 x 6
         score label    dca1    dca2    dca3    dca4
         <fct> <chr>   <dbl>   <dbl>   <dbl>   <dbl>
       1 sites 1     -0.758  -1.34   -0.103  -0.0361
       2 sites 2     -0.533  -0.771   0.469  -0.298 
       3 sites 3      0.0669 -0.502  -0.0855 -0.479 
       4 sites 4      0.0803 -0.280   0.664  -0.0898
       5 sites 5     -1.04   -0.438  -0.207  -0.244 
       6 sites 6     -0.915  -0.184  -0.637   0.0348
       7 sites 7     -0.916  -0.415  -0.261   0.0284
       8 sites 8      0.775   0.0804 -0.103   0.0102
       9 sites 9      0.245  -0.218  -0.339  -0.124 
      10 sites 10    -0.927  -0.439   0.549   0.111 
      # i 40 more rows


# fortify works for metaMDS objects

    Code
      fortify(dune_mds)
    Output
      # A tibble: 50 x 4
         score label   nmds1   nmds2
         <fct> <chr>   <dbl>   <dbl>
       1 sites 1     -0.841  -0.716 
       2 sites 2     -0.505  -0.409 
       3 sites 3     -0.0827 -0.437 
       4 sites 4     -0.116  -0.522 
       5 sites 5     -0.627  -0.0867
       6 sites 6     -0.543   0.113 
       7 sites 7     -0.540  -0.0582
       8 sites 8      0.281  -0.167 
       9 sites 9      0.111  -0.443 
      10 sites 10    -0.517   0.0274
      # i 40 more rows

# tidy works for metaMDS objects

    Code
      tidy(dune_mds)
    Output
      # A tibble: 50 x 4
         score label   nmds1   nmds2
         <fct> <chr>   <dbl>   <dbl>
       1 sites 1     -0.841  -0.716 
       2 sites 2     -0.505  -0.409 
       3 sites 3     -0.0827 -0.437 
       4 sites 4     -0.116  -0.522 
       5 sites 5     -0.627  -0.0867
       6 sites 6     -0.543   0.113 
       7 sites 7     -0.540  -0.0582
       8 sites 8      0.281  -0.167 
       9 sites 9      0.111  -0.443 
      10 sites 10    -0.517   0.0274
      # i 40 more rows


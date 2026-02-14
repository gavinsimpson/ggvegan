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

# fortify & tidy work for metaMDS with dist

    Code
      fortify(dune_mds_no_spp)
    Output
      # A tibble: 20 x 4
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
      11 sites 11    -0.338   0.351 
      12 sites 12     0.442  -0.364 
      13 sites 13     0.419  -0.583 
      14 sites 14     0.943   0.476 
      15 sites 15     0.896   0.222 
      16 sites 16     1.08   -0.180 
      17 sites 17    -0.860   0.987 
      18 sites 18    -0.177   0.523 
      19 sites 19    -0.0700  1.01  
      20 sites 20     1.04    0.253 

---

    Code
      tidy(dune_mds_no_spp)
    Output
      # A tibble: 20 x 4
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
      11 sites 11    -0.338   0.351 
      12 sites 12     0.442  -0.364 
      13 sites 13     0.419  -0.583 
      14 sites 14     0.943   0.476 
      15 sites 15     0.896   0.222 
      16 sites 16     1.08   -0.180 
      17 sites 17    -0.860   0.987 
      18 sites 18    -0.177   0.523 
      19 sites 19    -0.0700  1.01  
      20 sites 20     1.04    0.253 


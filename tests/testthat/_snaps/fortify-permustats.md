# fortify works for permustats objects

    Code
      fortify(permu_adonis)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model       -1.79
       2 Model       -2.17
       3 Model       -1.64
       4 Model       -2.01
       5 Model       -1.97
       6 Model       -1.62
       7 Model       -2.07
       8 Model       -1.70
       9 Model       -2.36
      10 Model       -1.73
      # i 989 more rows

---

    Code
      fortify(permu_ano)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 R         -0.233 
       2 R         -0.362 
       3 R         -0.308 
       4 R         -0.315 
       5 R         -0.174 
       6 R         -0.205 
       7 R         -0.227 
       8 R         -0.312 
       9 R          0.0120
      10 R         -0.235 
      # i 989 more rows

---

    Code
      fortify(permu_cca)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model      -0.263
       2 Model      -0.757
       3 Model      -0.629
       4 Model      -0.721
       5 Model      -0.638
       6 Model      -0.606
       7 Model      -0.685
       8 Model      -0.670
       9 Model      -0.840
      10 Model      -0.617
      # i 989 more rows

---

    Code
      fortify(permu_rda)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model      -0.619
       2 Model      -0.949
       3 Model      -0.925
       4 Model      -1.11 
       5 Model      -1.06 
       6 Model      -0.669
       7 Model      -0.942
       8 Model      -0.952
       9 Model      -1.18 
      10 Model      -0.964
      # i 989 more rows

---

    Code
      fortify(permu_prc)
    Output
      # A tibble: 99 x 2
         term  permutation
         <fct>       <dbl>
       1 RDA1        -8.85
       2 RDA1       -10.1 
       3 RDA1        -8.94
       4 RDA1       -10.3 
       5 RDA1        -4.29
       6 RDA1        -6.42
       7 RDA1        -8.04
       8 RDA1        -7.29
       9 RDA1        -9.48
      10 RDA1        -9.20
      # i 89 more rows

# tidy works for permustats objects

    Code
      tidy(permu_adonis)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model       -1.79
       2 Model       -2.17
       3 Model       -1.64
       4 Model       -2.01
       5 Model       -1.97
       6 Model       -1.62
       7 Model       -2.07
       8 Model       -1.70
       9 Model       -2.36
      10 Model       -1.73
      # i 989 more rows

---

    Code
      tidy(permu_ano)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 R         -0.233 
       2 R         -0.362 
       3 R         -0.308 
       4 R         -0.315 
       5 R         -0.174 
       6 R         -0.205 
       7 R         -0.227 
       8 R         -0.312 
       9 R          0.0120
      10 R         -0.235 
      # i 989 more rows

---

    Code
      tidy(permu_cca)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model      -0.263
       2 Model      -0.757
       3 Model      -0.629
       4 Model      -0.721
       5 Model      -0.638
       6 Model      -0.606
       7 Model      -0.685
       8 Model      -0.670
       9 Model      -0.840
      10 Model      -0.617
      # i 989 more rows

---

    Code
      tidy(permu_rda)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model      -0.619
       2 Model      -0.949
       3 Model      -0.925
       4 Model      -1.11 
       5 Model      -1.06 
       6 Model      -0.669
       7 Model      -0.942
       8 Model      -0.952
       9 Model      -1.18 
      10 Model      -0.964
      # i 989 more rows

---

    Code
      tidy(permu_prc)
    Output
      # A tibble: 99 x 2
         term  permutation
         <fct>       <dbl>
       1 RDA1        -8.85
       2 RDA1       -10.1 
       3 RDA1        -8.94
       4 RDA1       -10.3 
       5 RDA1        -4.29
       6 RDA1        -6.42
       7 RDA1        -8.04
       8 RDA1        -7.29
       9 RDA1        -9.48
      10 RDA1        -9.20
      # i 89 more rows

# tidy works for permustats objects with scale

    Code
      fortify(permu_cca, scale = TRUE)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model       -1.44
       2 Model       -4.13
       3 Model       -3.43
       4 Model       -3.93
       5 Model       -3.48
       6 Model       -3.31
       7 Model       -3.73
       8 Model       -3.65
       9 Model       -4.58
      10 Model       -3.36
      # i 989 more rows

---

    Code
      tidy(permu_cca, scale = TRUE)
    Output
      # A tibble: 999 x 2
         term  permutation
         <fct>       <dbl>
       1 Model       -1.44
       2 Model       -4.13
       3 Model       -3.43
       4 Model       -3.93
       5 Model       -3.48
       6 Model       -3.31
       7 Model       -3.73
       8 Model       -3.65
       9 Model       -4.58
      10 Model       -3.36
      # i 989 more rows


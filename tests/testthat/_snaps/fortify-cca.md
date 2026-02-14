# fortify works for cca objects

    Code
      fortify(dune_pca)
    Output
      # A tibble: 50 x 8
         score   label         pc1     pc2      pc3      pc4     pc5     pc6
         <fct>   <chr>       <dbl>   <dbl>    <dbl>    <dbl>   <dbl>   <dbl>
       1 species Achimill  0.604   -0.124   0.00846  0.160   -0.409  -0.128 
       2 species Agrostol -1.37     0.964   0.167    0.266    0.0877 -0.0474
       3 species Airaprae -0.0234  -0.251  -0.195   -0.326   -0.0557  0.0796
       4 species Alopgeni -0.531    1.43   -0.505   -0.0429   0.443  -0.279 
       5 species Anthodor  0.559   -0.568  -0.476    0.0158  -0.344   0.136 
       6 species Bellpere  0.334    0.189   0.141   -0.0842  -0.125  -0.135 
       7 species Bromhord  0.523    0.197   0.164    0.00567 -0.386  -0.258 
       8 species Chenalbu -0.0175   0.0546 -0.0553  -0.0106  -0.0266 -0.0164
       9 species Cirsarve -0.00240  0.102   0.0637  -0.0487   0.0321  0.0361
      10 species Comapalu -0.169   -0.105   0.0636   0.0524  -0.131  -0.108 
      # i 40 more rows

---

    Code
      fortify(dune_ca)
    Output
      # A tibble: 50 x 8
         score   label        ca1     ca2    ca3      ca4     ca5     ca6
         <fct>   <chr>      <dbl>   <dbl>  <dbl>    <dbl>   <dbl>   <dbl>
       1 species Achimill  0.909  -0.0846  0.586 -0.00892 -0.660  -0.189 
       2 species Agrostol -0.934   0.207  -0.282  0.0243  -0.139  -0.0226
       3 species Airaprae  1.00   -3.07   -1.34   0.194   -1.08   -0.537 
       4 species Alopgeni -0.401   0.618  -0.850  0.347    0.0165  0.102 
       5 species Anthodor  0.967  -1.08    0.172  0.460   -0.608  -0.304 
       6 species Bellpere  0.500   0.355   0.152 -0.704   -0.0585  0.0731
       7 species Bromhord  0.658   0.406   0.307 -0.497   -0.561   0.0700
       8 species Chenalbu -0.424   0.844  -1.59   1.25    -0.207   0.876 
       9 species Cirsarve  0.0565  0.764  -0.918 -1.18    -0.384  -0.140 
      10 species Comapalu -1.92   -0.522   1.18  -0.0217  -1.36    1.31  
      # i 40 more rows

---

    Code
      fortify(dune_rda)
    Output
      # A tibble: 90 x 8
         score   label       rda1     rda2       rda3    rda4    rda5     rda6
         <fct>   <chr>      <dbl>    <dbl>      <dbl>   <dbl>   <dbl>    <dbl>
       1 species Achimill  0.598  -0.111    0.0923     0.0490 -0.0751  0.272  
       2 species Agrostol -1.18    0.963    0.194      0.227   0.261   0.108  
       3 species Airaprae -0.111  -0.205    0.0183    -0.180   0.0796  0.108  
       4 species Alopgeni -0.491   1.42     0.0492    -0.210  -0.126  -0.121  
       5 species Anthodor  0.421  -0.369   -0.219      0.0134  0.214   0.483  
       6 species Bellpere  0.375  -0.00458  0.133     -0.0719  0.0840  0.227  
       7 species Bromhord  0.547   0.0669   0.263      0.0629 -0.109   0.347  
       8 species Chenalbu -0.0333  0.0454   0.0000779  0.0106  0.0194  0.0362 
       9 species Cirsarve  0.0205  0.0912   0.0664    -0.0236  0.0943  0.00858
      10 species Comapalu -0.198  -0.107   -0.00589    0.183  -0.0969 -0.0371 
      # i 80 more rows

---

    Code
      fortify(dune_cca)
    Output
      # A tibble: 90 x 8
         score   label      cca1   cca2    cca3    cca4    cca5    cca6
         <fct>   <chr>     <dbl>  <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
       1 species Achimill  0.841 -0.438 -0.150   0.275   0.0510  0.236 
       2 species Agrostol -0.765  0.481  0.0317  0.147   0.221   0.0954
       3 species Airaprae -0.733 -1.75   1.15   -0.109   0.246   0.482 
       4 species Alopgeni -0.345  1.03   0.364   0.113  -0.0402 -0.0165
       5 species Anthodor  0.390 -0.830  0.0306 -0.167   0.316   0.447 
       6 species Bellpere  0.707 -0.251  0.0109  0.490   0.158   0.409 
       7 species Bromhord  0.832 -0.119 -0.145   0.655   0.0944  0.283 
       8 species Chenalbu -0.973  1.30   0.517   0.0117  1.37   -0.252 
       9 species Cirsarve  0.429  0.741  0.495   0.977   1.07    0.601 
      10 species Comapalu -2.01  -0.351 -2.28    0.110  -0.485   1.20  
      # i 80 more rows

# tidy works for cca objects

    Code
      tidy(dune_pca)
    Output
      # A tibble: 50 x 8
         score   label         pc1     pc2      pc3      pc4     pc5     pc6
         <fct>   <chr>       <dbl>   <dbl>    <dbl>    <dbl>   <dbl>   <dbl>
       1 species Achimill  0.604   -0.124   0.00846  0.160   -0.409  -0.128 
       2 species Agrostol -1.37     0.964   0.167    0.266    0.0877 -0.0474
       3 species Airaprae -0.0234  -0.251  -0.195   -0.326   -0.0557  0.0796
       4 species Alopgeni -0.531    1.43   -0.505   -0.0429   0.443  -0.279 
       5 species Anthodor  0.559   -0.568  -0.476    0.0158  -0.344   0.136 
       6 species Bellpere  0.334    0.189   0.141   -0.0842  -0.125  -0.135 
       7 species Bromhord  0.523    0.197   0.164    0.00567 -0.386  -0.258 
       8 species Chenalbu -0.0175   0.0546 -0.0553  -0.0106  -0.0266 -0.0164
       9 species Cirsarve -0.00240  0.102   0.0637  -0.0487   0.0321  0.0361
      10 species Comapalu -0.169   -0.105   0.0636   0.0524  -0.131  -0.108 
      # i 40 more rows

---

    Code
      tidy(dune_ca)
    Output
      # A tibble: 50 x 8
         score   label        ca1     ca2    ca3      ca4     ca5     ca6
         <fct>   <chr>      <dbl>   <dbl>  <dbl>    <dbl>   <dbl>   <dbl>
       1 species Achimill  0.909  -0.0846  0.586 -0.00892 -0.660  -0.189 
       2 species Agrostol -0.934   0.207  -0.282  0.0243  -0.139  -0.0226
       3 species Airaprae  1.00   -3.07   -1.34   0.194   -1.08   -0.537 
       4 species Alopgeni -0.401   0.618  -0.850  0.347    0.0165  0.102 
       5 species Anthodor  0.967  -1.08    0.172  0.460   -0.608  -0.304 
       6 species Bellpere  0.500   0.355   0.152 -0.704   -0.0585  0.0731
       7 species Bromhord  0.658   0.406   0.307 -0.497   -0.561   0.0700
       8 species Chenalbu -0.424   0.844  -1.59   1.25    -0.207   0.876 
       9 species Cirsarve  0.0565  0.764  -0.918 -1.18    -0.384  -0.140 
      10 species Comapalu -1.92   -0.522   1.18  -0.0217  -1.36    1.31  
      # i 40 more rows

---

    Code
      tidy(dune_rda)
    Output
      # A tibble: 90 x 8
         score   label       rda1     rda2       rda3    rda4    rda5     rda6
         <fct>   <chr>      <dbl>    <dbl>      <dbl>   <dbl>   <dbl>    <dbl>
       1 species Achimill  0.598  -0.111    0.0923     0.0490 -0.0751  0.272  
       2 species Agrostol -1.18    0.963    0.194      0.227   0.261   0.108  
       3 species Airaprae -0.111  -0.205    0.0183    -0.180   0.0796  0.108  
       4 species Alopgeni -0.491   1.42     0.0492    -0.210  -0.126  -0.121  
       5 species Anthodor  0.421  -0.369   -0.219      0.0134  0.214   0.483  
       6 species Bellpere  0.375  -0.00458  0.133     -0.0719  0.0840  0.227  
       7 species Bromhord  0.547   0.0669   0.263      0.0629 -0.109   0.347  
       8 species Chenalbu -0.0333  0.0454   0.0000779  0.0106  0.0194  0.0362 
       9 species Cirsarve  0.0205  0.0912   0.0664    -0.0236  0.0943  0.00858
      10 species Comapalu -0.198  -0.107   -0.00589    0.183  -0.0969 -0.0371 
      # i 80 more rows

---

    Code
      tidy(dune_cca)
    Output
      # A tibble: 90 x 8
         score   label      cca1   cca2    cca3    cca4    cca5    cca6
         <fct>   <chr>     <dbl>  <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
       1 species Achimill  0.841 -0.438 -0.150   0.275   0.0510  0.236 
       2 species Agrostol -0.765  0.481  0.0317  0.147   0.221   0.0954
       3 species Airaprae -0.733 -1.75   1.15   -0.109   0.246   0.482 
       4 species Alopgeni -0.345  1.03   0.364   0.113  -0.0402 -0.0165
       5 species Anthodor  0.390 -0.830  0.0306 -0.167   0.316   0.447 
       6 species Bellpere  0.707 -0.251  0.0109  0.490   0.158   0.409 
       7 species Bromhord  0.832 -0.119 -0.145   0.655   0.0944  0.283 
       8 species Chenalbu -0.973  1.30   0.517   0.0117  1.37   -0.252 
       9 species Cirsarve  0.429  0.741  0.495   0.977   1.07    0.601 
      10 species Comapalu -2.01  -0.351 -2.28    0.110  -0.485   1.20  
      # i 80 more rows


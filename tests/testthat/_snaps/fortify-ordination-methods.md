# fortify works for cca like objects

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

---

    Code
      fortify(dune_pco)
    Output
      # A tibble: 20 x 8
         score label     mds1   mds2   mds3   mds4    mds5    mds6
         <fct> <chr>    <dbl>  <dbl>  <dbl>  <dbl>   <dbl>   <dbl>
       1 sites 1     -0.857    0.172 -2.61   1.13  -0.451   2.49  
       2 sites 2     -1.64     1.23  -0.887  0.986 -2.03   -1.81  
       3 sites 3     -0.440    2.38  -0.930  0.460  1.03    0.0518
       4 sites 4      0.0479   2.05  -1.27   0.974  0.642   0.721 
       5 sites 5     -1.62    -0.290  1.59  -1.54  -1.86    2.21  
       6 sites 6     -1.97    -1.08   1.15  -3.35   1.52   -0.0313
       7 sites 7     -1.79    -0.322  0.220 -1.47  -0.0125  0.426 
       8 sites 8      0.890    1.09  -0.925 -0.516  1.09   -0.948 
       9 sites 9      0.00904  1.66   0.466  0.283  0.108   2.17  
      10 sites 10    -1.91    -0.494 -0.706 -0.268 -1.37   -2.62  
      11 sites 11    -1.04    -1.21  -1.42   0.957  2.72   -1.11  
      12 sites 12     1.02     1.46   3.25   0.325  1.75   -1.02  
      13 sites 13     0.699    2.18   2.21   0.423 -1.07   -0.656 
      14 sites 14     1.49    -0.977 -0.545 -0.273 -2.39   -2.48  
      15 sites 15     1.89    -1.13  -0.727 -0.773 -0.221   0.318 
      16 sites 16     2.85     0.208 -0.704 -2.10  -0.293   0.0812
      17 sites 17     0.0467  -1.73   0.914  1.67  -1.80    1.56  
      18 sites 18    -0.269   -1.72  -0.165  0.577  2.10   -0.339 
      19 sites 19     0.281   -2.19   1.99   3.23   0.458   0.0239
      20 sites 20     2.34    -1.30  -0.903 -0.718  0.0757  0.969 

---

    Code
      fortify(dune_dbrda)
    Output
      # A tibble: 69 x 8
         score label  dbrda1   dbrda2 dbrda3 dbrda4 dbrda5 dbrda6
         <fct> <chr>   <dbl>    <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
       1 sites 1     -0.980   0.00752 -1.73   1.12   2.75   2.35 
       2 sites 2     -1.73   -0.845   -1.80   0.409 -2.33  -3.44 
       3 sites 3     -0.597  -2.49    -1.58   0.989  1.22   0.711
       4 sites 4     -0.0978 -2.15    -1.93   1.05   2.34  -0.873
       5 sites 5     -1.72    0.329    3.40  -0.987  1.73  -2.40 
       6 sites 6     -2.11    0.831    2.75  -2.75  -0.481  2.33 
       7 sites 7     -1.91    0.305    0.812 -1.46   0.562  0.955
       8 sites 8      0.811  -1.27    -1.23  -1.47  -0.894  0.227
       9 sites 9     -0.0647 -1.75     2.16   1.63  -1.84  -0.109
      10 sites 10    -1.97    0.718   -1.87  -1.08  -1.78  -2.89 
      # i 59 more rows

# tidy works for cca like objects

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
      # A tibble: 99 x 8
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
      # i 89 more rows

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

---

    Code
      tidy(dune_pco)
    Output
      # A tibble: 20 x 8
         score label     mds1   mds2   mds3   mds4    mds5    mds6
         <fct> <chr>    <dbl>  <dbl>  <dbl>  <dbl>   <dbl>   <dbl>
       1 sites 1     -0.857    0.172 -2.61   1.13  -0.451   2.49  
       2 sites 2     -1.64     1.23  -0.887  0.986 -2.03   -1.81  
       3 sites 3     -0.440    2.38  -0.930  0.460  1.03    0.0518
       4 sites 4      0.0479   2.05  -1.27   0.974  0.642   0.721 
       5 sites 5     -1.62    -0.290  1.59  -1.54  -1.86    2.21  
       6 sites 6     -1.97    -1.08   1.15  -3.35   1.52   -0.0313
       7 sites 7     -1.79    -0.322  0.220 -1.47  -0.0125  0.426 
       8 sites 8      0.890    1.09  -0.925 -0.516  1.09   -0.948 
       9 sites 9      0.00904  1.66   0.466  0.283  0.108   2.17  
      10 sites 10    -1.91    -0.494 -0.706 -0.268 -1.37   -2.62  
      11 sites 11    -1.04    -1.21  -1.42   0.957  2.72   -1.11  
      12 sites 12     1.02     1.46   3.25   0.325  1.75   -1.02  
      13 sites 13     0.699    2.18   2.21   0.423 -1.07   -0.656 
      14 sites 14     1.49    -0.977 -0.545 -0.273 -2.39   -2.48  
      15 sites 15     1.89    -1.13  -0.727 -0.773 -0.221   0.318 
      16 sites 16     2.85     0.208 -0.704 -2.10  -0.293   0.0812
      17 sites 17     0.0467  -1.73   0.914  1.67  -1.80    1.56  
      18 sites 18    -0.269   -1.72  -0.165  0.577  2.10   -0.339 
      19 sites 19     0.281   -2.19   1.99   3.23   0.458   0.0239
      20 sites 20     2.34    -1.30  -0.903 -0.718  0.0757  0.969 

---

    Code
      tidy(dune_dbrda)
    Output
      # A tibble: 69 x 8
         score label  dbrda1   dbrda2 dbrda3 dbrda4 dbrda5 dbrda6
         <fct> <chr>   <dbl>    <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
       1 sites 1     -0.980   0.00752 -1.73   1.12   2.75   2.35 
       2 sites 2     -1.73   -0.845   -1.80   0.409 -2.33  -3.44 
       3 sites 3     -0.597  -2.49    -1.58   0.989  1.22   0.711
       4 sites 4     -0.0978 -2.15    -1.93   1.05   2.34  -0.873
       5 sites 5     -1.72    0.329    3.40  -0.987  1.73  -2.40 
       6 sites 6     -2.11    0.831    2.75  -2.75  -0.481  2.33 
       7 sites 7     -1.91    0.305    0.812 -1.46   0.562  0.955
       8 sites 8      0.811  -1.27    -1.23  -1.47  -0.894  0.227
       9 sites 9     -0.0647 -1.75     2.16   1.63  -1.84  -0.109
      10 sites 10    -1.97    0.718   -1.87  -1.08  -1.78  -2.89 
      # i 59 more rows

# fortify works for cca with layers length 1

    Code
      fortify(dune_cca, layers = "sites")
    Output
      # A tibble: 20 x 8
         score label    cca1   cca2    cca3    cca4    cca5   cca6
         <fct> <chr>   <dbl>  <dbl>   <dbl>   <dbl>   <dbl>  <dbl>
       1 sites 1      1.22    0.422  0.546   1.09    0.790  -2.12 
       2 sites 2      0.862   0.177  0.0575  1.50    0.144   1.15 
       3 sites 3      0.317   0.969  0.648   0.900   0.544  -0.314
       4 sites 4      0.243   0.872  0.812   1.51    1.38    1.18 
       5 sites 5      1.14   -0.283 -0.774  -1.34    1.01    1.17 
       6 sites 6      1.03   -0.371 -1.34   -2.05    0.494  -0.983
       7 sites 7      1.03   -0.153 -0.743  -0.918  -0.0579 -0.832
       8 sites 8     -0.696   0.670 -0.0344  0.263   0.515  -1.17 
       9 sites 9      0.0576  1.10   0.832  -1.18   -1.47    0.728
      10 sites 10     0.963  -0.646 -0.595   1.48   -0.194   0.951
      11 sites 11     0.508  -0.826 -0.0477  1.28   -2.62   -2.67 
      12 sites 12    -0.342   1.60   1.05   -0.827  -2.31    0.772
      13 sites 13    -0.469   1.60   0.965  -0.0778  0.471   0.205
      14 sites 14    -2.02   -0.300 -2.84    1.03   -0.915   0.736
      15 sites 15    -1.96   -0.103 -2.33   -0.321   0.129   1.49 
      16 sites 16    -1.93    0.588 -1.01    0.136   1.45   -1.70 
      17 sites 17     0.391  -2.69   1.15   -0.128   1.25    3.54 
      18 sites 18     0.302  -1.40   0.352   0.139  -1.74   -1.26 
      19 sites 19    -0.671  -2.69   3.08   -0.652  -0.278   1.65 
      20 sites 20    -2.02   -1.04   0.346  -1.03    1.22   -1.93 

---

    Code
      tidy(dune_cca, layers = "sites")
    Output
      # A tibble: 20 x 8
         score label    cca1   cca2    cca3    cca4    cca5   cca6
         <fct> <chr>   <dbl>  <dbl>   <dbl>   <dbl>   <dbl>  <dbl>
       1 sites 1      1.22    0.422  0.546   1.09    0.790  -2.12 
       2 sites 2      0.862   0.177  0.0575  1.50    0.144   1.15 
       3 sites 3      0.317   0.969  0.648   0.900   0.544  -0.314
       4 sites 4      0.243   0.872  0.812   1.51    1.38    1.18 
       5 sites 5      1.14   -0.283 -0.774  -1.34    1.01    1.17 
       6 sites 6      1.03   -0.371 -1.34   -2.05    0.494  -0.983
       7 sites 7      1.03   -0.153 -0.743  -0.918  -0.0579 -0.832
       8 sites 8     -0.696   0.670 -0.0344  0.263   0.515  -1.17 
       9 sites 9      0.0576  1.10   0.832  -1.18   -1.47    0.728
      10 sites 10     0.963  -0.646 -0.595   1.48   -0.194   0.951
      11 sites 11     0.508  -0.826 -0.0477  1.28   -2.62   -2.67 
      12 sites 12    -0.342   1.60   1.05   -0.827  -2.31    0.772
      13 sites 13    -0.469   1.60   0.965  -0.0778  0.471   0.205
      14 sites 14    -2.02   -0.300 -2.84    1.03   -0.915   0.736
      15 sites 15    -1.96   -0.103 -2.33   -0.321   0.129   1.49 
      16 sites 16    -1.93    0.588 -1.01    0.136   1.45   -1.70 
      17 sites 17     0.391  -2.69   1.15   -0.128   1.25    3.54 
      18 sites 18     0.302  -1.40   0.352   0.139  -1.74   -1.26 
      19 sites 19    -0.671  -2.69   3.08   -0.652  -0.278   1.65 
      20 sites 20    -2.02   -1.04   0.346  -1.03    1.22   -1.93 


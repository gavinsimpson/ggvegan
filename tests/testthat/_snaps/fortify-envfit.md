# fortify works for envfit objects

    Code
      fortify(dune_envfit)
    Output
      # A tibble: 5 x 4
        label     type        CA1     CA2
        <chr>     <chr>     <dbl>   <dbl>
      1 A1        Vector   -0.556 -0.0338
      2 Moisture1 Centroid  0.748  0.142 
      3 Moisture2 Centroid  0.465  0.216 
      4 Moisture4 Centroid -0.183  0.732 
      5 Moisture5 Centroid -1.11  -0.571 

# tidy works for envfit objects

    Code
      tidy(dune_envfit)
    Output
      # A tibble: 5 x 4
        label     type        CA1     CA2
        <chr>     <chr>     <dbl>   <dbl>
      1 A1        Vector   -0.556 -0.0338
      2 Moisture1 Centroid  0.748  0.142 
      3 Moisture2 Centroid  0.465  0.216 
      4 Moisture4 Centroid -0.183  0.732 
      5 Moisture5 Centroid -1.11  -0.571 


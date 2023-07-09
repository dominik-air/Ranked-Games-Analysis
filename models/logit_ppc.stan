generated quantities {
  real alpha = normal_rng(0, 1);
  real beta_gold = normal_rng(0, 1);
  real beta_exp = normal_rng(0, 1);

  // the data is normalized, so I expect the values to lie between -5 and 5
  real goldDiff = uniform_rng(-5, 5); 
  real expDiff = uniform_rng(-5, 5);
  
  real eta = alpha + beta_gold * goldDiff + beta_exp * expDiff;
  real p = inv_logit(eta); 
  
  int <lower=0, upper=1> gameWon_pred = bernoulli_rng(p); 
}

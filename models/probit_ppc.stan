generated quantities {
  real alpha = normal_rng(0, 1);
  real beta_gold = normal_rng(0, 1);
  real beta_exp = normal_rng(0, 1);
  real beta_dakda = normal_rng(0, 1);
  real beta_em = normal_rng(0, 1);
  real beta_minions = normal_rng(0, 1);
  real beta_towers = normal_rng(0, 1);

  // variables are normalized, so I expect the values to lie between -5 and 5
  real goldDiff = uniform_rng(-5, 5); 
  real expDiff = uniform_rng(-5, 5);
  real DAKDA = uniform_rng(-5, 5);
  real minionsDiff = uniform_rng(-5, 5);
  real EMDiff = uniform_rng(-5, 5);
  real towersDiff = uniform_rng(-5, 5);
  
  real eta = alpha + beta_gold * goldDiff + beta_exp * expDiff + beta_dakda * DAKDA + beta_em * EMDiff + beta_minions * minionsDiff + beta_towers * towersDiff;
  real p = Phi(eta);
  
  int <lower=0, upper=1> gameWon_pred = bernoulli_rng(p); 
}

data {
  int<lower=0> N;
}

parameters {
  real alpha;
  real<lower=0> beta_gold;
  real<lower=0> beta_exp;
}

model {
  alpha ~ normal(0, 1);
  beta_gold ~ normal(0, 1);
  beta_exp ~ normal(0, 1);
}

generated quantities {
  real<lower=0, upper=1> gameWon_pred[N];
  real goldDiff_sim[N];
  real expDiff_sim[N];
  
  for (n in 1:N) {
    goldDiff_sim[n] = normal_rng(0, 2500); 
    expDiff_sim[n] = normal_rng(0, 3000);
    
    real eta = alpha + beta_gold * goldDiff_sim[n] + beta_exp * expDiff_sim[n];
    real p = inv_logit(eta); 
    
    gameWon_pred[n] = bernoulli_rng(p); 
  }
}

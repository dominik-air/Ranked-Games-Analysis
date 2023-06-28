data {
  int<lower=0> N;
  real goldDiff[N];
  real expDiff[N];
  int<lower=0, upper=1> gameWon[N]; 
}

parameters {
  real alpha;
  real beta_gold;
  real beta_exp;
}

model {
  alpha ~ normal(0, 1);
  beta_gold ~ normal(0, 1);
  beta_exp ~ normal(0, 1);

  for (n in 1:N) {
    real eta = alpha + beta_gold * goldDiff[n] + beta_exp * expDiff[n];
    gameWon[n] ~ bernoulli_logit(eta);
  }
}

generated quantities {
  int gameWon_pred[N];  

  for (n in 1:N) {
    real eta = alpha + beta_gold * goldDiff[n] + beta_exp * expDiff[n];
    gameWon_pred[n] = bernoulli_logit_rng(eta);
  }
}

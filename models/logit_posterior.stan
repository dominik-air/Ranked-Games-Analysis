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

transformed parameters {
  vector[N] eta;
  for (n in 1:N) {
    eta[n] = alpha + beta_gold * goldDiff[n] + beta_exp * expDiff[n];
  }
  vector[N] p;
  p = inv_logit(eta);
}

model {
  alpha ~ normal(0, 1);
  beta_gold ~ normal(0, 1);
  beta_exp ~ normal(0, 1);

  for (n in 1:N) {
    gameWon[n] ~ bernoulli(p[n]);
  }
}

generated quantities {
  vector[N] log_lik;
  int gameWon_pred[N];  

  for (n in 1:N) {
    log_lik[n] = bernoulli_lpmf(gameWon[n]| p[n]);
    gameWon_pred[n] = bernoulli_rng(p[n]);
  }
}

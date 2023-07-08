data {
  int<lower=0> N; 
  real goldDiff[N];
  real expDiff[N];
  int<lower=0, upper=1> gameWon[N]; 
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
  for (n in 1:N) {
    gameWon[n] ~ bernoulli(Phi(alpha + beta_gold * goldDiff[n] + beta_exp * expDiff[n]));
  }
}

generated quantities {
  vector[N] log_lik;
  int<lower=0, upper=1> gameWon_pred[N];
  for (n in 1:N) {
    real eta = alpha + beta_gold * goldDiff[n] + beta_exp * expDiff[n];
    real p = Phi(eta);
    log_lik[n] = bernoulli_lpmf(gameWon[n]| p);
    gameWon_pred[n] = bernoulli_rng(p);
  }
}

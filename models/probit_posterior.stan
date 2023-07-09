data {
  int<lower=0> N; 
  real DAKDA[N];
  real EMDiff[N];
  real minionsDiff[N];
  real towersDiff[N];
  real goldDiff[N];
  real expDiff[N];
  int<lower=0, upper=1> gameWon[N]; 
}

parameters {
  real alpha;
  real beta_gold;
  real beta_exp;
  real beta_dakda;
  real beta_em;
  real beta_minions;
  real beta_towers;
}

transformed parameters {
  vector[N] eta;
  for (n in 1:N) {
    eta[n] = alpha + beta_gold * goldDiff[n] + beta_exp * expDiff[n] + beta_dakda * DAKDA[n] + beta_em * EMDiff[n] + beta_minions * minionsDiff[n] + beta_towers * towersDiff[n];
  }
  vector[N] p;
  p = Phi(eta);
}

model {
  alpha ~ normal(0, 1);
  beta_gold ~ normal(0, 1);
  beta_exp ~ normal(0, 1);
  beta_dakda ~ normal(0, 1);
  beta_em ~ normal(0, 1);
  beta_minions ~ normal(0, 1);
  beta_towers ~ normal(0, 1);

  for (n in 1:N) {
    gameWon[n] ~ bernoulli(p[n]);
  }
}

generated quantities {
  vector[N] log_lik;
  int<lower=0, upper=1> gameWon_pred[N];
  for (n in 1:N) {
    log_lik[n] = bernoulli_lpmf(gameWon[n]| p[n]);
    gameWon_pred[n] = bernoulli_rng(p[n]);
  }
}

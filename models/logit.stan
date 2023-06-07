data {
  int<lower=0> N;  
  int<lower=0, upper=1> y[N];  
  matrix[N,7] X;  
}

parameters {
  vector[7] beta;  
}

model {
  y ~ bernoulli_logit(X * beta);
  beta ~ normal(0,10);  
}

data {
  int<lower=0> N;
  int<lower=0, upper=1> y[N];  
  matrix[N,7] X;  
}

parameters {
  vector[7] beta;  
  real<lower=0, upper=1> phi; 
}

model {
  y ~ bernoulli(Phi_approx(X * beta / phi));
  beta ~ normal(0,10);  
  phi ~ cauchy(0,5);  
}

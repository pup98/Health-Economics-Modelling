
# -------------- Static Markov Cohort Simulation in Illness Death Model ----------

# Number of cycles 
n_t = 10

# Number of states
n_s = 3

# Cohort size
n_c = 500

# state_names
v_state_names = c("Healthy","Diseased","Dead")

# Probability matrix
m_p = matrix(c(0.94,0.04,0.01, 
               0.00,0.95,0.05, 
               0.00,0.00,1.00),nrow =3, ncol=3, 
             byrow = TRUE, dimnames= list(from= v_state_names, to= v_state_names))

m_p


# Cohort Simulation
state_membership = array(NA_real_, dim= c(n_t,n_s), dimnames= 
                           list(cycle= 1:n_t, state = v_state_names))

state_membership

state_membership[1,] = c(n_c,0,0)
state_membership

for (i in 2 :n_t) {
  state_membership[i, ] = state_membership[i-1, ] %*% m_p
}

state_membership

# Cost and Quality  ... 
m_payoffs <- matrix(c( 40, 23, 0,
                       0.9,  0.4, 0),
                    nrow = 3, ncol = 2, byrow = FALSE,
                    dimnames = list(state = v_state_names,payoff = c("Cost", "QALY")))
m_payoffs

payoff_trace <- state_membership %*% m_payoffs

payoff_trace

colSums(payoff_trace) / n_c


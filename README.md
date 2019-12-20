# Statistical analysis of perisaccadic responses [[View Article]](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1007275)

In this paper, three perisaccadic response modulations were studied: saccadic suppression, FF-remapping, and ST-remapping. Saccadic suppression was defined as a significant decrease in the mean firing rate of the neuron over the early response window (50-75 ms after stimulus onset) in response to a stimulus presented in the RF probe location shortly before a saccade (-30 to 0 ms from saccade onset), compared to the same stimulus presented during fixation (-500 to -100 ms from saccade onset). In the same way, the FF- and ST-remapping in a neuron were defined as increases in the mean firing rate of the neuron in the late response window (80-150 ms after stimulus onset) to a stimulus presented in the FF or ST probe location shortly before saccade (-50 to 0 ms from saccade onset) compared to the same stimulus presented during fixation (-500 to -100 ms from saccade onset). In all three cases, the statistical significance was tested by comparing the perisaccadic and fixation firing rates using the Wilcoxon one-sided signed-rank test, and a p-value of less than 0.05 was considered statistically significant.
Note that all statistical analyses were performed on spike counts without any smoothing. For graphical purposes, however, the spike trains were smoothed by convolving with a 21 ms Gaussian window. The response of a neuron to a stimulus presented in a given time interval was estimated by averaging the stimulus-aligned spike trains from 0 to 150 ms after stimulus onset. Due to differences in the mean firing activity of MT neurons, their perisaccadic and fixation responses were normalized by dividing by the grand mean of their firing rates (from 0-150 ms after onset of a stimulus, across both conditions) before averaging over a population of neurons.

## S-model framework 

We developed a state-variable generalized linear model framework, termed the S-model, which is able to track the saccade-induced rapid changes occurring in the spatiotemporal sensitivity of the neurons on a millisecond timescale. The principal idea of the S-model is that the stimulus-response relationship in a neuron is characterized by a set of time-varying stimulus kernels (k[t,τ]), which represent the spatiotemporal receptive field of the neuron as varying along the time dimension (t). The time dimension represents a millisecond scale change in the state of the neuron. Fixing the stimulus kernels along the time dimension results in the conventional time-invariant stimulus kernels (k[τ]) used in ordinary generalized linear models (GLMs) [67] [44]. More specifically, the conditional intensity function (CIF) of the S-model, representing the instantaneous firing rate of an MT neuron, i.e., λ(l)[t], under our experimental paradigm is described by,

λ(l)[t] = f(∑x,y,τ kx,y[t,τ] . sx,y(l)[t−τ] + ∑τ h[τ] . rh(l)[t−τ] + b[t] + b0), (1)

where sx,y(l)[t]∈{0,1} denotes a temporal sequence of probe stimuli presented at probe location (x,y) on trial l where 0 and 1 representing respectively an off and on probe condition, rh(l)[t]∈{0,1} indicates the spiking history of the neuron on that trial, kx,y[t,τ]represents the time-varying stimulus kernel corresponding to the stimulus being presented at probe location (x,y),h[τ] is the post-spike kernel applied on the spike train history, b[t] is the offset kernel which captures the saccade-induced changes in the baseline activity of the neuron over the time course of the experiment, b0=f−1(r0) where r0 is the average firing rate of the neuron, and finally,

f(u) = rmax / (1+exp(−u)), (2)

is a static logistic function representing the response nonlinear properties where rmax indicates the maximum firing rate of the neuron obtained experimentally. Compared with the empirical nonlinearity estimated nonparametrically from data, this choice of model nonlinearity adequately captured the nonlinear properties of the neurons&#39; response. All trials were saccade aligned, i.e., t=0 refers to the time when a saccade is initiated. All the kernels were parameterized as a linear combination of a set of basis functions defined across time and/or delay variables as follows,

kx,y[t,τ] = ∑i,j κx,y,i,j . Bi,j[t,τ], (3)

h[τ] = −∑i ηi^2 . Hi[τ], (4)

b[t] = ∑j βj . Bj[t], (5)

where {κx,y,i,j}, {ηi}, and {βj} are the basis parameters of the stimulus kernels, post-spike kernel, and offset kernel respectively. Since the basis functions {Hi[τ]} were set to be positive and the post-spike kernel was set to reflect only the response refractory effects, the negative square of the basis parameters {ηi} were used such that the resulting h[τ] produced a non-positive kernel. The basis parameters representing the time-varying stimulus kernels were set as follows,

Bi,j[t,τ] = Bi[τ]Bj[t], (6)

where Bi[τ] and Bj[t]were chosen to be B-spline functions of order two. {Bi[τ]} span over the delay variable τ, representing a 150 ms-long kernel using a set of 26 uniformly spaced knots, and {Bj[t]} span over the time variable t, representing a 1081 ms-long temporal profile centered at the saccade onset using a set of 159 uniformly spaced knots. The basis functions {Hi[τ]} representing the post-spike kernel were chosen to be B-spline functions of order two with non-uniformly distributed 23 knots over the delay variable τ; the spacing of the knots around time zero indicating the spike time was smaller and increased as getting away from the spike time and its associated refractory period. From equations (1,3-5) together,

λ(l)[t] = f(∑x,y,τ,i,j κx,y,i,j . Bi,j[t,τ] . sx,y(l)[t−τ] − ∑τ,i ηi^2 . Hi[τ] . rh(l)[t−τ] + ∑j βj . Bj[t] + b0). (7)

Similar to the classical GLM, the S-model assumes that spikes are generated according to an inhomogeneous Poisson process. Equation (7) denotes the CIF of the spiking process described by the S-model. The probability of a spike train associated with this Poisson process is thus given by,

p(r|s) = ∏t p(r[t]|s) ∝ ∏t (∆λ[t])^r[t] exp(−∆λ[t]), (8)

where s is the sequence of input stimuli, and r={r[t]} represents the sequence of binned spike counts with bins of size ∆ ms. Here, the bin size was chosen equal to 1 ms which ensures that at most one spike can fall in each time bin. The point process log-likelihood (LL) [45] of the observed spike trains given the model is,

({κx,y,i,j},{ηi},{βj}) = ∑l,t (r(l)[t] . log(λ(l)[t]∆) − λ(l)[t]∆). (9)

 {κx,y,i,j}, {ηi}, and {βj} are estimated by maximizing the log-likelihood function given in equation (9). The choice of nonlinear function in the S-model&#39;s CIF guaranteed an efficient maximum likelihood estimation (MLE) procedure[67], and the log-concavity of the S-model&#39;s CIF guaranteed a single global maximum solution, and therefore a unique set of fitted kernels.

To avoid overfitting despite the high dimensionality of the S-model, multiple computational approaches were adopted. First, representing each model kernel using a linear combination of smooth basis functions resulted in an optimization process in a lower dimensional space and with well-behaved search paths. Second, a coordinate ascent method was used as an efficient search strategy in the parameter space. In this method, for each iteration, the model was fitted over a subset of parameters while the rest were held fixed. This alternating strategy gave a stable solution for the data and with regard to different initializations of the parameters (similar to Ahrens et al. [68]), and benefited the convergence time of the estimation procedure. Lastly, to handle the sparsity of spiking data measured from the MT neurons relative to the size of the parameter space, and to avoid overfitting of the S-model to the training dataset, two additional techniques were employed: (1) A cross-validation approach was used to regularize the model parameters. In this approach, the data were randomly split into a training set (35%), a validation set (30%), and a test set (35%). To estimate the model parameters, the likelihood function in equation (9) was maximized over the spike trains from the training set and was evaluated over the validation set to ensure that the likelihood of the validation data also increases over iterations, otherwise the estimation was terminated. The test data were withheld from the model fitting procedure and were used to measure the model goodness-of-fit, ensuring the generalizability of the fitted model to unseen data. (2) A parameter selection strategy was used to provide an efficient distribution of the model parameters based on the relative importance of the associated kernels. In this strategy, the basis parameters {κx,y,i,j}, which comprise the majority of the model parameters, were ranked according to their significance in response prediction, and the less significant ones were eliminated by the following procedure: first, the model&#39;s CIF was assumed to be obtained by a single κx,y,i,j and with no dependency on the spike train history or the fluctuations in the baseline activity. To fit this simplified model, an MLE procedure was performed over 100 subsets of the data, each one obtained by randomly selecting 65% of the data (35% as training and 30% as validation) to generate a distribution of the estimated values for κx,y,i,j. To evaluate the significance of κx,y,i,j, a control distribution of this parameter was constructed using the same strategy but with a set of shuffled responses. A κx,y,i,j parameter was assessed as a significant parameter for response prediction if the mean of its distribution (μx,y,i,j) satisfied the following condition:

|μx,y,i,j − μ´x,y,i,j| ≥ 1.5 σ´x,y,i,j, (10)

where μ´x,y,i,j, and σ´x,y,i,j are the mean and standard deviation of the control distribution. Those κx,y,i,j parameters that were detected as significant were included in the model fitting and otherwise were set to zero. This regularization imposed sparsity over the parameter set and recovered a more coherent structure in the neuron&#39;s spatiotemporal sensitivity across both the delay and state variables, providing a detailed map of the neuron&#39;s state-dependent spatiotemporal dynamics with no concern of overfitting.

## F-model framework

Although the S-model can capture the RF dynamics and thus can characterize the response modulation on the timescale of a saccade, it does not identify explicitly what sources contribute to the response modulation. The idea of identifying modulatory sources was inspired by the perisaccadic response modulations observed in the experimental data, including the saccadic suppression, FF-remapping, and ST-remapping. In fact, the stimulus kernels fitted using the S-model, S-kernels, closely resemble a time-varying mixture of spatial Gaussians where each Gaussian captures response modulation arising from one of the RF, FF, or ST sources. To quantitatively dissociate the effects of RF, FF, and ST sources, a factorized state-variable generalized linear model, called the F-model, was developed which approximates the fitted S-kernels kx,y[t,τ] by k^x,y[t,τ] as:

k^x,y[t,τ] = k~x,y[τ] + ∑sr Gsr(x,y;φsr) + c, (11)

where k~x,y[τ], termed the fixation kernel, represents the average spatiotemporal receptive field of the neuron over the fixation period obtained by averaging the S-kernels kx,y[t,τ] over a time window of (-400:-300) ms from saccade; crepresents the state- and delay-dependent baseline profile, which is uniform across spatial dimensions; and finally each Gsr(x,y;φsr) specifies a spatial Gaussian kernel representing the state- and delay-dependent spatial profile of each modulation source sr∈{RF,FF,ST} parametrized by φsr={a,μx,μy,σx,σy,ρ,γx,γy} as follows,

Gsr(x,y;φsr) = a exp(−1/2/(1−ρ2) {(x−μx)^2/σx^2 + (y−μy)^2/σy^2 − 2ρ(x−μx)(y−μy)/σxσy}) Φ(γx(x−μx)) Φ(γy(y−μy)), (12)

wherea, μx, μy, σx, σy, ρ, and (γx,γy) represent the amplitude, the x- and y-coordinate of the center, the horizontal and vertical spread, the orientation, and the horizontal and vertical skewness of each Gaussian kernel, which vary across different states and delays, and Φ(∙) indicates the normal cumulative distribution function.

Each F-kernel k^x,y[t,τ] is a statistically optimal estimate of the S-kernel kx,y[t,τ] such that the mean squared error of the estimation specified in equation (11) was minimized,

∑x,y (k^x,y[t,τ]−kx,y[t,τ])^2. (13)

The minimization is subject to a set of bounded limits on the parameters φsr to ensure constraining them within the effective spatial activation area of each modulation source.

## A-model framework

After confirming the goodness-of-fit of the S- and F-models over test data, all trials (and not only those withheld for model testing) for each cell were employed for the rest of the analyses in this study to provide more accurate empirical measures from the experimental data. Moreover, in order to exploit the maximum information provided by the recordings, an aggregate F-model, termed the A-model, was developed. The A-model was constructed by (1) fitting the S-model ten times as explained earlier, on different randomly selected subsets of the data (2) fitting ten F-models corresponding to each fitted S-model, (3) averaging the model variables (φ_srs, and c) obtained from each F-model in order to gain a set of aggregate variables, and finally, (4) constructing the A-model kernels using the aggregate variables through equation (11). The A-model, as seen in Fig 4, outperformed the other models in capturing the perisaccadic changes in neurons’ responses.

# References

44- Simoncelli EP, Paninski L, Pillow J, Schwartz O. Characterization of neural responses with stochastic stimuli. In Gazzaniga M, editor. The Cognitive Neurosciences III. 3rd ed.: MIT Press; 2004. p. 327-338.

45- Paninski L, Pillow JW, Simoncelli EP. Maximum Likelihood Estimation of a Stochastic Integrate-and-Fire Neural Encoding Model. Neural computation. 2004; 16(12): p. 2533-61.

67- Paninski L. Maximum likelihood estimation of cascade point-process neural encoding models. Network: Computation in Neural Systems. 2004; 15: p. 243–262.

68- Ahrens MB, Paninski L, Sahani M. Inferring input nonlinearities in neural encoding models. Network: Computation in Neural Systems. 2008; 19(1).

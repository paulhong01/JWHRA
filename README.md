# JWHRA
This repository simulates JWHRA algorithm in LTE-A wireless networks. JHWRA algorithm is a MAC layer resource allocation algorithm for green power base stations with user equipments equipped with wireless chargin devices. Our simulations indicate that by using our proposed algorithms, the energy efficiency can improve 15% compared to traditional LTE-A networks. Our algorithm was developed by using non-linear fractional programming and dual decomposition. 

If you are a developer that are going to construct network simulations, our repo can also help you implement your simulations quickly. In the following, I will explain the parts of our repo that might be able to help you.


# <h3> How to use our code
- param.m: This is a parameter file that you can set up your setting like numbers of UE.
- Main_prog.m: This is the main program of JWHRA algorithm. You can also modify your algorithm here to run your simulations.
- sc_generator.m: This part generates base stations (small cells for different power levels) within a given distance.
- ue_generator.m: This code deploys UE in the BS coverage.
- pathloss_largescale.m: This part generates large scale fading.
- small_scale.m: This part generates small scale fading.




Hello! This repository contains data and R analysis for our manustcript comparing the effects of low- and high-intensity herbicide treatment on the propagule pressure, 
seed viability, and herbicide reistance of Phragmites australis in Suisun Marsh, CA.

HerbDMG.csv includes data analyzed in the evaluation of herbicide resistance on a 0-5 scale,
  (0 means no evidence of plant death, 5 means completely dead), averages are included in this file.

GerminationData.csv includes raw data from germination trials to determine seed viability.

prpgl_prsr.csv includes all other data for each site and patch including: 
  flr_strp: weight of all spikelets stripped from the collected inflorescence, 
  seeds_mean: mean number of seeds per spikelet, 
  spk_wt: weight of 60 spikelets,
  spk_flr: spikelets per inflorescence as estimated by calculating from spk_wt and flr_strp,
  mean_flr_dns: mean inflorescence density per m2 of Phragmites Australis,
  germ_rate: mean germination rate as calculated from GerminationData,
  seed_flr: seeds per inflorescence as calculated by multiplying spk_flr and seeds_mean,
  prop_prsr_m2: propagule pressure per m2 of Phragmites as calculated by multiplying seed_flr and mean_flr_dns,
  phrag_marsh: area of Phragmites per m2 of marsh in each land parcel calculated by dividing the area of Phragmites within a land parcel by the total area of that parcel,
  prop_prsr_marsh: propagule pressure per m2 of marshland as calculated by multiplying prop_prsr_m2 by phrag_marsh

all_club_cover.csv includes phrag_marsh data for all land parcels in Suisun Marsh, even those where seeds were not collected, 
to increase n for both high and low intensity treatments in the comparison of Phragmites area cover marsh-wide.

propagule_pressure.R includes t-tests comparing the following between low- and high-intensity herbicide treatment parcels:
  seeds per spikelet, 
  spikelets per inflorescence,
  inflorescnece weight,
  inflorescnece density per m2,
  Phragmites area per m2 of marsh (includes analysis for sampled parcels and all land parcels (all_club_cover),
  propagule pressure per m2 of Phragmites,
  propagule pressure per m2 of marsh,
  seed germination rate.

SeedProductionAndHerbDamageAnalysis.R includes anaysis of herbicide damage results as well as an additional analysis of seed production/propagule pressure to verify significance.
  
  


  
  
  
  

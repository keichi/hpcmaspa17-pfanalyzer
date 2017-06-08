# Conclusion

This paper described the design and implementation of PFAnalyzer, a toolset
for analyzing the performance characteristics of application-aware dynamic
interconnects. PFAnalyzer is composed of PFProf, a profiler to extract
communication patterns from applications, and PFSim, a simulator capable of
simulating application-aware dynamic interconnects. PFSim takes a set
of communication patterns of applications and a cluster configuration as its
input and then simulates the traffic on each link of the interconnect.
Our evaluation shows how dynamically controlling the interconnects can reduce
congestion and potentially improve the performance of applications.

Further works are necessary to investigate the performance characteristics of
dynamic interconnects on large-scale and highly-parallel clusters. Moreover,
we plan to implement application-aware node selection and process placement
algorithms on PFSim. The impact of such application-aware algorithm on the
performance of dynamic interconnects should be evaluated.

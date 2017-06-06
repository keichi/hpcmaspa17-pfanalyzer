# Conclusion

This paper described the design and implementation of a toolset for analyzing
the performance characteristics of application-aware dynamic interconnects.
The proposed toolset is composed of a profiler to extract communication
patterns from applications and a simulator capable of simulating
application-aware dynamic interconnects. Our simulator takes a set of
communication patterns of applications and a cluster configuration as its
input and then simulates the traffic on each link of the interconnect.

Further work is needed to investigate the performance characteristics of
dynamic interconnects on large-scale and highly-parallel clusters. Moreover,
application-aware node selection and process placement algorithms should be
implemented on the proposed simulator and investigated their effect on the
performance of dynamic interconnects.

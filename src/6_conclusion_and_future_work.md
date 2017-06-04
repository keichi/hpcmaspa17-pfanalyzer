# Conclusion

This paper describes the design and implementation of an
interconnect simulator specialized for dynamic interconnects to facilitate the
research and development of such interconnects. Our simulator takes
a set of communication patterns of applications and a cluster configuration as
its input and then simulates the congestion on each link of the interconnect.
In addition to the simulator, we have developed a custom profiler to extract
communication patterns from applications for use in conjunction with our
proposed simulator.

Further work is needed to investigate the performance characteristics of
dynamic interconnects on large-scale and highly-parallel clusters. Moreover,
application-aware node selection and process placement algorithms should be
implemented on the proposed simulator and investigated their effect on the
performance of dynamic interconnects.

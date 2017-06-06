# Related Work

Several interconnect simulators have been proposed in the past researches.
PSINS\ [@Tikir2009] is a trace-driven simulator for HPC applications.
Traces obtained from applications are used to predict the performance of
applications on a variety of HPC clusters with different configurations.
LogGOPSim\ [@Hoefler2010] simulates the execution of MPI applications based on
the LogGOP network model. Both simple synthetic communication patterns and
communication patterns converted from traces of MPI applications can be fed
into the simulator. A limitation of LogGOPSim is that the interconnect is
assumed to have full bisection bandwidth and congestion is not simulated.
These two simulators can provide accurate performance predictions owing to
their per-message simulation capability.

However, PSINS and LogGOPSim do not simulate specific interconnect topologies
nor routing algorithms. Therefore, these simulators are not suitable for
in-depth research of interconnects. In contrast, our simulator allows users to
compare the performance characteristic of different topologies and routing
algorithms.

ORCS\ [@Schneider2009] simulates the congestion of each link in the
interconnect for a given topology, communication pattern and routing
algorithm. The simulated congestion of links can be summarized into various
performance metrics and used for further analysis. A limitation of ORCS is
that only pre-defined communication patterns can be used as its input.
Moreover, ORCS assumes static routing as in InfiniBand. On the contrary,
our simulator can handle dynamic routing algorithms that use communication
patterns of applications and interconnect usage to make routing decisions.

In [@Jo2015], simulations are carried out to examine the performance
characteristics of an SDN-based multipath routing algorithm for data center
networks. A simulator is developed based on MiniSSF to simulate the throughput
and delay of a packet flow under diverse settings. However, communication
patterns are randomly generated and not based on real-world applications. Our
proposed simulator accepts arbitrary communication patterns obtained from
real-world applications using our custom profiler.

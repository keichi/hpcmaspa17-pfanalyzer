# Related Work

Several interconnect simulators have been proposed in previous researches.
PSINS\ [@Tikir2009] is a trace-driven simulator for HPC applications.
Traces obtained from applications are used to predict the performance
applications on variety of HPC clusters with different configurations.
LogGOPSim\ [@Hoefler2010] simulates the execution of MPI applications based on
the LogGOP network model. Both simple synthetic communication patterns and
communication patterns converted from traces of MPI applications can be fed
into the simulator. A limitation of LogGOPSim is that the interconnect is
assumed to have full bisection bandwidth and congestion is ignored. Both
simulators can provide accurate performance predictions owing to their
per-message simulation capability.

However, PSINS and LogGOPSim do not simulate specific interconnect topologies
and routing algorithms. Therefore, these simulators are not suitable for
in-depth research of interconnects.

ORCS\ [@Schneider2009] simulates the congestion of each link in the
interconnect for a given topology, communication pattern and routing
algorithm. The simulated congestion of links can be summarized into various
performance metrics and used for further analysis. A limitations of ORCS is
that only pre-defined communication can be used as input. Moreover, ORCS
assumes static routing such as InfiniBand.

In [@Jo2015], simulations are carried out to investigate the performance
characteristics of an SDN-based multipath routing algorithm for data center
networks. A simulator is developed based on MiniSSF to simulate the throughput
and delay of a traffic flow under diverse settings. In this research, traffic
patterns are randomly generated and is not based on actual applications.

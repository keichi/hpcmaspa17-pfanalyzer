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
their per-message simulation capability. However, the topology and the routing
algorithm of interconnects are abstracted in the network models of PSINS
and LogGOPSim. Therefore, these simulators cannot be used for predicting and
comparing the performance of different topologies or routing algorithms. In
contrast, the simulator targeted in this paper allows users to compare the
performance characteristic of different topologies and routing algorithms.

ORCS\ [@Schneider2009] simulates the traffic load of each link in the
interconnect for a given topology, communication pattern and routing
algorithm. The simulated traffic load of links can be summarized into various
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
proposed simulator is designed to accept arbitrary communication patterns
obtained from real-world applications using our custom profiler.

$\mathit{INAM}^2$ [@Subramoni2016] is a comprehensive tool to monitor and
analyze network activities in an InfiniBand network. The tight integration
with the job scheduler and a co-designed MPI library allows $\mathit{INAM}^2$
to associate network activities with jobs and MPI processes. For instance, it
can identify hot spots in the interconnect and inspect which node, job and
process is causing the congestion. Although $\mathit{INAM}^2$ is a useful tool
for system administrators to diagnose performance issues of interconnects, it
is not suitable for studying diverse interconnects since it only supports
physical clusters.

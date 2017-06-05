# Research Objective

In this paper, we aim to realize an interconnect simulator specialized for
application-aware dynamic interconnects to facilitate the research and
development of application-aware dynamic interconnects. Most interconnect
simulators proposed in previous researches\ [@Schneider2009; @Tikir2009;
@Hoefler2010; @Jo2015] are designed to study the behavior of static
interconnects. Therefore, packet flow is controlled based on static routing
algorithms in these simulators.

However, packet flow needs to be dynamically controlled based on the
communication patterns of applications for simulating application-aware
dynamic interconnects. Based on this  discussion, the requirements for our
simulator are as described as follows:

- _Support for application-aware dynamic routing_: The simulator should allow
  users to implement dynamic routing algorithms. In addition, the routing
  algorithms should be supplied with the communication patterns of
  applications and packet flow in the interconnect to make effective routing
  decisions.
- _Support for communication patterns of real-world applications_:
  Communication patterns of real-world HPC applications should be able to be
  fed into the simulator since synthetically generated communication patterns
  might not reflect the characteristics of real-world applications well.
  Consequently, means to extract communication patterns from applications
  needs to be developed as well. In this paper, we target applications that
  leverage MPI for inter-process communication.
- _Support for diverse cluster configurations_: The distribution of packet
  flow in the interconnect is not only determined by the routing algorithm but
  also by the topology of the interconnect as well as the job scheduling, node
  selection and process placement algorithms. These parameters should be
  easily reconfigurable to allow users to perform a systematic investigation
  of diverse clusters.

Furthermore, the simulator should be designed to be lightweight and fast to
carry out large number of simulations with different parameters in a
reasonable amount of time. If necessary, appropriate approximation should be
introduced to improve simulation performance.

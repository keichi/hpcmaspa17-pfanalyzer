# Research Objective

In this paper, we aim to realize an  interconnect simulator specialized for
dynamic interconnects to facilitate the research and development of such
interconnects. One of the main goal is to allow users to perform a systematic
investigation of diverse interconnect with different topologies and
parameters. Furthermore, following requirements must be met by the simulator:

- _Application-aware dynamic routing_: To develop and analyze methods to
  control dynamic interconnects in an application-aware manner, dynamic
  routing must be able to be simulated. In addition, dynamic routing
  algorithms that takes communication patterns of applications into account
  should be integrable.
- _Simulation based on communication patterns of applications_: Communication
  patterns of real-world HPC applications should be used as inputs of the
  simulation. Synthetically generated communication patterns might not reflect
  the characteristics of real-world applications well.
- _Parallel job execution_: The simulator should allow concurrently running
  multiple jobs to reproduce a realistic HPC cluster environment. Job
  scheduling, node selection and process mapping should also be simulated
  since these significantly affect the communication performance of
  applications.
- _Lightweight and fast simulation_: The simulator should be designed to be
  lightweight and fast to carry out large number of simulations with different
  parameters in a reasonable amount of time. If necessary, appropriate
  approximation should be introduced to improve simulation performance.

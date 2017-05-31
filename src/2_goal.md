# Research Objective

In this paper, we design and develop a prototype of an interconnect simulator
specialized for dynamic interconnects to facilitate the research and
development of such interconnects. Here are the list of requirements that must
be met:

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
  multiple jobs to reproduce a realistic HPC cluster environment. This implies
  that job scheduling, node selection and process mapping should also be
  simulated.
- _Lightweight and fast simulation_: The simulator should be designed to be
  lightweight and fast to allow research and development based on trial and
  error. If necessary, appropriate approximation should be introduced to
  improve simulation performance.

# Introduction

<!-- 通信性能の重要性 -->
Inter-node communication performance of High Performance Computing (HPC)
clusters heavily affects the performance of communication-intensive
applications. In communication-intensive applications, low-latency and
high-bandwidth communication between computing nodes is essential to fully
exploit the computational power and parallelism of the computing nodes.
High performance networks that enables such fast communication between
computing nodes of a cluster are often called _interconnects_. Message Passing
Interface (MPI)\ [@MessagePassingInterfaceForum2015] is the

<!-- 現在の相互結合網のトレンド (静的->過剰投資) -->
Nowadays, majority of HPC clusters employ statically controlled interconnects.
A well-known exemplifier is InfiniBand\ [@InfiniBand2015], where forwarding
tables of switches are populated with pre-computed forwarding rules in advance
of the execution of applications. Since static interconnects are controlled
without the knowledge of communication patterns of individual applications,
they are usually designed on an over-provisioned basis to achieve good
performance for a variety of applications each with different communication
patterns.

<!-- 相互結合網の大規模・複雑化と静的な相互結合網の限界 -->
The continuously growing demand for computing power has inevitably forced
HPC clusters to scale out more and more. As a result of the growing number of
computing nodes, interconnects are becoming increasingly large-scale and
complex. This technical trend is making static and over-provisioned
interconnects cost-ineffective and difficult to build.

<!-- 動的な相互結合網の可能性 -->
We believe that dynamically optimizing the interconnect to fit the
communication pattern of applications can increase the utilization of
interconnects and improve application performance. As a proof of concept, we
have been developing _SDN-enhanced MPI_. SDN-enhanced MPI is a framework that
incorporates the dynamic network controllability of Software-Defined
Networking (SDN)\ [@sdn] into MPI. The goal of SDN-enhanced MPI is to
accelerate individual MPI primitives by dynamically optimizing the packet flow
in the interconnect. So far, several MPI primitives has been successfully
accelerated in our previous works\ [@Takahashi2014; @Dashdavaa2013].

<!-- 動的な相互結合網の研究開発の難しさ -->
Working on physical clusters to study the characteristics of dynamic
interconnects and develop methods to control the packet flow in the
interconnect can be limited in several ways. First, the execution time of
real-world HPC applications typically ranges from minutes to up hours. This
slows down the repetitive process of evaluation and improvement. Second,
large-scale deployments of dynamic interconnects that allow execution of
highly parallel applications are still not available. Third, switches may not
support measuring traffic in the interconnect with high frequency and
precision.

<!-- シミュレータの有用性 -->
On the contrary, interconnect simulators has several advantages and can be a
useful tool to analyze and study the effect dynamic interconnect control. A
simulator can run faster than the real-world at the expense of details. Also,
a simulator allows experiments on extremely large-scale virtual environments.
It also allows measuring and recording metrics that are not possible with
physical switches.

<!-- 現在の相互結合網シミュレータの状況 -->
In fact, a wide spectrum of interconnect simulators\ [@Schneider2009;
@Tikir2009; @Hoefler2010; @Jo2015] have been developed each with different
focus and aim. However, existing simulators mostly focused on static
interconnects. In other words, little work has been done to simulate dynamic
and application-aware interconnects.

<!-- この論文でつくるシミュレータ -->
In this paper, we design and develop an interconnect simulator specialized for
dynamic interconnects to facilitate the research and development of dynamic
interconnects. Our proposed simulator takes a set of communication patterns of
applications and cluster configuration as input and simulates the congestion
in each link of the interconnect. This simulator is lightweight and fast to
allow research based on trial and error. Also, it is capable of running
multiple jobs concurrently. Job scheduling, node selection and process mapping
are also simulated. In addition to the simulator, we also design and develop a
custom profiler to extract communication patterns from applications for use
with our proposed simulator.

<!-- この論文の貢献 -->
The contributions of this paper are summarized as follows:

- A similator
- A profiler
- An evaluation

<!-- アウトライン -->
The rest of this paper is structured as follows. Section
\ref{research-objective} begins by introducing SDN-enhanced MPI and its key
technologies. Subsequently, the challenge to realize SDN-enhanced MPI is
derived.  Section\ \ref{proposal} describes our proposed mechanism and its
implementation.  Section\ \ref{evaluation} shows the result of the experiments
conducted to demonstrate the feasibility of the proposal. Section
\ref{related-work} reviews related literatures and clarifies the contributions
of this paper.  Finally, section\ \ref{conclusion} discusses future issues to
be tackled and concludes this paper.

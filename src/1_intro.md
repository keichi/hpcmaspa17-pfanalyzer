# Introduction

<!-- 通信性能の重要性 -->
Inter-node communication performance of High Performance Computing (HPC)
clusters heavily affects the total performance of communication-intensive
applications. In communication-intensive applications, low-latency and
high-bandwidth communication between computing nodes is essential to fully
exploit the computational power and parallelism of the computing nodes.
High performance networks that provide such fast communication between
computing nodes of a cluster are often referred to as _interconnects_. Message
Passing Interface (MPI)\ [@MessagePassingInterfaceForum2015; @Gropp2014] is a
commonly used inter-process communication library to describe communication on
HPC clusters.

<!-- 現在の相互結合網のトレンド (静的、それ故の過剰投資) -->
Nowadays, majority of HPC clusters employ statically controlled interconnects.
A well-known exemplifier is InfiniBand\ [@InfiniBand2015], where forwarding
tables of switches are populated with pre-computed forwarding rules in advance
of the execution of applications. Since static interconnects are controlled
without taking the communication patterns of individual applications into
account, they are usually designed on an over-provisioning basis to achieve
good performance for a variety of applications each with different
communication pattern.

<!-- 相互結合網の大規模・複雑化と静的な相互結合網の限界 -->
The continuously growing demand for computing power from academia and industry
has inevitably forced HPC clusters to scale out more and more. As a result of
the growing number of computing nodes, interconnects are becoming increasingly
large-scale and complex. This technical trend is making static and
over-provisioned interconnects cost-ineffective and difficult to build.

<!-- 動的な相互結合網の提案 + SDN-enhanced MPI -->
Based on the background, we have been developing _SDN-enhanced MPI_, which is
a framework that incorporates the dynamic network controllability of
Software-Defined Networking (SDN)\ [@sdn] into MPI. SDN-enhanced MPI is based
on the idea that dynamically optimizing the packet flow in the interconnect to
fit the communication patterns of applications can increase the utilization of
interconnect and improve application performance. The goal of SDN-enhanced MPI
is to accelerate individual MPI primitives by dynamically optimizing the
packet flow in the interconnect. So far, several MPI primitives has been
successfully accelerated in our previous works\ [@Takahashi2014;
@Dashdavaa2013].

<!-- 動的な相互結合網の実機での研究開発の難しさ -->
One of the core challenges towards realizing a dynamic and application-aware
interconnect is to develop effective algorithms to control the packet flow in
the interconnect depending on the communication patterns of applications.
However, working on physical clusters to analyze the performance
characteristics of the interconnect can be limited in several ways. First, the
execution time of real-world HPC applications typically ranges from minutes up
to hours. This slows down the iterative process of evaluation and
improvement. Second, large-scale deployments of dynamic interconnects that
allow execution of highly parallel applications are still not available.
Third, network hardware may not support measuring traffic in the interconnect
with enough high frequency and precision to obtain meaningful insights.

<!-- シミュレータの有用性 -->
On the contrary, interconnect simulators have several advantages compared to
physical clusters. Simulators allow users to carry out systematic investigation
of diverse clusters with different topologies and parameters. Furthermore,
simulators make experiments on extremely large-scale virtual environments
possible. They also allow measuring and recording metrics that are either
difficult or impossible to acquire on physical clusters.

<!-- 現在の相互結合網シミュレータの状況 -->
In fact, a wide spectrum of interconnect simulators\ [@Schneider2009;
@Tikir2009; @Hoefler2010; @Jo2015] have been developed each with different
focus and aim. However, existing simulators mostly focused on static
interconnects and few researches have been done to simulate dynamic and
application-aware interconnects.

<!-- この論文でつくるシミュレータ -->
This paper describes the design and implementation of an
interconnect simulator specialized for dynamic interconnects to facilitate the
research and development of such interconnects. Our simulator takes
a set of communication patterns of applications and a cluster configuration as
its input and simulates the congestion on each link of the interconnect. In
addition to the simulator, we have developed a custom profiler to extract
communication patterns from applications for use in conjunction with our
proposed simulator.

<!-- この論文の貢献 -->
The contributions of this paper are summarized as follows:

- A lightweight interconnect simulator for simulating dynamic and
  application-aware interconnects with multiple running jobs
- A custom profiler for extracting communication patterns from applications
- Simulation results for NAS CG benchmark and NERSC MILC benchmark on a
  fat-tree interconnect

<!-- アウトライン -->
The rest of this paper is organized as follows.
Section\ \ref{research-objective} examines the requirements of an interconnect
simulator for dynamic and application-aware interconnects.
Section\ \ref{proposal} describes the design and implementation of our
presented simulator and profiler. Section\ \ref{evaluation} presents the
simulation results for NAS CG benchmark and NERSC MILC benchmark obtained with
our proposed simulator. Furthermore, results of a verification experiment on a
physical cluster is shown. Section\ \ref{related-work} reviews related work.
Section\ \ref{conclusion} concludes this paper and outlines our future work.

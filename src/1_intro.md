# Introduction

<!-- 通信性能の重要性 -->
Inter-node communication performance of High Performance Computing (HPC)
clusters heavily affects the total performance of communication-intensive
applications. Communication-intensive applications require low-latency and
high-bandwidth communication between computing nodes to fully exploit the
computational power and parallelism of the computing nodes. High performance
networks that provide such low-latency and high-bandwidth communication
between computing nodes of a cluster are often referred to as _interconnects_.
Message Passing Interface (MPI)\ [@MessagePassingInterfaceForum2015;
@Gropp2014] is a commonly used inter-process communication library to describe
communication on HPC clusters.

<!-- 静的相互結合網と動的相互結合網の定義 -->
In this paper, interconnects are roughly classified into _static interconnects_
and _dynamic interconnects_. In the former category, it is assumed that packet
flow is controlled solely based on its source and/or destination. A well-known
exemplifier is InfiniBand\ [@InfiniBand2015], where forwarding tables of
switches are populated with pre-computed forwarding rules in advance of the
execution of applications. In contrast, in the latter category, it is assumed
that packet flow  is dynamically controlled to mitigate load imbalance and
improve utilization of the interconnect.

<!-- 現在の相互結合網のトレンド (静的、それ故の過剰投資) -->
Nowadays, the majority of HPC clusters employ the former static interconnects
because of the low implementation cost. Since static interconnects are
controlled without taking the communication patterns of individual
applications into account, they are usually designed to be able to accommodate
the worst-case traffic demand to achieve a good performance for a variety of
applications, each of which has a different communication pattern.
Interconnect designers have respected criteria such as full bisection
bandwidth and nonblockingness.

<!-- 相互結合網の大規模・複雑化と静的な相互結合網の限界 -->
The continuously growing demand for computing power from academia and industry
has inevitably forced HPC clusters to scale out more and more. As a result of
the growing number of computing nodes, interconnects are becoming increasingly
large-scale and complex. This technical trend is making static and
over-provisioned interconnects cost-ineffective and difficult to build.

<!-- 動的な相互結合網の提案 + SDN-enhanced MPI -->
Based on the background and trend, we have been seeking for the feasibility
and applicability of the network programmability of dynamic interconnects to
HPC\ [@Date2016]. In particular, _SDN-enhanced MPI_\ [@Takahashi2014;
@Dashdavaa2013], which is a framework that incorporates the dynamic network
controllability of Software-Defined Networking (SDN)\ [@sdn] into MPI, has been
researched based on the idea that dynamically optimizing the packet flow in
the interconnect according to the communication patterns of applications can
increase the utilization of interconnect and improve application performance.
The goal of SDN-enhanced MPI is to accelerate individual MPI functions by
dynamically optimizing the packet flow in the interconnect. So far, several
MPI functions have been successfully accelerated in our previous works. One of
the core challenges in the research of SDN-enhanced MPI is to develop
algorithms to control the packet flow in the interconnect depending on the
MPI function called by the application.

<!-- 動的な相互結合網の実機での研究開発の難しさ -->
More generally, algorithms for efficiently controlling the packet flow in
the interconnect depending on the communication patterns of applications is
essential towards realizing a dynamic and application-aware interconnect. In
order to develop a generic algorithm that achieves a good performance on a
variety of environments, the algorithm must be investigated and evaluated
targeting different applications and interconnects. However, utilizing
physical clusters to analyze the performance characteristics of the
interconnect is restricted in the following points. First, the execution time
of real-world HPC applications typically ranges from hours up to days,
sometimes even month. Second, large-scale deployments of dynamic interconnects
that allow execution of highly parallel applications have not be seen yet
because research and development of dynamic interconnects are still at their
early stage. Third, network hardware such as switches may not support
measuring traffic in the interconnect with enough high frequency and precision
to obtain meaningful insights.

<!-- シミュレータの有用性 -->
To accelerate the research and development of application-aware dynamic
interconnects that control packet flow in response to the communication
patterns of applications, some interconnect simulator that allows users to to
conduct systematic investigation of clusters with diverse topologies and
parameters is vitally demanded. A wide spectrum of interconnect simulators
have been developed with different focus and purpose until today. However,
existing simulators mostly focused on static interconnects and few researches
have been done to simulate dynamic and application-aware interconnects.

<!-- この論文でつくるシミュレータ -->
This paper describes the design and implementation of an
interconnect simulator specialized for dynamic interconnects to facilitate the
research and development of such interconnects. Our simulator takes
a set of communication patterns of applications and a cluster configuration as
its input and then simulates the traffic on each link of the interconnect.
In addition to the simulator, we have developed a custom profiler to extract
communication patterns from applications for use in conjunction with our
proposed simulator.

<!-- この論文の貢献 -->
The contributions of this paper are summarized as follows:

- A lightweight interconnect simulator for simulating dynamic and
  application-aware interconnects is proposed.
- A custom profiler for extracting communication patterns from applications is
  presented.
- Simulation results for NAS CG benchmark and MILC on a fat-tree interconnect
  are presented.

<!-- アウトライン -->
The rest of this paper is organized as follows.
Section\ \ref{research-objective} examines the requirements of an interconnect
simulator for dynamic and application-aware interconnects.
Section\ \ref{related-work} reviews related work. Section\ \ref{proposal}
describes the design and implementation of our presented simulator and
profiler. Section\ \ref{evaluation} presents the simulation results for
NAS CG benchmark and MILC obtained with our proposed simulator. Furthermore,
results of a verification experiment on a physical cluster is shown.
Section\ \ref{conclusion} concludes this paper and outlines our future work.

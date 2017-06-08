# Evaluation

In this section, we first simulate the traffic load of a fat-tree interconnect
when using static interconnect control and dynamic interconnect control.
Subsequently, benchmark results obtained from a physical cluster are used to
investigate the impact of traffic load on the application performance. Lastly,
we assess the overhead incurred by our profiler.

## Simulation Results

In this experiment, communication-intensive MPI applications were executed on
our simulator. The maximum traffic load observed on links composing the
interconnect was compared in both cases of static interconnect control and
dynamic interconnect control. The maximum traffic load observed on the links
was used as an indicator of the communication performance of an application.
In the most cases, a hot spot link can slow down the whole application,
because when collective communication or synchronization is performed by an
application, every process needs to wait until the slow communication crossing
the hot spot link completes. Therefore, mitigating the traffic load on the hot
spot link could improve the performance of the application.

The simulated cluster was modeled after a physical cluster installed at our
institution. It was composed of 20 computing nodes, each equipped with 8
cores. Computing nodes were interconnected with a fat-tree topology as
illustrated in Fig.\ \ref{fig:cluster-config}.

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=.9]{cluster_config}
    \caption{Simulated Cluster with Fat-Tree Interconnect}
    \label{fig:cluster-config}
\end{figure}

Two applications were selected as representatives of communication-intensive
applications. The first one is the CG benchmark from the NAS Parallel
Benchmark Suite\ [@Bailey1991]. The CG benchmark estimates the largest
eigenvalue of a sparse matrix using the inverse power method. Internally it
uses the conjugate gradient method, which frequently appears in irregular mesh
applications. The second one is an application (`ks_imp_dyn`) from MIMD
Lattice Computation (MILC)\ [@milc], a collection of applications used to
study Quantum Chromodynamics (QCD). We used the input dataset provided by
NERSC as a part of the NERSC MILC benchmark. These two applications were
executed with 128 MPI processes. Thread parallelism was not put in use (_i.e._
flat MPI model was adopted).

To analyze the effect of dynamic interconnect control, simulations were
carried out either using static routing or dynamic routing. Furthermore, in
order to investigate the impact of node selection and process placement to the
traffic load, the node selection algorithm and process placement algorithm
were also changed. As a result, exhaustive combinations of two node selection
algorithms, two process placement algorithms and two routing algorithms were
investigated with the scheduling algorithm fixed. Below are the description of
algorithms used in this experiment:

- Scheduling: A simple _First-Come First-Served (FCFS)_ scheduling without
  backfilling was adopted.
- Node Selection: Either _linear_ or _random_ node selection was adopted.
  Linear node selection assumes that computing nodes are lined up in a
  one-dimensional array and minimizes the fragmentation of allocation. This is
  essentially the same as Slurm's default node selection policy. Random node
  selection randomly selects computing nodes. This algorithm simulates a
  situation where the allocation of computing nodes is highly fragmented.
- Process Placement: Either _block_ or _cyclic_ process placement was adopted.
  Block process placement assigns rank $i$ to the $\lfloor i / c \rfloor$-th
  computing node where $c$ represents the number of cores per node. Cyclic
  process placement assigns rank $i$ to the $(i \bmod n)$-th computing
  node where $n$ denotes the number of computing nodes.
- Routing: Either _D-mod-K_ routing or a _dynamic_ routing was adopted.
  \mbox{Destination-modulo-K} (\mbox{D-mod-K}) routing is a popular static
  load balancing routing algorithm that distributes packet flow over multiple
  paths based on the destination address of the packet. The dynamic routing
  algorithm implemented here computes and allocates routes from the heaviest
  communicating process pair. A route is computed so as to minimize the
  traffic of the maximum-traffic link in the path.

Under this condition, we measured and compared the maximum traffic load
observed on links through the simulation.
Figure\ \ref{fig:nas-cg-multi-congestion} shows the simulation results in the
case of the NAS CG benchmark. In this graph, red bars represent the results of
\mbox{D-mod-K} routing while blue bars represent the results of dynamic
routing. The vertical axis represents the simulated maximum traffic load
normalized by the maximum traffic load when linear node selection, block
process placement and \mbox{D-mod-K} routing is adopted.

What stands out in Fig.\ \ref{fig:nas-cg-multi-congestion} is that dynamic
routing consistently achieves lower traffic load compared to static
\mbox{D-mod-K} routing. The reduction of traffic load was largest when linear
node selection and block process placement was adopted. Under this combination
of node selection and process placement algorithm, dynamic routing slashed
maximum traffic load by 50% compared to \mbox{D-mod-K} routing. In addition,
the graph reveals that cyclic process placement always increased maximum
traffic load compared to block process placement. This is considered to be
because neighboring ranks were placed on different computing nodes despite of
the locality of the communication pattern.

\begin{figure}[htbp]
    \centering
    \includegraphics{nas_cg_multi_congestion}
    \caption{Comparison of Maximum Traffic (NAS CG)}
    \label{fig:nas-cg-multi-congestion}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics{nersc_milc_multi_congestion}
    \caption{Comparison of Maximum Traffic (MILC)}
    \label{fig:nersc-milc-multi-congestion}
\end{figure}

Figure\ \ref{fig:nersc-milc-multi-congestion} shows the result in the case of
MILC. The graph reveals that dynamic routing outperforms \mbox{D-mod-K}
routing. In this case, the reduction of link load was the largest when random
node selection and cyclic process placement was adopted. When using linear
node selection and block process placement, the reduction of maximum link load
was 18%.

## Benchmark Results

To investigate the impact of traffic load on the application performance on an
actual environment, we reproduced the configuration described in the previous
section \ref{simulation-results} on a physical cluster and then measured the
execution time of each benchmark. In this experiment, linear node selection
and block process placement was adopted. The average execution time of 10 runs
was compared when using \mbox{D-mod-K} routing and dynamic routing.
Figure\ \ref{fig:nas-cg-time} shows the comparison for NAS CG benchmark. The
graph indicates that the use of dynamic routing reduced the execution time of
the benchmark for 23%. Figure\ \ref{fig:nersc-milc-time} shows the result for
MILC. In this case, approximately 8% was reduced in execution time.

These results suggest that application performance is actually improved by
alleviating the traffic load on the hot spot link. This suggestion implies
that researchers of dynamic interconnects can take advantage of our toolset to
simulate different packet flow controlling algorithms and assess their
performance improvement effect on real-world applications by using indicators
such as maximum traffic load.

\begin{figure}[htbp]
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics[scale=.9]{nas_cg_execution_time}
        \caption{NAS CG}
        \label{fig:nas-cg-time}
    \end{subfigure}%
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics[scale=.9]{nersc_milc_execution_time}
        \caption{MILC}
        \label{fig:nersc-milc-time}
    \end{subfigure}
    \caption{Comparison of Execution Time}
    \label{fig:single-job-time}
\end{figure}

## Profiling Overhead

In this experiment, the performance of point-to-point communication between
two processes with and without PFProf were compared to inspect the
overhead incurred by the profiler. OSU Micro Benchmark\ [@omb] was used to
measure the throughput and latency of point-to-point communication between
two processes for varying message sizes. The comparison of throughput is
shown in Fig.\ \ref{fig:bandwidth-overhead}. For messages larger than 1KB, the
overhead was ignorable. For messages smaller than 1KB, up to 30% of overhead
was incurred. Benchmark results for latency, as shown in
Fig.\ \ref{fig:latency-overhead}, suggests that there is almost no overhead
for latency.

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=.9]{bandwidth_overhead}
    \caption{Throughput of MPI\_Send/Recv Between Two Nodes}
    \label{fig:bandwidth-overhead}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics[scale=.9]{latency_overhead}
    \caption{Latency of MPI\_Send/Recv Between Two Nodes}
    \label{fig:latency-overhead}
\end{figure}

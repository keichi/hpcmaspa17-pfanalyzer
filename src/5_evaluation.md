# Evaluation

In this section, we first simulate the load of a fat-tree interconnect when
using static interconnect control and dynamic interconnect control. The
accuracy of the obtained simulation results are then verified using benchmark
results obtained from a physical cluster. Lastly, we assess the overhead
incurred by our profiler.

## Simulation Results

In this experiment, two communication-intensive MPI applications are executed
on our simulator. The amount of traffic on the link carrying the most traffic
in the interconnect is compared for static interconnect control and dynamic
interconnect control. The simulated cluster is modeled after a physical
cluster installed at our institution. It is composed of 20 computing nodes
each equipped with 8 cores. Computing nodes are interconnected with a fat-tree
topology as illustrated in Fig.\ \ref{fig:cluster-config}. Scheduling, node
selection, process placement and routing algorithms are configured as follows:

- _Scheduling_: A simple First-Come First-Served (FCFS) scheduling without
  backfilling is performed.
- _Node Selection_: Assumes that nodes are lined up in a one-dimensional array
  and minimizes fragmentation. This is essentially the same as Slurm's default
  node selection policy.
- _Process Placement_: Block process placement ($i$-th host accommodates
  rank $ci$ to rank $c(i+1)-1$ where $c$ represents the number of cores on
  each host) is adopted.
- _Routing_: Two routing algorithms are compared. The first one is
  \mbox{Destionation-modulo-K} (\mbox{D-mod-K}) routing, a popular
  static load balancing routing algorithm that distributes packet flow over
  multiple paths based on the destination address of the packet. The second
  one is a greedy dynamic routing algorithm where routes are computed and
  allocated from the heaviest communicating process pair. A route is computed
  so as to minimize the traffic of the maximum-traffic link in the path.

\begin{figure}[htbp]
    \centering
    \includegraphics{cluster_config}
    \caption{Simulated Cluster with Fat-Tree Interconnect}
    \label{fig:cluster-config}
\end{figure}

Two communication-intensive applications are used. The first one
is the CG benchmark from the NAS Parallel Benchmark Suite\ [@Bailey1991]. The
CG benchmark estimates the largest eigenvalue of a sparse matrix using the
inverse power method. Internally it uses the conjugate gradient method, which
appears frequently in irregular mesh applications. The second one is an
application (`ks_imp_dyn`) from MIMD Lattice Computation (MILC)\ [@milc],
a collection of applications used to study Quantum Chromodynamics (QCD). We
used the input dataset provided by NERSC as a part of the NERSC MILC
benchmark. Both applications were executed with 128 MPI processes. Thread
parallelism was not put in use (_i.e._ flat MPI model was adopted).

Under this condition, we measured the maximum traffic on links and compared
them for \mbox{D-mod-K} routing and dynamic routing.
Figure\ \ref{fig:nas-cg-congestion} shows the results for the NAS CG
benchmark. The maximum traffic has decreased for 50% when using dynamic
routing compared to static \mbox{D-mod-K} routing.
Figure\ \ref{fig:nersc-milc-congestion} shows the result for the NERSC MILC
benchmark. In this case, the use dynamic routing reduces the maximum traffic
for 18%.

\begin{figure}[htbp]
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics{nas_cg_congestion}
        \caption{NAS CG Benchmark}
        \label{fig:nas-cg-congestion}
    \end{subfigure}%
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics{nersc_milc_congestion}
        \caption{NERSC MILC Benchmark}
        \label{fig:nersc-milc-congestion}
    \end{subfigure}
    \caption{Comparison of Maximum Congestion}
    \label{fig:singe-job-congestion}
\end{figure}

## Benchmark Results

To verify the accuracy of our simulator, we reproduced the configuration
described in the previous section \ref{simulation-results} on a physical
cluster and measured the execution time of each benchmark. The average
execution time for 10 runs is compared when using \mbox{D-mod-K} routing and
dynamic routing.

Figure\ \ref{fig:nas-cg-time} shows the comparison for NAS CG benchmark.
The use of dynamic routing reduces the execution time for 23%.
Figure\ \ref{fig:nersc-milc-time} shows the result for NERSC MILC benchmark.
In this case, the execution time is reduced for 8%. These results suggest that
the reduction of traffic on the bottleneck link actually reduces the execution
time of applications.

\begin{figure}[htbp]
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics{nas_cg_execution_time}
        \caption{NAS CG Benchmark}
        \label{fig:nas-cg-time}
    \end{subfigure}%
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics{nersc_milc_execution_time}
        \caption{NERSC MILC Benchmark}
        \label{fig:nersc-milc-time}
        \end{subfigure}
    \caption{Comparison of Execution Time}
    \label{fig:single-job-time}
\end{figure}

## Profiling Overhead

We compared the performance of point-to-point communication between
two processes with and without our profiler to investigate the overhead
incurred by the profiler. OSU Micro Benchmark\ [@omb] was used to measure the
throughtput and latency of point-to-point communication between two processes
for varying message sizes. The comparison of throughtput is shown in
Fig.\ \ref{fig:bandwidth-overhead}. For messages larger than 1KB, the overhead
is ignorable. For messages smaller than 1KB, up to 30% of overhead is
incurred. Benchmark results for latency as shown in
Fig.\ \ref{fig:latency-overhead} suggests that there is almost no overhead for
latency.

\begin{figure}[htbp]
    \centering
    \includegraphics{bandwidth_overhead}
    \caption{Throughput of MPI\_Send/Recv Between Two Nodes}
    \label{fig:bandwidth-overhead}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics{latency_overhead}
    \caption{Latency of MPI\_Send/Recv Between Two Nodes}
    \label{fig:latency-overhead}
\end{figure}

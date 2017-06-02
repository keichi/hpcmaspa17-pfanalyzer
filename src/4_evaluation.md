# Evaluation

In this section, we first evaluate the overhead incurred by our profiler.
Subsequently, we compare the usage of interconnect when using static control
or dynamic control using our simulator. The simulation is then verified using
benchmark results
obtained from a physical cluster.

## Profiling Overhead

We compared the performance of point-to-point communication between
two processes with and without our profiler to investigate the overhead
incurred by the profiler. OSU Micro Benchmark\ [@omb] was used to measure the
bandwidth and latency of point-to-point communication between two processes
for varying message sizes. The comparison of bandwidth is shown in
Fig.\ \ref{fig:bandwidth-overhead}. For messages larger than 1KB, the overhead
is ignorable. For messages smaller than 1KB, up to 30% of overhead is
incurred. Benchmark results for latency as shown in
Fig.\ \ref{fig:latency-overhead} suggests that there is almost no overhead for
latency.

\begin{figure}[htbp]
    \centering
    \includegraphics{bandwidth_overhead}
    \caption{Bandwidth of MPI\_Send/Recv between two nodes}
    \label{fig:bandwidth-overhead}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics{latency_overhead}
    \caption{Latency of MPI\_Send/Recv between two nodes}
    \label{fig:latency-overhead}
\end{figure}

## Simulation Results

In this experiment, two communication-intensive MPI applications are
simulated. Maximum congestion is compared for static interconnect and dynamic
interconnect control. The simulated cluster is modeled after a physical
cluster installed at our institution. It is composed of 20 computing nodes
each equipped with 8 cores. Computing nodes are interconnected with a fat-tree
topology as illustrated in Fig.\ \ref{fig:cluster-config}.

\begin{figure}[htbp]
    \centering
    \includegraphics{cluster_config}
    \caption{Simulated Cluster}
    \label{fig:cluster-config}
\end{figure}

Two communication-intensive applications are used. The first one
is the CG benchmark from the NAS Parallel Benchmark Suite\ [@Bailey1991]. The
CG benchmark estimates the largest eigenvalue of a sparse matrix using the
inverse power method. Internally it uses the conjugate gradient method, which
appears frequently in irregular mesh applications. The second one is an
application (`ks_imp_dyn`) from MIMD Lattice Computation (MILC)\ [@milc],
a collection of applications used to study Quantum Chromodynamics (QCD). We
used the input dataset provided by NERSC. Both applications were executed with
128 MPI processes. Thread parallelism was not put in use (_i.e._ flat MPI
model was adopted).

- _Scheduling_: A simple First-Come First-Served (FCFS) scheduling without
  backfilling is performed.
- _Node Selection_: Assumes that nodes are lined up in a one-dimensional array
  and minimizes fragmentation. Essentially the same as Slurm's default node
  selection algorithm.
- _Process Placement_: Processes are linearly mapped to computing nodes.
- _Routing_: Two routing algorithms are compared. The first one is
  \mbox{Destionation-modulo-K} (\mbox{D-mod-K}) routing, one of the popular
  static load balancing routing algorithms that only uses the destination
  address for load balancing. The second one is a greedy dynamic routing
  algorithm where routes are computed from the heaviest communicating process
  pair so as to balance the congestion of each link.

Using these configurations as input data, we measured the maximum congestion
on links and compared them for \mbox{D-mod-K} routing and dynamic routing.
Figure\ \ref{fig:nas-cg-congestion} indicates the 50%.
Figure\ \ref{fig:nersc-milc-congestion} the 18%

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
described in section \ref{simulation-results} on a physical cluster and
measured the execution time of each benchmark.

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
    \caption{Comparison of Excution TIme}
    \label{fig:single-job-time}
\end{figure}

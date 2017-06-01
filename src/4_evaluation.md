# Evaluation

## Profiling Overhead

We compared the performance of point-to-point communication between
two processes with and without our profiler to investigate the overhead
incurred by the profiler. OSU Micro Benchmark\ [@omb] was used to measure the
bandwidth and latency of point-to-point communication between two processes
for varying message sizes. Figure\ \ref{fig:bandwidth-overhead} shows the
comparison of bandwidth. For messages larger than 1KB, the overhead is almost
ignorable. For messages smaller than 1KB, up to 30% of overhead is incurred.
Benchmark results of latency is shown in Fig.\ \ref{fig:latency-overhead}.
There is almost no overhead for latency.

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

The simulated cluster is based on a physical cluster installed at our
institution. It is composed of 20 computing nodes each equipped with 8 cores.
Computing nodes are interconnected with a fat-tree topology as illustrated in
Fig.\ \ref{fig:cluster-config}.

\begin{figure}[htbp]
    \centering
    \includegraphics{cluster_config}
    \caption{Simulated Cluster}
    \label{fig:cluster-config}
\end{figure}

Two types of communication-intensive applications are used. The first one
is the CG benchmark from the NAS Parallel Benchmark Suite\ [@Bailey1991]. The
CG benchmark estimates the largest eigenvalue of a sparse matrix using the
inverse power method. Internally conjugate gradient method is used, which is
also commonly used in irregular mesh applications. The second one is MIMD
Lattice Computation (MILC), an application used to study Quantum
Chromodynamics (QCD). We used the input dataset provided by NERSC. Both
applications were executed without thread parallelism (_i.e._ flat MPI model).

\begin{figure}[htbp]
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics{nas_cg_congestion}
        \caption{Maximum NAS CG Benchmark}
        \label{fig:nas-cg-congestion}
    \end{subfigure}%
    \begin{subfigure}[t]{.47\linewidth}
        \centering
        \includegraphics{nersc_milc_congestion}
        \caption{NERSC MILC Benchmark}
        \label{fig:nersc-milc-congestion}
    \end{subfigure}
    \caption{Comparison of Maximum Congestion}
    \label{fig:profiler-output}
\end{figure}

## Benchmark Results

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
    \label{fig:profiler-output}
\end{figure}

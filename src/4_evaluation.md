# Evaluation

## Evaluation Environment

## Overhead of Tracer

\begin{figure}[htbp]
    \centering
    \includegraphics{latency_overhead}
    \caption{Latency of MPI\_Send/Recv between two nodes}
    \label{fig:latency-overhead}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics{bandwidth_overhead}
    \caption{Bandwidth of MPI\_Send/Recv between two nodes}
    \label{fig:bandwidth-overhead}
\end{figure}

## Congestion in the Interconnect

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

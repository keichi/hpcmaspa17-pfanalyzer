# Proposal

## MPI Profiler

To collect the communication patterns from MPI applications, we developed an
MPI profiler.

Existing MPI performance analysis tools such as \mbox{Score-P}\ [@Knupfer2012],
Vampir\ [@Knupfer2008] and Tau\ [@Shende2006] replace the standard MPI functions
provided by MPI libraries with instrumented ones. Since this approach hooks
function calls to MPI functions, it is unable to capture information on the
internals of MPI implementations. This can be problematic when profiling MPI
collective communication functions (MPI_Bcast, MPI_Allreduce, MPI_Reduce,
_etc._). In general, collective communication functions are implemented as a
combination of multiple point-to-point communication in MPI implementations.
MPI profilers based on hooking MPI functions cannot capture the occurrence of
such underlying point-to-point communications. As a result, wrong
communication patterns are obtained when profiling applications using
collective communications.

To solve this problem and accurately capture underlying point-to-point
communication of collective communication, we utilize the MPI PERUSE
interface\ [@Jones2006].

\begin{figure}[htbp]
    \centering
    \includegraphics{tracer_block}
    \caption{Block Diagram of MPI Profiler}
    \label{fig:profiler-block}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics{traffic_matrix}
    \caption{Obtained Traffic Matrix}
    \label{fig:traffic-matrix}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics{message_matrix}
    \caption{Obtained Message Number Matrix}
    \label{fig:message-matrix}
\end{figure}

\begin{figure}[htbp]
    \centering
    \includegraphics{message_size_histogram}
    \caption{Histogram of Message Size}
    \label{fig:message-size-histogram}
\end{figure}

## Cluster Simulator

\begin{figure}[htbp]
    \centering
    \includegraphics{simulator_block}
    \caption{Block Diagram of Cluster Simulator}
    \label{fig:simulator-block}
\end{figure}

# Proposal

Work in progress...

## MPI Profiler

<!-- 何が既存のプロファイラと違うのか? なんでプロファイラを新規開発する? -->
To collect the communication patterns from MPI applications, we developed an
MPI profiler.

<!-- 既存のプロファイラの問題点 -->
Existing MPI performance analysis tools such as \mbox{Score-P}\ [@Knupfer2012],
Vampir\ [@Knupfer2008] and Tau\ [@Shende2006] replace the standard MPI functions
provided by MPI libraries with instrumented ones by using the MPI Profiling
Interface\ (PMPI). Since this approach hooks the calls to MPI functions,
it is unable to capture information on the internals of MPI implementations.
This can be problematic when profiling MPI collective communication functions
(_e.g._ MPI_Bcast, MPI_Allreduce and MPI_Reduce). In general, collective
communication functions are implemented as a combination of multiple
point-to-point communication. However, MPI profilers based on the PMPI
interface cannot capture the occurrence of such underlying point-to-point
communication. As a result, only a subset of the communication pattern is
obtained when profiling an application that uses collective communication
functions.

<!-- PERUSEの紹介 -->
To solve this problem and accurately capture underlying point-to-point
communication of collective communication, we utilize the MPI Performance
Examination and Revealing Unexposed State Extension (PERUSE)\ [@Jones2006].
PERUSE was designed to provide internal information of the MPI implementation
that were not exposed through PMPI to applications and performance analysis
tools. By using PERUSE, application or performance analysis tools register
callback functions for each event that they are interested in. After that, the
registered callback function is called each time when the associated event
occurs.

<!-- プロファイラの動作説明 -->
Figure\ \ref{fig:profiler-block} shows how our profiler, MPI library and MPI
application and interact with each other. The profiler hooks MPI_Init and
MPI_Finalize to perform initialization and finalization. During the
initialization, the profiler subscribes to two PERUSE events:
`PERUSE_COMM_REQ_XFER_BEGIN` and `PERUSE_COMM_REQ_XFER_END`. These events are
fired each time a transfer of a message begins and ends, respectively.
Profiling results are written out as a JSON file during the finalization.
During the execution of application, three statistics shown below are
aggregated online by the profiler:

- Total number of bytes transferred from a process to another (_i.e._ traffic
  matrix)
- Number of messages transferred from a process to another
- Distribution of message sizes

\begin{figure}[h]
    \centering
    \includegraphics{tracer_block}
    \caption{Block Diagram of MPI Profiler}
    \label{fig:profiler-block}
\end{figure}

Furthermore, MPI functions for creating and destroying communicators are also
hooked to maintain a mapping between global ranks (rank number within
`MPI_COMM_WORLD`) and local ranks (rank number within communicators created by
users). This mapping is necessary because PERUSE events are reported with
local ranks, but profiling results should be described with global ranks for
the easiness of analysis.

The proposed profiler is provided as a form of a shared library, which can be
integrated into applications at either link time or run time. The preferred
way is to use run time integration, as it does not require recompilation nor
relinking of the application. The `LD_PRELOAD` environment variable is used to
load the shared library before the execution of application.

Figure\ \ref{fig:traffic-matrix} is a visualization of the traffic matrix
obtained from running the NERSC MILC benchmark with 256 processes.
Figure\ \ref{fig:message-matrix} is a visualization of number of messages
exchanged between processes. These visualizations clearly reveal the spatial
locality and sparsity of communication between processes.
Figure\ \ref{fig:message-size-histogram} is a histogram of message sizes.

\begin{figure}[h]
    \centering
    \includegraphics{traffic_matrix}
    \caption{Obtained Traffic Matrix}
    \label{fig:traffic-matrix}
\end{figure}

\begin{figure}[h]
    \centering
    \includegraphics{message_matrix}
    \caption{Obtained Message Number Matrix}
    \label{fig:message-matrix}
\end{figure}

\begin{figure}[h]
    \centering
    \includegraphics{message_size_histogram}
    \caption{Histogram of Message Size}
    \label{fig:message-size-histogram}
\end{figure}

## Interconnect Simulator

The proposed simulator takes three types inputs.

\begin{figure}[h]
    \centering
    \includegraphics{simulator_block}
    \caption{Block Diagram of Proposed Interconnect Simulator}
    \label{fig:simulator-block}
\end{figure}

\begin{figure}[h]
    \centering
    \includegraphics{simulator_flowchart}
    \caption{Life Cycle of a Simulated Job}
    \label{fig:simulator-block}
\end{figure}

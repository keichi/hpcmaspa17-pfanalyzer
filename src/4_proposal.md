# Proposal

<!-- 提案の概要 -->
We propose a toolset for analyzing the performance characteristics of
application-aware dynamic interconnects. The proposed toolset is composed of a
profiler to extract communication patterns from applications and a simulator
capable of simulating application-aware dynamic interconnects.

## Representation of Communication Pattern

<!-- 通信パターンとしてトラフィックマトリクスを使う -->
In this paper, we represent the communication pattern of an application using
the traffic matrix of the application. For an application composed of $n$
processes, its traffic matrix is defined as a $n \times n$ square matrix $T$
of which element $T_{ij}$ is equal to the volume of traffic sent from rank $i$
to rank $j$. Here, we approximate that the volume of traffic between processes
is constant during the execution of a job. The traffic volume between a
process pair is assumed to be the total bytes transferred divided by the
duration of the application.

<!-- トラフィックマトリクスで近似することの正当性 -->
This approximation is introduced to simplify and speed up the simulation. The
idea behind this approximation is based on the fact that many HPC applications
(_e.g._ partial differential equation solvers) show an iterative nature. These
applications spend most of their execution time inside a repetitive loop and
thus their communication patterns do not significantly change over time.
Therefore, the traffic matrix can be a good representation of the
communication characteristics of an iterative application despite the loss of
temporal order. In future, we plan to apply trace segmentation\ [@Alawneh2016]
techniques on the communication trace. This technique would segment a trace
into multiple communication phases, which could then be simulated individually
to further improve the accuracy of simulation for applications with
significantly time-varying communication patterns.

## MPI Profiler

<!-- 既存のプロファイラの問題点 -->
Initially, we tried to reuse existing MPI performance analysis tools such as
\mbox{Score-P}\ [@Knupfer2012], Vampir\ [@Knupfer2008] and Tau\ [@Shende2006]
to collect the traffic matrices from MPI applications. However, these tools
capture only a subset of the communication pattern when profiling an
application that uses collective communication functions (_e.g._ MPI_Bcast,
MPI_Allreduce and MPI_Reduce).

<!-- PMPIベースのプロファイラが集団通信の解析に失敗する理由 -->
The reason can be explained as follows. Existing MPI profilers replace the
standard MPI functions provided by MPI libraries with instrumented functions
by utilizing the MPI Profiling Interface (PMPI). An advantage of this approach
is that it works regardless of a specific MPI implementation. However, this
approach fails to capture the internal information of the MPI library.
Meanwhile, collective communication functions are internally implemented as a
combination of point-to-point communication in MPI implementations. These
underlying point-to-point communication are hidden from PMPI-based profilers
and excluded from the communication patterns emitted by profilers.

<!-- PERUSEの紹介 -->
To accurately capture the underlying point-to-point communication of collective
communication, we have developed a profiler by utilizing the MPI Performance
Examination and Revealing Unexposed State Extension (PERUSE)\ [@Jones2006].
PERUSE was designed to provide internal information of the MPI implementation
that were not exposed through PMPI to applications and performance analysis
tools. By using PERUSE, application or performance analysis tools register
callback functions for each event of interest. After that, the registered
callback function is called each time when the associated event occurs.

<!-- プロファイラの動作説明 (PERUSE関係)-->
Figure\ \ref{fig:profiler-block} illustrates how our profiler, MPI library and
MPI application and interact with each other. The profiler hooks MPI_Init and
MPI_Finalize to perform initialization and finalization. During the
initialization, the profiler subscribes to two PERUSE events:
`PERUSE_COMM_REQ_XFER_BEGIN` and `PERUSE_COMM_REQ_XFER_END`. These events are
emitted each time a transfer of a message begins and ends, respectively.
Profiling results are written out as a JSON file during the finalization.
During the execution of application, the total number of bytes transferred
from a process to another is aggregated to compute the traffic matrix.

\begin{figure}[htbp]
    \centering
    \includegraphics{tracer_block}
    \caption{Block Diagram of MPI Profiler}
    \label{fig:profiler-block}
\end{figure}

<!-- プロファイラの動作説明 (コミュニケータ関係) -->
Furthermore, the profiler hooks several MPI functions for creating and
destroying communicators to maintain a mapping between global ranks (rank
number within `MPI_COMM_WORLD`) and local ranks (rank number within
communicators created by users). This mapping is necessary because PERUSE
events are reported with local ranks, while profiling results should be
described with global ranks for the easiness of analysis.

<!-- プロファイラの使い方 -->
The proposed profiler is provided as a form of a shared library, which can be
integrated into applications either when building the application or running
the application. The preferred way is to use run time integration, as it does
not require recompilation nor relinking of the application. The `LD_PRELOAD`
environment variable is used to load the shared library before the execution
of application.

<!-- プロファイラの出力例 -->
As an example of a profiler output, the traffic matrix obtained from running
MILC with 128 processes is shown in Fig.\ \ref{fig:traffic-matrix}. This
visualization clearly reveals the spatial locality and sparsity of the
communication pattern.

\begin{figure}[htbp]
    \centering
    \includegraphics{traffic_matrix}
    \caption{Traffic Matrix for MILC}
    \label{fig:traffic-matrix}
\end{figure}

## Interconnect Simulator

<!-- 提案の概要 -->
Our developed simulator takes a set of communication patterns of applications
and a cluster configuration as its input and then simulates the packet flow
generated by the applications. The packet flow is aggregated per link to
compute the traffic load of each link. The simulated traffic load of links can
be summarized into statistics for quantitative analysis or visualized.
Using these outputs from the simulator, users can locate hot-spots and assess
load imbalance in the interconnect. These insights on the interconnect can be
useful for designing better algorithms for controlling the packet flow in
application-aware dynamic interconnects.

<!-- シミュレータの動作原理 -->
The simulator is based on a discrete-event simulation model. Under
this model, the simulator maintains an event queue, which is a priority queue
that contains a collection of future events ordered by its occurring time.
There are different type of events representing a change of state in the
simulator such as: a job arrived, a job started, a job finished, _etc_. At the
beginning of the main loop, the earliest occurring event is popped from the
event queue. Then, based on the type of the event, the corresponding event
handler is called. An event handler may schedule new events. This loop is
repeated until the event queue is empty.

<!-- シミュレータの入力 (シナリオ)-->
Figure\ \ref{fig:simulator-block} illustrates how our simulator works. The
simulation scenario file defines various configurations for a simulation run.
This file defines the cluster configuration to use and set of jobs. Moreover,
algorithms that control the execution and communication of jobs are specified
as shown in Table\ \ref{tbl:simulator-algorithm}. An example of a simulation
scenario file is shown in Listing\ \ref{lst:simulation-scenario}. The cluster
configuration file defines the topology of the interconnect, capacity of links
and number of processing elements for each computing node. This file is
described in GraphML\ [@Brandes2013], an XML-based markup language for graphs.
Popular graph visualization tools such as Cytoscape\ [@Shannon2003] and
Gephi\ [@Bastian2009] can be used to view and edit GraphML files.
Communication pattern files are obtained from applications using our custom
profiler described in the previous section \ref{mpi-profiler}.

<!-- シミュレータの入力 (クラスタ構成と通信パターン) -->
\begin{figure}[htbp]
    \centering
    \includegraphics{simulator_block}
    \caption{Block Diagram of Proposed Interconnect Simulator}
    \label{fig:simulator-block}
\end{figure}

Each configuration value can be a list of values. In that case, the simulation
is executed multiple times, each time with a different combination of
configuration values until all combinations are completed.

\begin{table}[htbp]
    \centering
    \normalsize
    \caption{List of Configurable Algorithms}
    \label{tbl:simulator-algorithm}
    \begin{tabularx}{\linewidth}{lX}
        \hline
        Algorithm         & Description                                                 \\
        \hline \hline
        Job Scheduling    & Selects the job to execute from the job queue.
                            (\emph{e.g.} FCFS, Backfill)                                \\ \hline
        Node Selection    & Selects which computing nodes to assign for a job.
                            (\emph{e.g.} Linear, Random, Topology-aware algorithms)     \\ \hline
        Process Placement & Determines on which computing node to place a process.
                            (\emph{e.g.} Block, Cyclic, Application-aware algorithms)   \\ \hline
        Routing           & Computes a route between a pair of processes.
                            (\emph{e.g.} D-mod-K, S-mod-K, Random, Dynamic algorithms)  \\ \hline
    \end{tabularx}
\end{table}

```{caption="Example of a Simulation Scenario" label="lst:simulation-scenario" linewidth=\columnwidth}
topology: topologies/milk.graphml
output: output/milk-cg-dmodk
algorithms:
  scheduler:
    - picosim.scheduler.FCFSScheduler
  host_selector:
    - picosim.host_selector.LinearHostSelector
    - picosim.host_selector.RandomHostSelector
  process_mapper:
    - picosim.process_mapper.LinearProcessMapper
    - picosim.process_mapper.CyclicProcessMapper
  router:
    - picosim.router.DmodKRouter
    - picosim.router.GreedyRouter
    - picosim.router.GreedyRouter2
jobs:
  - submit:
      distribution: picosim.math.ExponentialDistribution
      params:
        lambd: 0.1
    trace: traces/cg-c-128.tar.gz
...
```

<!-- シミュレータの出力 -->
The simulator can create a snapshot of the traffic distribution in the
interconnect at arbitrary time and output is as a GraphML file. By visualizing
the acquired GraphML using the aforementioned graph visualization tools, users
can intuitively locate bottleneck links and load imbalance. Furthermore, the
traffic load of links can be summarized into statistics such as maximum,
minimum, average, variance and plotted as graphs.

\begin{figure}[h]
    \centering
    \includegraphics{simulator_flowchart}
    \caption{Life Cycle of a Simulated Job}
    \label{fig:simulator-flowchart}
\end{figure}

<!-- ジョブの視点で見たシミュレーション処理の流れ -->
Figure\ \ref{fig:simulator-flowchart} illustrates the life cycle of a
simulated job. On arrival of a new job, the job is initially enqueued to the
job queue. As soon as there are unallocated computing nodes enough to execute
a job, the scheduling algorithm determines the job to be executed next and
pops it from the job queue. Subsequently, the node selection algorithm picks a
set of computing nodes that can satisfy the requested number of processes by
the job. Then, the process placement algorithm determines on which computing
node to run each process of the job. After the process placement is completed,
the routing algorithm computes and allocates routes for all communicating pair
of processes. As we would like to allow users to implement
application-aware dynamic routings, additional information are supplied to the
routing algorithm in addition to the source/destination process pair. The
information includes process placement, communication pattern and interconnect
usage. For each allocated route, the traffic on the link contained in the
route is increased. After all routes are computed, the simulator waits until
the job has finished. Then, the traffic for each link that was utilized by the
job is decreased. Finally, computing nodes are deallocated and the job is
marked as completed.

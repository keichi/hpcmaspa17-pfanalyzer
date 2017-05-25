# Proposal

## MPI Tracer

To collect the communication patterns from MPI applications, we developed an
MPI tracer.

Existing MPI performance analysis tools such as \mbox{Score-P}\ [@Knupfer2012],
Vampir\ [@Knupfer2008] and Tau\ [@Shende2006] replace MPI functions with their
When an application calls an MPI function, the tracer records the timestamp
and arguments.

The problem of this design is that it cannot capture the actual communication
of collective communications. Generally, MPI implementations realize
collective communications with a series of point-to-point communications.
MPI tracers relying on hooking MPI functions cannot capture such underlying
point-to-point communications. This can lead to wrong communication patterns
for applications where collective communications are dominant compared to
point-to-point communications.

To solve this problem and correctly capture every point-to-point
communication, we utilize the MPI PERUSE interface\ [@Jones2006].


\begin{figure}[htbp]
    \centering
    \includegraphics{tracer_block}
    \caption{Block Diagram of MPI Tracer}
    \label{fig:tracer-block}
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

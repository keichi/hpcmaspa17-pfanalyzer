## タイトル

- A Toolset for Analyzing Dynamic and Application-aware Interconnects
- Performance Analysis Tools for Dynamic and Application-aware Interconnects

## アブストラクト

Due to the rapid scale out of high-performance computing systems,
interconnects are becoming increasingly large-scale and complex. This trend is
making static and over-provisioned interconnects cost-ineffective. We have
been developing SDN-enhanced MPI, a framework that optimizes the interconnect
to fit the communication patterns of MPI applications by leveraging the
dynamic network controllability of Software-Defined Networking (SDN). Our
previous works have demonstrated the acceleration of several individual MPI
primitives based on the idea of SDN-enhanced MPI. However, the effect of
SDN-enhanced MPI on the utilization of interconnects and performance of
real-world applications is yet unclear. To answer this question, we developed
an MPI tracer and online analyzer to extract the communication patterns from
applications. Furthermore, we developed an interconnect simulator to
investigate the congestion in the interconnect for a given cluster
configuration and set of communication patterns. By using these tools, we show
how SDN-enhanced MPI can reduce congestion in the interconnect and potentially
improve the performance of applications.

## 背景

- クラスタのスケールアウトとともに相互結合網が大規模・複雑化
- 現在の静的かつ過剰投資を前提とした設計は、性能価格比が悪化
- アプリケーションの通信パターンに応じて相互結合網を動的に制御することで、
  相互結合網をより効率的に利用し、プロセス間通信を高速化できないか (例:
  SDN-enhanced MPI)

(タイトル・アブストラクトと合わせて1.5ページ)

## 問題

- 実アプリケーションにおいて、複数のMPI関数がそれぞれ異なる引数で呼びだれされる
  際のSDN-enhanced MPIの性能向上効果は未だ不明
- 実機の小規模なSDN-enabledクラスタでは1回の実験に時間がかる上、
  大規模・高並列な実験ができない

(0.5ページ)

## 提案

### 概要

- 実アプリケーションから通信パターンを抽出し、クラスタシミュレータ上で
  相互結合網の負荷をシミュレート
- 相互結合網の負荷からアプリケーションの性能向上を推測
- これを実現するために、MPIプロファイラとクラスタシミュレータを開発する

### MPIプロファイラ

- MPIプロファイラの概要と目的
- 特徴
    - 集団通信を構成する1対1通信までトレースできる
    - 既存のプロファイラでは得られない、通信パターンを得られる
- 動作原理
    - **図1**: MPIプロファイラのブロック図
- 使用方法
- プロファイル結果の例
    - **図2**: アプリケーションから抽出した通信パターンの例

### クラスタシミュレータ

- クラスタシミュレータの概要と目的
- 特徴
    - 相互結合網の負荷のシミュレーションに特化
    - スケジューリング、ノード選択、プロセス配置、ルーティングのアルゴリズムを
      プラグイン可能
    - ジョブ実行中にプロセス間の通信パターンは変化しないと仮定
    - 相互結合網中の各リンクのトラフィック量やフロー数などを計測可能
- 動作原理
    - **図3**: クラスタシミュレータのブロック図
- 使用方法

(2ページ)

## 評価

### 評価環境

- シミュレーションで使用したクラスタの構成
- 使用したアプリケーション (OSU, NAS CG, NERSC MILC)

### プロファイラのオーバーヘッド

- プロファイラを使用することによるアプリケーションの性能への影響を評価するため
- 1対1通信の帯域幅と遅延を、プロファイラを使用する場合としない場合で比較した
- **図4**: 2ノード間のMPI_Send/Recvの帯域幅
- **図5**: 2ノード間のMPI_Send/Recvの遅延
- 帯域幅については、メッセージサイズが1KB未満の場合に最大30%程度の
  オーバーヘッドがある
- 遅延については、どのメッセージサイズでもほぼオーバーヘッドがない

### 相互結合網の輻輳量

- 実アプリケーションの通信パターンで、SDN-enhanced MPIによって相互結合網の
  輻輳がどの程度改善されるか計測するため
- NAS CGとNERSC MILCの2種のベンチマークを実行した際の相互結合網中の最大輻輳量を
  シミュレータで計測
- 従来のD-mod-KルーティングとSDN-enhanced MPIを比較
- NAS CGベンチマーク (クラスC) を128並列で実行した際、最大輻輳量を50%削減
- **図6**: NAS CGベンチマーク実行時の最大輻輳量
- NERSC MILCベンチマークを128並列で実行した際、最大輻輳量を18%削減
- **図7**: NERSC MILCベンチマーク実行時の最大輻輳量

### 実機ベンチマーク

- 実アプリケーションの通信パターンで、SDN-enhanced MPIによってアプリケーション
  の性能がどの程度向上するか計測するため
- NAS CGとNERSC MILCの2種のベンチマークを実機で実行した際の実行時間を計測
- 従来のD-mod-KルーティングとSDN-enhanced MPIを比較
- NAS CGベンチマーク (クラスC) を128並列で実行した際、34%高速化
- **図8**: NAS CGベンチマークの実行時間
- NERSC MILCベンチマークを128並列で実行した際、7%高速化
- **図9**: NERSC MILCベンチマークの実行時間

(2ページ)

## 関連研究

- ORCS: An Oblivious Routing Congestion Simulator
    - Pros: リンクの輻輳量をシミュレート, 統計的な解析機能が充実
    - Cons: 動的なルーティングは非対応, 通信パターンは事前定義されたもののみ
- A Simulation and Emulation Study of SDN-based Multipath Routing for
  Fat-tree Data Center Networks
    - Pros: シミュレーションとエミュレーションの両方で評価
    - Cons: 通信パターンはランダムのみ
- PSINS: An Open Source Event Tracer and Execution Simulator for MPI
  Applications
    - Pros: 実アプリケーションのトレースを元にシミュレーション
    - Cons: ネットワークのモデルが単純で、トポロジやルーティングを考慮していな
      い
- LogGOPSim: Simulating Large-Scale Applications in the LogGOPS Model
    - Pros: パケットレベルでの精確なシミュレーション, トレースを使用
    - Cons: 輻輳、トポロジやルーティングを考慮していない
- A Simulator for Large-scale Parallel Computer Architectures
    - Pros: パケットレベルでの精確なシミュレーション, トレースを使用
    - Cons: 動的なルーティングは非対応

(以降の節と合わせて1ページ)

## まとめ・将来課題

- より大規模なクラスタとアプリケーション (数百〜数千並列) を
  シミュレーションで評価する
- 通信パターンに応じたノード選択やプロセス配置と併用した際の効果を評価する
- 時間的に変化する通信パターンに対応する

## 謝辞

省略

## 参考文献

省略

## タイトル案

- A Toolset for Analyzing Dynamic and Application-aware Interconnects
- Performance Analysis Tools for Dynamic and Application-aware Interconnects
- Simulator for Assessing the Effect of Dynamic Network Controllability on Interconnects

## アブストラクト

Due to the rapid scale out of high-performance computing systems,
interconnects are becoming increasingly large-scale and complex. This trend is
making static and over-provisioned interconnects cost-ineffective.
We believe that dynamically optimizing the interconnect to fit the
communication pattern of applications can increase the utilization of
interconnects and improve application performance. Although simulators for
static interconnects has been extensively researched and developed, little
effort has been put for the simulation of dynamically controlled
interconnects. To facilitate the analysis and understanding of the performance
benefits of dynamic interconnects, we develop a simulator specialized for
dynamic interconnects. This simulator allows interconnect researchers and
designers to investigate the congestion in the interconnect for a given cluster
configuration and set of communication patterns collected by a dedicated tool.
By using these tools, we show how dynamically controlling the  interconnects
can reduce congestion and potentially improve the performance of applications.

## 背景

- クラスタのスケールアウトとともに相互結合網が大規模・複雑化
- 現在の静的かつ過剰投資を前提とした設計は、価格性能比が悪化
- アプリケーションの通信パターンに応じて相互結合網を動的に制御することで、
  相互結合網をより効率的に利用し、プロセス間通信を高速化できないか
- 我々は動的な相互結合網が、今後のHPCシステムにおいて重要かつ不可欠になると
  考え、研究開発を推進してきた (例: SDN-enhanced MPI)
- 動的な相互結合網の研究開発においては、実アプリケーションの通信パターンを
  使用して、相互結合網の制御手法の開発や評価を行う
- しかし実機のクラスタでは1回の実験に時間がかる上、高並列な実験ができるほど、
  大規模かつ動的な相互結合網を備えたクラスタがない
- シミュレータでクラスタと相互結合網をシミュレートすることで、相互結合網や
  とその制御方法の性能をより容易かつ高速に解析できると考えられる

(タイトル・アブストラクトと合わせて1.5ページ)

## 問題・目的

- 既に、InfiniBandなどの静的な相互結合網に基づくクラスタをシミュレートする
  ツールは様々なものが開発されてきた
- しかし、動的な相互結合網の研究において、相互結合網とその制御方法の性能を
  計測・解析するためには、シミュレータは下記の要件を満たしている必要がある:
    1. **動的な相互結合網のシミュレーション**
    2. **実アプリケーションの通信パターンの入力**: Syntheticに通信パターンを
       生成すると、実アプリケーションの通信パターンと乖離する可能性があるため。
    3. **複数ジョブの並列実行と、それにともなうジョブのスケジューリング・
       プロセス配置の包括的シミュレーション**: 実際のクラスタでは同時に
       複数ジョブを実行する。通信性能はプロセスの配置に大きく影響されるため。
    4. **軽量・高速**: 相互結合網の制御手法の検証と改善を高速に繰り返すため
- 上記の要件を全て備えたシミュレータは未だない
- 動的な相互結合網の研究者や、設計・運用者の一助となることを期待して、
  シミュレータと付随するツールのプロトタイプを試作する

(0.5ページ)

## 提案

### 概要

- 動的な相互結合網の研究開発に必要なシミュレータと、付随するツールを開発する
- ジョブ実行中にプロセス間の通信パターンは変化しないと仮定し、
  通信パターンとしてトレースの代わりにトラフィックマトリックスを用いる
- これにより入力データ量が大幅に減り、高速・軽量なシミュレーションを実現できる

### MPIプロファイラ

- MPIプロファイラの概要と目的
- 特徴
    - シミュレータと併せて使用することを前提としているため、通信パターンの採取
      に特化
    - 集団通信を構成する1対1通信までトレースできる
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
    - 相互結合網中の各リンクのトラフィック量やフロー数などを計測可能
- 動作原理
    - **図3**: クラスタシミュレータのブロック図
- 使用方法

(2ページ)

## 評価

### 評価環境

- シミュレータに入力したクラスタ構成
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

- 実アプリケーションの通信パターンで、相互結合網の動的制御による輻輳の改善
  効果を評価するため
- NAS CGとNERSC MILCの2種のベンチマークを実行した際の相互結合網中の最大輻輳量を
  シミュレータで計測
- 従来のD-mod-KルーティングとSDN-enhanced MPIを比較
- NAS CGベンチマーク (クラスC) を128並列で実行した際、最大輻輳量を50%削減
- **図6**: NAS CGベンチマーク実行時の最大輻輳量
- NERSC MILCベンチマークを128並列で実行した際、最大輻輳量を18%削減
- **図7**: NERSC MILCベンチマーク実行時の最大輻輳量

### 実機ベンチマーク

- シミュレーション結果と、実機におけるアプリケーションの性能向上効果がどの程度
  適合しているか評価するため
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

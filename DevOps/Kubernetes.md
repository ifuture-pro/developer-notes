# Kubernetes

![](../assets/img/kubernetes-ecosystem.png)

## 组件
### [etcd](https://github.com/coreos/etcd/)
  * 保存了整个集群的状态，是Kubernetes提供默认的存储系统，保存所有集群数据，使用时需要为etcd数据提供备份计划
  * 基于 Raft 开发的分布式 key-value 存储
  * key 的过期及续约机制，服务发现、共享配置以及一致性保障（如数据库选主、分布式锁等）。
  * 监听机制
  * 原子 CAS 和 CAD，用于分布式锁和 leader 选举

#### 竞品
  * Zookeeper
  > Etcd 和 Zookeeper 提供的能力非常相似，都是通用的一致性元信息存储，都提供 watch 机制用于变更通知和分发，也都被分布式系统用来作为共享信息存储，在软件生态中所处的位置也几乎是一样的，可以互相替代的。二者除了实现细节，语言，一致性协议上的区别，最大的区别在周边生态圈。Zookeeper 是 apache 下的，用 java 写的，提供 rpc 接口，最早从 hadoop 项目中孵化出来，在分布式系统中得到广泛使用（hadoop, solr, kafka, mesos 等）。Etcd 是 coreos 公司旗下的开源产品，比较新，以其简单好用的 rest 接口以及活跃的社区俘获了一批用户，在新的一些集群中得到使用（比如 kubernetes）。虽然 v3 为了性能也改成二进制 rpc 接口了，但其易用性上比 Zookeeper 还是好一些。
  * Consul
  > Consul 的目标则更为具体一些，Etcd 和 Zookeeper 提供的是分布式一致性存储能力，具体的业务场景需要用户自己实现，比如服务发现，比如配置变更。而 Consul 则以服务发现和配置变更为主要目标，同时附带了 kv 存储，在Spring Cloud 中与 Eureka 一起成为主要的服务发现产品。

### kube-apiserver
  * 提供了资源操作的唯一入口，并提供认证、数据校验、授权、访问控制、集群状态变更、API 注册和发现等机制；
  * 提供其他模块之间的数据交互和通信的枢纽（其他模块通过 API Server 查询或修改数据，只有 API Server 才直接操作 etcd）


### kube-controller-manager
负责维护集群的状态，比如故障检测、自动扩展、滚动更新等；
### kube-scheduler
负责资源的调度，按照预定的调度策略将 Pod 调度到相应的机器上；
### kubelet
负责维持容器的生命周期，同时也负责 Volume（CVI）和网络（CNI）的管理；
### Container runtime
负责镜像管理以及 Pod 和容器的真正运行（CRI），默认的容器运行时为 Docker；
### kube-proxy
负责为 Service 提供 cluster 内部的服务发现和负载均衡；
### Ingress Controller
  * 为服务提供外网入口
  * k8s 网关，服务暴露
  * ingress-nginx deploy    [官网](https://kubernetes.github.io/ingress-nginx/deploy/)  [博客](https://blog.csdn.net/java_zyq/article/details/82179107)
  * traefik ingress

### Heapster
提供资源监控
### Dashboard
提供 GUI
### Federation
提供跨可用区的集群
### Fluentd-elasticsearch
提供集群日志采集、存储与查询


## 关键概念
每个API对象都有3大类属性：元数据metadata、规范spec和状态status。元数据是用来标识API对象的，每个对象都至少有3个元数据：namespace，name和uid；除此以外还有各种各样的标签labels用来标识和匹配不同的对象，例如用户可以用标签env来标识区分不同的服务部署环境，分别用env=dev、env=testing、env=production来标识开发、测试、生产的不同服务。规范描述了用户期望K8s集群中的分布式系统达到的理想状态（Desired State），例如用户可以通过复制控制器Replication Controller设置期望的Pod副本数为3；status描述了系统实际当前达到的状态（Status），例如系统当前实际的Pod副本数为2；那么复本控制器当前的程序逻辑就是自动启动新的Pod，争取达到副本数为3。  
K8s中所有的配置都是通过API对象的spec去设置的，也就是用户通过配置系统的理想状态来改变系统，这是k8s重要设计理念之一，___即所有的操作都是声明式（Declarative）的而不是命令式（Imperative）的。声明式操作在分布式系统中的好处是稳定，不怕丢操作或运行多次，例如设置副本数为3的操作运行多次也还是一个结果，而给副本数加1的操作就不是声明式的，运行多次结果就错了___。

### Pod
Pod是在K8s集群中运行部署应用或服务的最小单元，它是可以支持多容器的。Pod的设计理念是支持多个容器在一个Pod中共享网络地址和文件系统，可以通过进程间通信和文件共享这种简单高效的方式组合完成服务。Pod对多容器的支持是K8s最基础的设计理念。比如你运行一个操作系统发行版的软件仓库，一个Nginx容器用来发布软件，另一个容器专门用来从源仓库做同步，这两个容器的镜像不太可能是一个团队开发的，但是他们一块儿工作才能提供一个微服务；这种情况下，不同的团队各自开发构建自己的容器镜像，在部署的时候组合成一个微服务对外提供服务。  
Pod是K8s集群中所有业务类型的基础，可以看作运行在K8s集群中的小机器人，不同类型的业务就需要不同类型的小机器人去执行。目前K8s中的业务主要可以分为长期伺服型（long-running）、批处理型（batch）、节点后台支撑型（node-daemon）和有状态应用型（stateful application）；分别对应的小机器人控制器为Deployment、Job、DaemonSet和StatefulSet

### Replication Controller
复制控制器(RC)是K8s集群中最早的保证Pod高可用的API对象。通过监控运行中的Pod来保证集群中运行指定数目的Pod副本。指定的数目可以是多个也可以是1个；少于指定数目，RC就会启动运行新的Pod副本；多于指定数目，RC就会杀死多余的Pod副本。即使在指定数目为1的情况下，通过RC运行Pod也比直接运行Pod更明智，因为RC也可以发挥它高可用的能力，保证永远有1个Pod在运行。RC是K8s较早期的技术概念，只适用于长期伺服型的业务类型，比如控制小机器人提供高可用的Web服务。

### Replica Set
副本集RS是新一代RC，提供同样的高可用能力，区别主要在于RS后来居上，能支持更多种类的匹配模式。副本集对象一般不单独使用，而是作为Deployment的理想状态参数使用。

### Deployment
部署表示用户对K8s集群的一次更新操作。部署是一个比RS应用模式更广的API对象，可以是创建一个新的服务，更新一个新的服务，也可以是滚动升级一个服务。滚动升级一个服务，实际是创建一个新的RS，然后逐渐将新RS中副本数增加到理想状态，将旧RS中的副本数减小到0的复合操作；这样一个复合操作用一个RS是不太好描述的，所以用一个更通用的Deployment来描述。以K8s的发展方向，未来对所有长期伺服型的的业务的管理，都会通过Deployment来管理。
### Service
RC、RS和Deployment只是保证了支撑服务的微服务Pod的数量，但是没有解决如何访问这些服务的问题。一个Pod只是一个运行服务的实例，随时可能在一个节点上停止，在另一个节点以一个新的IP启动一个新的Pod，因此不能以确定的IP和端口号提供服务。要稳定地提供服务需要服务发现和负载均衡能力。服务发现完成的工作，是针对客户端访问的服务，找到对应的的后端服务实例。在K8s集群中，客户端需要访问的服务就是Service对象。每个Service会对应一个集群内部有效的虚拟IP，集群内部通过虚拟IP访问一个服务。在K8s集群中微服务的负载均衡是由Kube-proxy实现的。Kube-proxy是K8s集群内部的负载均衡器。它是一个分布式代理服务器，在K8s的每个节点上都有一个；这一设计体现了它的伸缩性优势，需要访问服务的节点越多，提供负载均衡能力的Kube-proxy就越多，高可用节点也随之增多。与之相比，我们平时在服务器端使用反向代理作负载均衡，还要进一步解决反向代理的高可用问题。
### Job
任务Job是K8s用来控制批处理型任务的API对象。批处理业务与长期伺服业务的主要区别是批处理业务的运行有头有尾，而长期伺服业务在用户不停止的情况下永远运行。Job管理的Pod根据用户的设置把任务成功完成就自动退出了。成功完成的标志根据不同的spec.completions策略而不同：单Pod型任务有一个Pod成功就标志完成；定数成功型任务保证有N个任务全部成功；工作队列型任务根据应用确认的全局成功而标志成功。
### DaemonSet
后台支撑服务集，长期伺服型和批处理型服务的核心在业务应用，可能有些节点运行多个同类业务的Pod，有些节点上又没有这类Pod运行；而后台支撑型服务的核心关注点在K8s集群中的节点（物理机或虚拟机），要保证每个节点上都有一个此类Pod运行。节点可能是所有集群节点也可能是通过nodeSelector选定的一些特定节点。典型的后台支撑型服务包括，存储，日志和监控等在每个节点上支撑K8s集群运行的服务。
### StatefulSet
有状态服务集，K8s在1.3版本里发布了Alpha版的PetSet以支持有状态服务，并从1.5版本开始重命名为StatefulSet。在云原生应用的体系里，有下面两组近义词；第一组是无状态（stateless）、牲畜（cattle）、无名（nameless）、可丢弃（disposable）；第二组是有状态（stateful）、宠物（pet）、有名（having name）、不可丢弃（non-disposable）。RC和RS主要是控制提供无状态服务的，其所控制的Pod的名字是随机设置的，一个Pod出故障了就被丢弃掉，在另一个地方重启一个新的Pod，名字变了、名字和启动在哪儿都不重要，重要的只是Pod总数；而StatefulSet是用来控制有状态服务，StatefulSet中的每个Pod的名字都是事先确定的，不能更改。StatefulSet中Pod的名字的作用，并不是《千与千寻》的人性原因，而是关联与该Pod对应的状态。  
对于RC和RS中的Pod，一般不挂载存储或者挂载共享存储，保存的是所有Pod共享的状态，Pod像牲畜一样没有分别（这似乎也确实意味着失去了人性特征）；对于StatefulSet中的Pod，每个Pod挂载自己独立的存储，如果一个Pod出现故障，从其他节点启动一个同样名字的Pod，要挂载上原来Pod的存储继续以它的状态提供服务。  
适合于StatefulSet的业务包括数据库服务MySQL和PostgreSQL，集群化管理服务Zookeeper、etcd等有状态服务。StatefulSet的另一种典型应用场景是作为一种比普通容器更稳定可靠的模拟虚拟机的机制。传统的虚拟机正是一种有状态的宠物，运维人员需要不断地维护它，容器刚开始流行时，我们用容器来模拟虚拟机使用，所有状态都保存在容器里，而这已被证明是非常不安全、不可靠的。使用StatefulSet，Pod仍然可以通过漂移到不同节点提供高可用，而存储也可以通过外挂的存储来提供高可靠性，StatefulSet做的只是将确定的Pod与确定的存储关联起来保证状态的连续性。StatefulSet还只在Alpha阶段，后面的设计如何演变，我们还要继续观察。
### Federation
集群联邦，K8s在1.3版本里发布了beta版的Federation功能。在云计算环境中，服务的作用距离范围从近到远一般可以有：同主机（Host，Node）、跨主机同可用区（Available Zone）、跨可用区同地区（Region）、跨地区同服务商（Cloud Service Provider）、跨云平台。K8s的设计定位是单一集群在同一个地域内，因为同一个地区的网络性能才能满足K8s的调度和计算存储连接要求。而联合集群服务就是为提供跨Region跨服务商K8s集群服务而设计的。  
每个K8s Federation有自己的分布式存储、API Server和Controller Manager。用户可以通过Federation的API Server注册该Federation的成员K8s Cluster。当用户通过Federation的API Server创建、更改API对象时，Federation API Server会在自己所有注册的子K8s Cluster都创建一份对应的API对象。在提供业务请求服务时，K8s Federation会先在自己的各个子Cluster之间做负载均衡，而对于发送到某个具体K8s Cluster的业务请求，会依照这个K8s Cluster独立提供服务时一样的调度模式去做K8s Cluster内部的负载均衡。而Cluster之间的负载均衡是通过域名服务的负载均衡来实现的。
所有的设计都尽量不影响K8s Cluster现有的工作机制，这样对于每个子K8s集群来说，并不需要更外层的有一个K8s Federation，也就是意味着所有现有的K8s代码和机制不需要因为Federation功能有任何变化。
### Volume
存储卷，K8s集群中的存储卷跟Docker的存储卷有些类似，只不过Docker的存储卷作用范围为一个容器，而K8s的存储卷的生命周期和作用范围是一个Pod。每个Pod中声明的存储卷由Pod中的所有容器共享。K8s支持非常多的存储卷类型，特别的，支持多种公有云平台的存储，包括AWS，Google和Azure云；支持多种分布式存储包括GlusterFS和Ceph；也支持较容易使用的主机本地目录hostPath和NFS。K8s还支持使用Persistent Volume Claim即PVC这种逻辑存储，使用这种存储，使得存储的使用者可以忽略后台的实际存储技术（例如AWS，Google或GlusterFS和Ceph），而将有关存储实际技术的配置交给存储管理员通过Persistent Volume来配置。
持久存储卷（Persistent Volume，PV）和持久存储卷声明（Persistent Volume Claim，PVC）
PV和PVC使得K8s集群具备了存储的逻辑抽象能力，使得在配置Pod的逻辑里可以忽略对实际后台存储技术的配置，而把这项配置的工作交给PV的配置者，即集群的管理者。存储的PV和PVC的这种关系，跟计算的Node和Pod的关系是非常类似的；PV和Node是资源的提供者，根据集群的基础设施变化而变化，由K8s集群管理员配置；而PVC和Pod是资源的使用者，根据业务服务的需求变化而变化，由K8s集群的使用者即服务的管理员来配置。

[Rook cloud-native storage orchestrator for Kubernetes](https://github.com/rook/rook)

### Node
节点，K8s集群中的计算能力由Node提供，最初Node称为服务节点Minion，后来改名为Node。K8s集群中的Node也就等同于Mesos集群中的Slave节点，是所有Pod运行所在的工作主机，可以是物理机也可以是虚拟机。不论是物理机还是虚拟机，工作主机的统一特征是上面要运行kubelet管理节点上运行的容器。
### Secret
密钥对象，Secret是用来保存和传递密码、密钥、认证凭证这些敏感信息的对象。使用Secret的好处是可以避免把敏感信息明文写在配置文件里。在K8s集群中配置和使用服务不可避免的要用到各种敏感信息实现登录、认证等功能，例如访问AWS存储的用户名密码。为了避免将类似的敏感信息明文写在所有需要使用的配置文件中，可以将这些信息存入一个Secret对象，而在配置文件中通过Secret对象引用这些敏感信息。这种方式的好处包括：意图明确，避免重复，减少暴露机会。
### User Account 、Service Account
顾名思义，用户帐户为人提供账户标识，而服务账户为计算机进程和K8s集群中运行的Pod提供账户标识。用户帐户和服务帐户的一个区别是作用范围；用户帐户对应的是人的身份，人的身份与服务的namespace无关，所以用户账户是跨namespace的；而服务帐户对应的是一个运行中程序的身份，与特定namespace是相关的。
### Namespace
名字空间为K8s集群提供虚拟的隔离作用，K8s集群初始有两个名字空间，分别是默认名字空间default和系统名字空间kube-system，除此以外，管理员可以创建新的名字空间满足需要。
### RBAC
访问授权，K8s在1.3版本中发布了alpha版的基于角色的访问控制（Role-based Access Control，RBAC）的授权模式。相对于基于属性的访问控制（Attribute-based Access Control，ABAC），RBAC主要是引入了角色（Role）和角色绑定（RoleBinding）的抽象概念。在ABAC中，K8s集群中的访问策略只能跟用户直接关联；而在RBAC中，访问策略可以跟某个角色关联，具体的用户在跟一个或多个角色相关联。显然，RBAC像其他新功能一样，每次引入新功能，都会引入新的API对象，从而引入新的概念抽象，而这一新的概念抽象一定会使集群服务管理和使用更容易扩展和重用。


## Rook Ceph


## Helm
Helm 是 Deis 开发的一个用于 Kubernetes 应用的包管理工具，主要用来管理 Charts。有点类似于 Ubuntu 中的 APT 或 CentOS 中的 YUM。

* [Official Docs](https://helm.sh/docs/intro/)
* [Hello World](https://www.hi-linux.com/posts/21466.html)

### 组件
* Helm
  > Helm 是一个命令行下的客户端工具。主要用于 Kubernetes 应用程序 Chart 的创建、打包、发布以及创建和管理本地和远程的 Chart 仓库。

* Tiller
  > Tiller 是 Helm 的服务端，部署在 Kubernetes 集群中。Tiller 用于接收 Helm 的请求，并根据 Chart 生成 Kubernetes 的部署文件（ Helm 称为 Release ），然后提交给 Kubernetes 创建应用。Tiller 还提供了 Release 的升级、删除、回滚等一系列功能。

* Chart
  > Helm 的软件包，采用 TAR 格式。类似于 APT 的 DEB 包或者 YUM 的 RPM 包，其包含了一组定义 Kubernetes 资源相关的 YAML 文件。

* Repoistory
  > Helm 的软件仓库，Repository 本质上是一个 Web 服务器，该服务器保存了一系列的 Chart 软件包以供用户下载，并且提供了一个该 Repository 的 Chart 包的清单文件以供查询。Helm 可以同时管理多个不同的 Repository。

* Release
  > 使用 helm install 命令在 Kubernetes 集群中部署的 Chart 称为 Release。

## HelloWorld

### 快速搭建本地 k8s 环境
* MAC或WINDOWS可使用https://github.com/AliyunContainerService/k8s-for-docker-desktop
* Linux minkube

```shell
//minkube
minikube docker-env          //查看docker环境变量
minikube dashboard
```

```shell
kubectl cluster-info          //查看集群信息

kubectl get nodes            //获取节点

//通过kubectl run 部署一个名为kubernetes-bootcamp的容器 --image指定容器镜像 --port指定对外暴露的端口
//Deployment可以理解为应用
//Pod 理解为一组容器的集合，一些息息相关的容器放在一个Pod中，同一个Pod中的容器共享IP和Port空间也就是在同一个命名空间。Pod 在Kubernetes是最小的调度单位，同一Pod中的容器始终被一起调度
kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080

kubectl get pods //查看当前pod     --all-namespaces

kubectl describe pod etcd-global-9002d   //查看详细pod

//将容器的8080端口映射到节点端口，随机分配的端口。也是创建服务
kubectl expose deployment/kubernetes-bootcamp --name=z2 --type="NodePort" --port 8080

kubectl get services   //查看创建的服务。可以看到应用被映射到哪个端口

curl localhost:32253 //通过端口号访问应用。32253是刚才查看服务里面找到的对应端口

kubectl get deployments

kubectl scale deployments/kubernetes-bootcamp --replicas=3   //增加三个副本

kubectl scale deployments/kubernetes-bootcamp --replicas=2   //删除一个副本

//更新image，将v1版本升级为v2版本
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2

kubectl rollout undo deployments/kubernetes-bootcamp    //回退image


//通过kubectl exec 可以直接连接到对应的节点
kubectl exec kubernetes-bootcamp-6c5cfd894b-gt6fc -it -- bash -il
kubectl exec kubernetes-bootcamp-6c5cfd894b-gt6fc -it -n namespaces /bin/bash
kubectl exec -it kubernetes-bootcamp-6c5cfd894b-gt6fc -n namespaces sh

//查看Pod下对应容器的日志， 使用-f可以直接监听文件变化
kubectl logs -f <POD_NAME> -c <CONTAINER_NAME>

//Endpoint => (Pod Ip + ContainerPort)
kubectl get endpoints

kubectl get namespace

// -n namespaces -l labelkey=labelvalue
kubectl delete deployment -n zzz -l run=test-ubuntu

kubectl run --generator=run-pod/v1 -n zzz -i --tty test-busybox --image=busybox
```

```shell
# 一个pod多个container
cat multi-pods.yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: multi-pods
spec:
  containers:
  - name: blue-pod-container
    image: busybox:1.31.1
    command: ["sleep"]
    args:    ["1000"]
  - name: green-pod-container
    image: busybox:1.30.1
    command: ["sleep"]
    args:    ["10000"]
  - name: yellow-pod-container
    image: busybox:1.30.1
    command: ["sleep"]
    args:    ["100000"]

kubectl create -f multi-pods.yaml

kubectl exec -it pod名称 -c 容器名称 sh或者bash
```

### microk8s
#### 安装
Ubuntu系统下安装microk8s非常方便，但大多情况可能会遇到安装完成后一直不能启动的问题，主要是下载k8s所需的 k8s.gcr.io 或 gcr.io 镜像出现被墙问题。
解决办法：使用 pullk8s 工具
```shell
$ sudo curl -L "https://raw.githubusercontent.com/OpsDocker/pullk8s/main/pullk8s.sh" -o /usr/local/bin/pullk8s
$ sudo chmod +x /usr/local/bin/pullk8s
```
pullk8s.sh
```bash
#!/bin/bash

check(){
  if [ "$1"x == "--microk8s"x ]
  then
    logs=`microk8s kubectl get pod --all-namespaces|tail -n +2|grep -v Running|while read line
    do
     declare -a arr=( $line )
     microk8s kubectl describe pod ${arr[1]} --namespace=${arr[0]}
    done|grep -i "image"|sed -nr 's/.*(failed to pull|Back-off pulling) image \"([^\"]+)\".*/\2/p'|uniq`
    echo ${logs}
  fi
}

pull(){
  image=$1
  imageName=${image/#k8s\.gcr\.io\//}
  if [ "$image"x == "$imageName"x ]
  then
    imageName=${image/#gcr\.io\/google_containers\//}
  fi
  echo Pull $imageName ...
  if [ "$image"x == "$imageName"x ]
  then
    echo Pull $imageName ...
    docker pull $image
    exit 0
  fi
  hubimage=${imageName//\//\-}

  if [ -n ”$hubimage“ ]
  then
    echo Pull $imageName ...
    docker pull opsdockerimage/$hubimage
    # 修改镜像名，改为和microk8s要拉的镜像名一致
    docker tag opsdockerimage/$hubimage $1
    docker rmi opsdockerimage/$hubimage
    if [ "$2"x == "--microk8s"x ]
    then
      saveImage=${1#:}
      # 导出该镜像
      docker save $saveImage > ~/.docker_image.tmp.tar
      # 把该镜像导入microk8s中
      microk8s ctr image import ~/.docker_image.tmp.tar
      rm ~/.docker_image.tmp.tar
    fi
  fi
}



if [ "$1"x == "check"x ]
then
  check $2
  exit 0
fi


if [ "$1"x == "pull"x -a $# -ge 2 ]
then
  pull $2 $3
  exit 0
fi


echo
echo "Usage:  pullk8s COMMAND [NAME[:TAG|@DIGEST]] [OPTIONS]"
echo
echo "Pull gcr.io's image for hub.docker.com"
echo
echo "Commands:"
echo "  check    Check gcr.io's fail pull images."
echo "  pull     Pull an image or a repository"
echo
echo "Options:"
echo "  --microk8s  If use MicroK8s release."
echo
echo "Examples:"
echo "  pullk8s pull k8s.gcr.io/pause:3.6 --microk8s"
echo "  pullk8s pull gcr.io/google_containers/etcd:2.0.12"
echo "  pullk8s check --microk8"
exit 1

```
检查被屏蔽的 gcr.io 或 k8s.gcr.io 容器名称
```shell
$ pullk8s check --microk8s
k8s.gcr.io/pause:3.1
-- 此时提示的 k8s.gcr.io/pause:3.1 就是pull 失败的容器名称
-- 使用 pullk8s 拉取失败的镜像，并导入到 pod 空间中
$ pullk8s pull k8s.gcr.io/pause:3.1 --microk8s
```

#### 组件
```shell
$ microk8s enable dashboard dns registry istio
```
映射端口到外部网卡
```shell
$ microk8s kubectl port-forward -n kube-system --address=0.0.0.0 service/kubernetes-dashboard 10443:443
```
获取dashboard token
```shell
microk8s dashboard-proxy
```
配置外部访问IP - EXTERNAL-IP
https://blog.csdn.net/gchan/article/details/120865800
```shell
microk8s kubectl -n istio-system edit service/istio-ingressgateway

spec:
  externalIPs:
  - 192.168.0.23

microk8s kubectl -n kube-system edit svc   kubernetes-dashboard
把spec.type修改为NodePort
在spec.ports中添加nodePort: 30000
```

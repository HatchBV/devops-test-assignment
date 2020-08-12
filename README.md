#### Goals

Deliver Helm charts for Kafka and Zookeeper deployments. Single-node application deployments is sufficient for this task.

#### Expected outcome

Pull request that will cover following requirements:
- Pull request can affect only `build` and `charts` directories;
- Kafka and Zookeeper deployments in namespace `default`;
- Connection encryption configured for:
  - Kafka broker -> Zookeeper;
  - Kafka client -> Kafka broker;
- Production-ready TLS configuration;
- All certificates should be signed with the hatch-ca (Secret in `default` namespace provided by `init.sh`);
- All servers should validate client certificates, and all clients should validate server certificates;
- [Optional]: document that will explain security concerns and solution.

#### Requirements

It's not necessary to use exact versions.  
It's provided just in case of some unexpected errors which may be version related.
```
$ docker version
Client: Docker Engine - Community
 Version:           19.03.12
 API version:       1.40
 Go version:        go1.13.10
 Git commit:        48a66213fe
 Built:             Mon Jun 22 15:45:44 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.12
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.10
  Git commit:       48a66213fe
  Built:            Mon Jun 22 15:44:15 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.13
  GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
 runc:
  Version:          1.0.0-rc10
  GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"18", GitVersion:"v1.18.3", GitCommit:"2e7996e3e2712684bc73f0dec0200d64eec7fe40", GitTreeState:"clean", BuildDate:"2020-05-20T12:52:00Z", GoVersion:"go1.13.9", Compiler:"gc", Platform:"linux/amd64"}
$ minikube version
minikube version: v1.12.1
commit: 5664228288552de9f3a446ea4f51c6f29bbdd0e0-dirty
$ helm version
Client: &version.Version{SemVer:"v2.16.9", GitCommit:"8ad7037828e5a0fca1009dabe290130da6368e39", GitTreeState:"clean"}
```

#### Test platform preparation

```
minikube start --vm-driver=docker
./init.sh
```

Result of execution: 
1. kube-cluster created with the minikube.
2. helm initialized.
3. Certificate Authority as a Secret `hatch-ca` deployed to namespace `default`.

#### Preparing custom images

If you need to build own image or customize public one you need to:
1. Add directories with Dockerfile and other dependencies into build/ directory.
2. Execute ```./build.sh```

Result of execution is docker image "my_<directory_name>".  
It can be used in helm charts.

You can find `nginx` as an example in the `build/` directory.

#### Deploy

To deploy required helm charts you need to:
1. Add directories with the helm charts into charts/ directory.
2. Execute ```./charts.sh``` 

You can find `nginx` as an example in the `charts/` directory.

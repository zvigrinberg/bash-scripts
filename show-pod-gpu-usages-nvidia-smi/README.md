# Show Pods Nvidia GPU Usages

## Prerequisites

- Access to an openshift cluster with Nvidia GPU Node.
- Login to this cluster before running the script.
- [`jq`](https://jqlang.github.io/jq/) Binary Installed on machine.
- [`oc`](https://docs.openshift.com/container-platform/4.17/cli_reference/openshift_cli/getting-started-cli.html) - Openshift CLI binary installed on your machine

## How to Use

```shell
./show-cpu-usage.sh 
```

Output:
```shell
Usage: ./show-cpu-usage.sh <ocp_gpu_node_name>
Usage: ./show-cpu-usage.sh <ocp_gpu_node_name> <output_mode>
output_mode=normal|json -> default => normal
```

1. Run with normal output
```shell
./show-cpu-usage.sh ip-10-0-40-89.ec2.internal
```
Output:
```shell
Show all GPU Replicas Utilization On Node ip-10-0-40-89.ec2.internal
Sun Jan 26 15:01:22 2025       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 550.90.07              Driver Version: 550.90.07      CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA A100-SXM4-40GB          On  |   00000000:10:1C.0 Off |                    0 |
| N/A   49C    P0             68W /  400W |   36327MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   1  NVIDIA A100-SXM4-40GB          On  |   00000000:10:1D.0 Off |                    0 |
| N/A   45C    P0             70W /  400W |    2875MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   2  NVIDIA A100-SXM4-40GB          On  |   00000000:20:1C.0 Off |                    0 |
| N/A   49C    P0             73W /  400W |     427MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   3  NVIDIA A100-SXM4-40GB          On  |   00000000:20:1D.0 Off |                    0 |
| N/A   42C    P0             66W /  400W |     427MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   4  NVIDIA A100-SXM4-40GB          On  |   00000000:90:1C.0 Off |                    0 |
| N/A   47C    P0             71W /  400W |   36327MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   5  NVIDIA A100-SXM4-40GB          On  |   00000000:90:1D.0 Off |                    0 |
| N/A   40C    P0             56W /  400W |       1MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   6  NVIDIA A100-SXM4-40GB          On  |   00000000:A0:1C.0 Off |                    0 |
| N/A   49C    P0             71W /  400W |   37883MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   7  NVIDIA A100-SXM4-40GB          On  |   00000000:A0:1D.0 Off |                    0 |
| N/A   42C    P0             65W /  400W |   37881MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
+-----------------------------------------------------------------------------------------+

Show all Pods On Node ip-10-0-40-89.ec2.internal using the GPU replicas:

pod_name=llama3-1-70b-instruct-4bit-55d47d895f-nnhrn, namespace=agent-morpheus-models, memory= 36308 Mb, node_host_pid=944907

pod_name=nim-embed-6d888b4d8b-b7qw4, namespace=agent-morpheus-models, memory= 2866 Mb, node_host_pid=2449489

pod_name=agent-morpheus-rh-6bc689bd76-67jsf, namespace=shared-morpheus, memory= 418 Mb, node_host_pid=2374114

pod_name=agent-morpheus-rh-85d979dcb6-hrvlj, namespace=mpaul-adhoc, memory= 418 Mb, node_host_pid=62698

pod_name=llama3-1-70b-instruct-4bit-55d47d895f-nnhrn, namespace=agent-morpheus-models, memory= 36308 Mb, node_host_pid=945303

pod_name=llama3-1-70b-instruct-4bit-55d47d895f-mjr9j, namespace=agent-morpheus-models, memory= 37864 Mb, node_host_pid=2449199

pod_name=llama3-1-70b-instruct-4bit-55d47d895f-mjr9j, namespace=agent-morpheus-models, memory= 37862 Mb, node_host_pid=2449724


Done!
```

2. Run with JSON Output:
```shell
./show-cpu-usage.sh ip-10-0-40-89.ec2.internal json
```
Output:
```shell
Show all GPU Replicas Utilization On Node ip-10-0-40-89.ec2.internal
Sun Jan 26 15:04:06 2025       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 550.90.07              Driver Version: 550.90.07      CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA A100-SXM4-40GB          On  |   00000000:10:1C.0 Off |                    0 |
| N/A   50C    P0             68W /  400W |   36327MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   1  NVIDIA A100-SXM4-40GB          On  |   00000000:10:1D.0 Off |                    0 |
| N/A   46C    P0             70W /  400W |    2875MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   2  NVIDIA A100-SXM4-40GB          On  |   00000000:20:1C.0 Off |                    0 |
| N/A   50C    P0             73W /  400W |     427MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   3  NVIDIA A100-SXM4-40GB          On  |   00000000:20:1D.0 Off |                    0 |
| N/A   42C    P0             66W /  400W |     427MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   4  NVIDIA A100-SXM4-40GB          On  |   00000000:90:1C.0 Off |                    0 |
| N/A   48C    P0             72W /  400W |   36327MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   5  NVIDIA A100-SXM4-40GB          On  |   00000000:90:1D.0 Off |                    0 |
| N/A   40C    P0             56W /  400W |       1MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   6  NVIDIA A100-SXM4-40GB          On  |   00000000:A0:1C.0 Off |                    0 |
| N/A   49C    P0             71W /  400W |   37883MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
|   7  NVIDIA A100-SXM4-40GB          On  |   00000000:A0:1D.0 Off |                    0 |
| N/A   42C    P0             65W /  400W |   37881MiB /  40960MiB |      0%      Default |
|                                         |                        |             Disabled |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
+-----------------------------------------------------------------------------------------+

Show all Pods On Node ip-10-0-40-89.ec2.internal using the GPU replicas:

[
  {
    "pod_name": "llama3-1-70b-instruct-4bit-55d47d895f-nnhrn",
    "namespace": "agent-morpheus-models",
    "memory": " 36308 Mb",
    "node_host_pid": "944907"
  },
  {
    "pod_name": "nim-embed-6d888b4d8b-b7qw4",
    "namespace": "agent-morpheus-models",
    "memory": " 2866 Mb",
    "node_host_pid": "2449489"
  },
  {
    "pod_name": "agent-morpheus-rh-6bc689bd76-67jsf",
    "namespace": "shared-morpheus",
    "memory": " 418 Mb",
    "node_host_pid": "2374114"
  },
  {
    "pod_name": "agent-morpheus-rh-85d979dcb6-hrvlj",
    "namespace": "mpaul-adhoc",
    "memory": " 418 Mb",
    "node_host_pid": "62698"
  },
  {
    "pod_name": "llama3-1-70b-instruct-4bit-55d47d895f-nnhrn",
    "namespace": "agent-morpheus-models",
    "memory": " 36308 Mb",
    "node_host_pid": "945303"
  },
  {
    "pod_name": "llama3-1-70b-instruct-4bit-55d47d895f-mjr9j",
    "namespace": "agent-morpheus-models",
    "memory": " 37864 Mb",
    "node_host_pid": "2449199"
  },
  {
    "pod_name": "llama3-1-70b-instruct-4bit-55d47d895f-mjr9j",
    "namespace": "agent-morpheus-models",
    "memory": " 37862 Mb",
    "node_host_pid": "2449724"
  }
]

Done!
```
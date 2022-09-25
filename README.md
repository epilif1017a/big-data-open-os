# big-data-open-os
The definitive open-source big data operating system based on containers and Kubernetes (well, that's maybe too ambitious, but it is the idea :P). This project aims to help R&D teams which don't have means (read money :-/) to use cloud resources or expensive licenses and hardware for on-prem clusters for big data analytics. The main goal of the project is to first provide the most common big data projects in a containerized way, served raw in a container runtime (e.g., Docker runtime) or through Kubernetes, and then serve as a platform to bring in more fancy and shiny big data projects into the ecosystem. For this reason, we called it the big data operating system, where more tools can be installed.

## Disclaimer
This is a personal project, developed with limited resources and availability, and is not targeting production usage. It certainly contains several things that need to be improved to reach production-grade software, and in its current state, it should not be used like that. The big-data-os project is meant to be used as a system for big data analytics in non-critical R&D environments. It certainly can be extended to reach production-grade level, that's why we are open sourcing it, so that more interested contributors can pick it up.


## Supported Features
- Fully containerized HDFS, YARN, Spark and Hive Metastore
- Beta version of the entire platform running on Kubernetes
- Kubernetes job (init-big-data-os.yaml) to init the HDFS storage structure (create folders, set permissions, upload spark yarn archive, etc...)
- Fully containerized client that enables HDFS, YARN and Spark clients to deploy Spark applications and interact with the HDFS and YARN
- UIs available:
    - Spark Web UI: 4040
    - Spark History UI: 18080
    - HDFS NN UI: 9870
    - HDFS DN UI: 9864
    - YARN RM UI: 8088
    - YARN Timeline UI: 8188

## Not Supported Features
The following features are not supported but can be easily added (e.g., via new Docker and conf files):
- MapReduce Framework 

For more info about interesting future features see ROADMAP.md

## How to deploy
The deployment of the project is solely based in config files, containers definition files and Kubernetes deployment files, so that any adaptation to each user's need is easy as changing those files, rebuild the container images, push to a registry and apply the Kubernetes deployments. 

The following steps summarize the process:

1. If you need, change configs for the big data tools (including usernames and passwords), the container specifications or the Kubernetes deployment files to accommodate your needs. At least one change needs to be made, which is the path to your container registry in each .yaml file for the Kubernetes deployments. Another possible change is the hostpath definition in the Kubernetes deployments, to have paths mounted on the location of your choice in each node.
2. Build the new container images.
3. Push the images to the container registry of your choice.
4. Use kubectl apply to deploy the several big-data-os components to Kubernetes. If you prefer to only use Docker (or other container runtime) you can simply run the containers (there are dev scripts that help you do that). To run on Kubernetes consider the following:
    1. First deploy the Hadoop component (HDFS and YARN deployed together). Important!! The first time you deploy HDFS you need to add the --format flag to the args parameter of the container hdfs-nn in hdfs-nn.yaml.
    2. Wait until HDFS is up (you can check that in the Kubernetes Dashboard or through the CLI by checking the logs and seeing that hdfs-nn has started... roughly after 1/2 mins it is ready). 
    3. Deploy the init-big-data-os Kubernetes job which will instantiate the HDFS storage structure so that YARN can start properly. This is an opportunity for future automation, but for now, unfortunately, the process is manual.
    4. Deploy Hive and Spark.
    5. (optional) deploy big-data-os-client to interact with the big-data-os components (HDFS, YARN, Spark...).
5. The cluster is ready to receive Spark applications and for that you can reuse big-data-os-client to submit your own Spark applications. In the future, user-friendly apps like Hue, Zeppelin and Jupyter are needed to make the platform more interesting for ad hoc analytics.

Note: the project was tested in docker-desktop Kubernetes context, so your mileage may vary in other contexts. We usually use Kubernetes port-forward to access the web UIs, but in distributed Kubernetes clusters you may want to set up better ways to access those UIs.

## Contributors 

Carlos Costa, https://github.com/epilif1017a

José Correia, https://github.com/jmcorreia 

## How to Contribute?
Open an issue and then follow that up with a PR :) 

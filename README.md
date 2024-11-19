# Devops Examsarbetet

Name: Hongwei Han
Class: DevOps

## Background

Previously companies preferred to apply monolithic architecture, where the entire application operates as a single, self-contained unit. However, a drawback of this approach is that it often consumes all available resources. Nowadays, microservices have gained popularity, with examples like Github successfully transitioning from a monolithic to a microservices architecture. In microservice architecture, applications are divided into smaller, independent services, allowing teams to collaborate more effectively and preventing the entire application from collapsing. In response to the microservice, the cloud computing becomes pervailing also. According to research and markets website, the global cloud computing is expected to value $832 billion through 2025. Meanwhile, 451 Rsearch shows that 90 percent of origanizations somehow obtain cloud capacity. Moreover, Kubernetes plays an important role for microservice architecture. In addition, most of devops suffered from human error when they experienced manual processes. HashiCorp co-founder Armon Dagdar introduced how the infrastructure as code handle this problem. Infrastructure-as-Code also offer benefits such as consistent configuration and improved accountability with cloud-native development. This shift highlights a gap between monolithic architecture and real-world projects. To bridge this gap, we will introduce the specific benefits of cloud computing in the following section, followed by discussions on Docker and Kubernetes in the subsequent sections. Finally, we will explain how we apply terraform to fulfill the Infrastructure-as-Code.

Nowaday, more and more companies choose to use the cloud computing. IBM has elaborated a couple of merits, when companies select cloud computing. IBM states that cloud computing is more flexible, efficiency and strategic value in comparison with the monolithic architecture.

Kubernetes is a key platform in microservices architecture. Docker primarily focuses on containerization, providing lightweight, portable, and isolated environments for applications. It simplifies deployment, distribution, and runtime operations. On the other hand, Kubernetes specializes in orchestration, automatically deploying and scaling containerized applications while ensuring high availability. This characteristic enhances the reliability and availability of our application.

In addition, infrastructure-as-code is a promising alternative to managing large-scale, distributed system, cloud-native applications and microservice architectures.

## Research Purpose

The project aims to develop a cloud-based hotel application, incorporating several macroservices such as user login, hotel booking, and payment processing.

## Planing

To achieve the research objectives, we will develop a comprehensive hotel application comprising three microservices: user login, hotel booking, and payment processing.

### Blueprint

![Blueprint](https://miro.com/app/board/uXjVLDTQ2CM=/?moveToWidget=3458764607442400329&cot=14)

### Istio-gateway

### Microservice

## Deployment

    ``` 
    terraform init
    terraform plan
    terraform apply
    ```

## Methods

- Kubernetes: scalable, resilient, and automated infrastructure environments in cloud environments

- Minikube: minikube is local Kubernetes. The advantage of minikube is that it is easy to learn and develop for Kubernetes.

- Terraform (IoC): By means of terraform, we are able to define and provide data center infrastructure using a declarative configuration language.

- Istio: load balancing and rate limiter

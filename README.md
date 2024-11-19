# Devops Examsarbetet

Name: Hongwei Han
Class: DevOps

## Background

Previously companies prefer to apply monolithic architecture, where the entire application operates as a single, self-contained unit. However, a drawback of this approach is that it often consumes all available resources. Nowadays, microservices have gained popularity, with examples like Github successfully transitioning from a monolithic to a microservices architecture. In microservice architecture, applications are divided into smaller, independent services, allowing teams to collaborate more effectively and preventing the entire application from collapsing. In response to the microservice, the clouc computing becomes pervailing also.IBM has elaborated a number of merits, when companies select cloud computing. The specific benefits of cloud computing will be explained in the next paraphrase. Moreover, Kubernetes plays an important role for microservice architecture. we are going to discuss the kubernetes in the third paraphrase. Microservices also offer benefits such as easier maintenance and compatibility with cloud-native development. This shift highlights a gap between our coursework and real-world projects. To bridge this gap, we'll introduce the theoretical background of the CAP theorem in the following section, followed by discussions on Docker and Kubernetes in the subsequent sections. Finally, we'll explore upcoming front-end techniques.

Both Docker and Kubernetes are key platforms in microservices architecture. Docker focuses on containerization, providing lightweight, portable, and isolated environments for applications. It simplifies deployment, distribution, and runtime operations. On the other hand, Kubernetes specializes in orchestration, automatically deploying and scaling containerized applications while ensuring high availability. This characteristic enhances the reliability and availability of our application.

While web services offer advantages like cross-platform compatibility and effectiveness, we plan to utilize HarmonyOS Next as our front-end technology. According to Huawei, HarmonyOS apps deliver better performance and responsiveness compared to web services. They also have access to hardware features like sensors, GPS, and cameras, allowing for the development of more functional applications. Additionally, HarmonyOS apps can work offline by storing data locally, ensuring users can access essential features even in poor network conditions.

## Research Purpose

The project aims to develop a cloud-based hotel application, incorporating several macroservices such as user login, hotel booking, and payment processing.

## Planing

To achieve the research objectives, we will develop a comprehensive hotel application comprising three microservices: user login, hotel booking, and payment processing.

### Blueprint

### Istio-gateway

### Microservice

### Between Istio-gateway and Microservice

- Each microservice has its own database, and Nacos facilitates communication between them.
- Load balancing among microservices ensured by Nginx.

## Deployment

## Methods

- Kubernetes: scalable, resilient, and automated infrastructure environments in cloud environments

- Terraform (IoC): 

- Istio: load balancing and reverse proxying: 

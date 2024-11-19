# Introduction
Name: Hongwei Han
Class: DevOps

# Background
The courses we attended primarily focused on monolithic architecture, where the entire application operates as a single, self-contained unit. However, a drawback of this approach is that it often consumes all available resources. Nowadays, microservices have gained popularity, with examples like Github successfully transitioning from a monolithic to a microservices architecture. In microservice architecture, applications are divided into smaller, independent services, allowing teams to collaborate more effectively and preventing the entire application from collapsing. Microservices also offer benefits such as easier maintenance and compatibility with cloud-native development. This shift highlights a gap between our coursework and real-world projects. To bridge this gap, we'll introduce the theoretical background of the CAP theorem in the following section, followed by discussions on Docker and Kubernetes in the subsequent sections. Finally, we'll explore upcoming front-end techniques.

Eric Brewer first introduced the CAP theorem at the Symposium on Principles of Distributed Computing in 2000. CAP stands for Consistency, Availability, and Partition Tolerance. Consistency ensures that all nodes in the application display the same data at any given time, while Availability ensures the application can respond to user requests at all times. Partition Tolerance indicates the application's ability to function properly despite network partitions. Brewer noted it's impossible to achieve all three properties simultaneously in an application, so we must prioritize two at the expense of the third. Considering the characteristics of microservices, prioritizing availability and partition tolerance is essential. For instance, when dealing with interbank transfers, availability takes precedence over consistency. Similarly, for refunds in e-commerce, availability is prioritized over consistency.

Both Docker and Kubernetes are key platforms in microservices architecture. Docker focuses on containerization, providing lightweight, portable, and isolated environments for applications. It simplifies deployment, distribution, and runtime operations. On the other hand, Kubernetes specializes in orchestration, automatically deploying and scaling containerized applications while ensuring high availability. This characteristic enhances the reliability and availability of our application.

While web services offer advantages like cross-platform compatibility and effectiveness, we plan to utilize HarmonyOS Next as our front-end technology. According to Huawei, HarmonyOS apps deliver better performance and responsiveness compared to web services. They also have access to hardware features like sensors, GPS, and cameras, allowing for the development of more functional applications. Additionally, HarmonyOS apps can work offline by storing data locally, ensuring users can access essential features even in poor network conditions.

# Research Purpose
The project aims to develop a cloud-based hotel application, incorporating several macroservices such as user login, hotel booking, and payment processing.

# Planing
To achieve the research objectives, we will develop a comprehensive hotel application comprising three microservices: user login, hotel booking, and payment processing.
### Istio-gateway

### Microservice

### Between Istio-gateway and Microservice:
- Each microservice has its own database, and Nacos facilitates communication between them.
- Load balancing among microservices ensured by Nginx.

## Deployment:
Before deployment, thorough unit testing and mock testing will ensure the functionality of all application components. Upon successful testing, we will utilize Terraform and Kubernetes to deploy the application on cloud platforms such as Azure or AWS. Additionally, DevEco-Studio will be used to design the application's frontend.

## Project Management:
Using GitHub's built-in Kanban board as an agile methodology, we will define stages of the project's workflow and set work in progress limits to prevent overloading. Weekly standup meetings will provide an opportunity for retrospective analysis and continuous improvement of the Kanban system.

# Methods

- K8s: scalable, resilient, and automated infrastructure environments in cloud environments

- Terraform: 

- Istio: load balancing and reverse proxying: 

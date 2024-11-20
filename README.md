# Devops Examsarbetet

Name: Hongwei Han
Class: DevOps

## Background

Previously, companies predominantly used monolithic architecture, where the entire application operated as a single, self-contained unit. However, a significant drawback of this approach is that it often consumes excessive resources. In contrast, microservices architecture has gained popularity, with examples like GitHub successfully transitioning from monolithic to microservices. In a microservices architecture, applications are divided into smaller, independent services, enabling teams to collaborate more effectively and reducing the risk of a single point of failure.

The rise of microservices has also fueled the growth of cloud computing. According to Research and Markets, the global cloud computing market is expected to reach $832 billion by 2025. Additionally, a report from 451 Research indicates that 90% of organizations utilize cloud capacity in some form. Kubernetes, a key enabler of microservices, has become a cornerstone technology in this architecture.

Meanwhile, many DevOps teams have struggled with human errors caused by manual processes. HashiCorp co-founder Armon Dadgar highlighted how Infrastructure-as-Code (IaC) addresses these challenges. IaC provides benefits such as consistent configuration and improved accountability, especially in cloud-native development. This shift underscores the gap between monolithic architectures and modern, real-world projects. To bridge this gap, we will explore the specific benefits of cloud computing, followed by discussions on Docker and Kubernetes. Finally, we will demonstrate how Terraform can be applied to achieve Infrastructure-as-Code.

Nowadays, more companies are adopting cloud computing due to its numerous benefits. IBM highlights key advantages, emphasizing cloud computing's flexibility, efficiency, and strategic value compared to monolithic architecture.

Cloud computing features such as scalability and storage options offer unmatched flexibility. For example, it enables businesses to easily scale IT solutions compared to the constraints of traditional hardware setups. Cloud computing also allows users to access services from anywhere at any time. As a Zoho expert noted:

    "Who wants to be constrained to a physical piece of hardware when we could be accessing work from the beach, a peaceful park, or the appointment waiting room you quickly zipped to on your lunch break?"

Furthermore, cloud computing replaces large one-time costs with a pay-as-you-go model, enhancing financial efficiency. IBM also argues that cloud computing streamlines workflows and fosters collaboration, making it easier for teams to work together effectively.

Kubernetes is a crucial platform in microservices architecture. While Docker focuses on containerization—providing lightweight, portable, and isolated environments for applications—Kubernetes specializes in orchestrating these containers. It automates deployment, scaling, and management of containerized applications, ensuring high availability and enhancing application reliability.

Infrastructure-as-Code (IaC) offers a promising alternative for managing large-scale distributed systems, cloud-native applications, and microservices architectures. Traditional DevOps practices often involve scaling up during peak demand and scaling down at off-peak times to save costs. These manual processes, however, are prone to human errors.

By codifying infrastructure and automating its management, organizations can avoid manual mistakes during scaling processes, track infrastructure changes for traceability and issue resolution, and achieve greater efficiency compared to manual configurations. Running Infrastructure-as-Code as a script creates a solid foundation for development, security, QA, and testing teams. With consistent iteration and automation, IaC supports productive workflows and minimizes errors.

## Research Purpose

The project focuses on developing infrastructure using Terraform. The infrastructure is divided into two main components:

Istio Gateway:
In the istio folder, the namespace for the Istio Gateway is defined, and the gateway is generated. Within the Istio Gateway configuration, HTTP routes are set up alongside rate-limiting policies to control traffic effectively.

Kubernetes Pod:
The second component is a Kubernetes pod that includes a virtual machine and an SQL database. This setup ensures a reliable and scalable environment for managing applications and their data.

### Blueprint

![Blueprint](https://github.com/niuniu268/DevopsExamarbetet/blob/master/Img/Screenshot%202024-11-19%20at%2004.45.26.png?raw=true)

## Deployment

    'minikube start'

    ``` 
    terraform init
    terraform plan
    terraform apply
    ```

### Istio-gateway

After applying istio-gateway, the minikube shows the configuration works well.

![Result1](https://github.com/niuniu268/DevopsExamarbetet/blob/master/Img/Screenshot%20from%202024-11-20%2006-49-53.png?raw=true)

Log file show: 

![Result2](https://github.com/niuniu268/DevopsExamarbetet/blob/master/Img/Screenshot%20from%202024-11-20%2006-50-21.png?raw=true)

### Microservice

Checking the situation of the microservices, it shows that the endpoint is exposed.

![Result3](https://github.com/niuniu268/DevopsExamarbetet/blob/master/Img/Screenshot%20from%202024-11-20%2007-02-40.png?raw=true)

## Methods

- Kubernetes: scalable, resilient, and automated infrastructure environments in cloud environments

- Minikube: minikube is local Kubernetes. The advantage of minikube is that it is easy to learn and develop for Kubernetes.

- Terraform (IaC): By means of terraform, we are able to define and provide data center infrastructure using a declarative configuration language.

- Istio-gateway: load balancing and rate limiter

## Reference

1. https://www.ibm.com/topics/cloud-computing-benefits
2. https://www.zoho.com/en-au/tech-talk/why-is-the-cloud-so-popular.html
3. https://sam-solutions.us/insights/why-cloud-computing-is-important-for-business/
4. https://www.researchandmarkets.com/report/cloud-platform?utm_source=GNOM&utm_medium=PressRelease&utm_code=8vg2fl&utm_campaign=1428189+-+Cloud+Computing+Industry+to+Grow+from+%24371.4+Billion+in+2020+to+%24832.1+Billion+by+2025%2c+at+a+CAGR+of+17.5%25&utm_exec=joca220prd
5. https://duplocloud.com/blog/infrastructure-as-code-benefits/
6. https://www.hashicorp.com/resources/what-is-infrastructure-as-code
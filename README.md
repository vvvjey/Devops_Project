# **E-Commerce Order Management System**

This repository showcases a comprehensive **E-Commerce Order Management System** with robust scalability, high availability, and modern DevOps practices. The project focuses on **seamless order processing during peak traffic**, while ensuring no orders are lost, maintaining order consistency, and enabling future expansion.

---
![image](https://github.com/user-attachments/assets/48f6e5f3-d6c3-4db7-95a5-42e95e3e6c0e)


## **Project Highlights**

### **1. CI/CD Pipeline with Jenkins**
- Automated pipeline integrated with:
  - **SonarQube:** Static code analysis for identifying bugs and vulnerabilities.
  - **Snyk:** Security checks to detect dependencies with known vulnerabilities.
  - **Postman Tests:** Automated API testing to ensure endpoint reliability.
  - **Docker Hub:** Containerized application deployment.
  - **Kubernetes Deployment:** Continuous delivery to Kubernetes clusters.
![image](https://github.com/user-attachments/assets/455bad67-4959-43bd-924c-93b76ba13b8f)


### **2. Canary Deployment Strategy**
- Implemented using **Argo Rollouts** on **DigitalOcean Kubernetes**:
  - Enables gradual rollout of updates to production.
  - Monitors system performance and rollback if necessary.
  - Ensures minimal downtime and improved user experience.
![image](https://github.com/user-attachments/assets/bd168a00-e5aa-4bf8-91cf-da9dda06e14c)

### **3. Kafka Cluster for Peak Traffic Order Processing**
- Hosted on **Kubernetes** with **Autoscaler** to handle fluctuating loads during peak times.
- **Core Features of Kafka Cluster:**
  - **Reliable Order Processing:** Guarantees no orders are lost.
  - **Synchronized Processing:** Processes orders sequentially for consistency.
  - **Scalable Architecture:** Supports future expansions by adding more partitions or consumers.
  - **High Availability:** Deployed across Kubernetes with redundancy to ensure fault tolerance.
  ![image](https://github.com/user-attachments/assets/85a5272f-1ace-4568-b895-4333902362ca)

### **4. System Monitoring with Prometheus and Grafana**
- Integrated **Prometheus** for collecting real-time metrics from the Kafka cluster, Argo Rollouts, and Kubernetes pods.
- Visualized metrics with **Grafana Dashboards** to monitor:
  - Kafka broker health and partition lag.
  - CPU, memory, and resource utilization of Kubernetes nodes.
  - Argo Rollouts deployment status and success rates.


---

## **Architecture Overview**

The system is divided into three key components:

1. **CI/CD Pipeline:**
   - Automates the build, test, and deployment process.
   - Ensures code quality and security through SonarQube and Snyk.
   - Uses Docker Hub to build and store images for Kubernetes deployment.

2. **Canary Deployment:**
   - Gradually deploys new versions of the application with Argo Rollouts.
   - Monitors real-time performance to detect and rollback faulty releases.

3. **Kafka Cluster for Order Management:**
   - Acts as the core messaging system for handling order requests.
   - Handles **order validation**, **status updates**, and **notification dispatch**.
   - Ensures all orders are processed **sequentially**, avoiding duplicates or data loss.
4. **Monitoring with Prometheus and Grafana:**
   - Prometheus scrapes metrics from Kubernetes, Kafka, and Argo Rollouts.
   - Grafana displays intuitive dashboards to ensure system health and performance.

---

## **Technical Stack**

| **Category**      | **Tools/Technologies**               |
|--------------------|--------------------------------------|
| **Programming**    | Node.js, JavaScript, YAML           |
| **CI/CD Tools**    | Jenkins, SonarQube, Snyk, Postman   |
| **Containerization** | Docker, Docker Hub                |
| **Orchestration**  | Kubernetes, DigitalOcean K8s       |
| **Deployment Strategy** | Argo Rollouts                 |
| **Messaging System** | Apache Kafka                     |
| **Autoscaling**    | Kubernetes Horizontal Pod Autoscaler |
| **Monitoring**     | Argo Rollouts Dashboard, Prometheus, Grafana |

---

## **Key Benefits**

1. **Efficient Order Processing:**
   - Kafka ensures no orders are lost, processed in sequential order.
   - High availability and scalability with Kubernetes.

2. **Resilient Deployment Process:**
   - Canary deployment minimizes risks and ensures reliable rollouts.

3. **DevOps Best Practices:**
   - Automated CI/CD pipeline with Jenkins ensures consistent code quality and delivery.
4. **Enhanced System Observability:**
   - Prometheus and Grafana provide real-time insights into system health and performance.

---

Contact
For any questions or feedback, feel free to reach out:

Author: Hoang Van Tu
Email: hoangtu4520031234@gmail.com
LinkedIn: https://www.linkedin.com/in/hoangtu03/


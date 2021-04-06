# AWS_IOT_MIGRATION_TOOL
Tool which automatically migrates an AWS IoT estate over to an equivalent Azure one.

## Problem Space

Customers will often have an AWS IoT footprint and desire to migrate or replicate that solution to Azure.  Replicating a footprint is challenging, but the migration is very challenging as it involves production devices and a combination of deployed firmware and cloud services typically providing some form of mission critical services.

## Big Rocks

IoT Solutions are a series of cloud, on premise, gateway & device infrastructure components which are typically loosely coupled and not easily identified or understood exactly how they are built up to create an end to end complete solution.  There are however typical patterns which exist.  The big rock is to figure out a way to automatically detect all of the correlated systems and convert them into a system that functions equally.  This will likely involve actual code analysis of firmware, gateways, event processors etc.

# Phase 1
## Goal
The phase 1 goal is to identify the happiest of happy paths for a very simple migration minimizing downtime.  The simplest of simple would be to detect a very basic device registry and telemetry pipeline and create a landing zone for that.  A stretch goal would be to find the code, convert it to azure and execute a firmware update via AWS's firmware update systems such that the device now connects over iot hub with the device id and meta data it had in AWS such that the data estate can be migrated as well (at a later date).  Operating on "No Device Left Behind".

## Workstreams

### 0: AWS Infrastructure & Configuration Detection
This workstream will build up the AWS infrastructure deployed and configuration included devices on that infrastructure such that an equivalent can be deployed
1. Deploy a simple IoT Streaming solution (without data storage).  AWS Thing Registry w/ MQTT broker.
2. Create simulated device firmware which pushes randomized temp values.
3. Validate AWS Solution works.
4. Write detection code which can detect the registry, brokers & devices.  Build meta data .json file for this.

### 1: Azure Infrastructure Automation
This workstream will build up the scripts and automation to deploy Azure equivalent infrastructure and automatically add the devices to it.
1. Build Terraform scripts to automate the deployment
2. Read .json file and feed as parameters to terraform
3. post process to add devices.

### 2: Device Firmware Detection & Modification
1. Given a repo location; load the repo & identify AWS components
2. Create Mapping between AWS code & Azure Code
3. Remove AWS code and add the mapped Azure code.

### 3: Automate AWS Over the Air Firmware Update w/ Azure version
1. Take updated firmware code (any kind to begin with) and execute an over the air firmware update w/ AWS
2. Grab updated repo and code from 2 and update devices w/ the azure flavor.
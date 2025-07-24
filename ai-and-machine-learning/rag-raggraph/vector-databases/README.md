<!--
---
title: "Vector Databases"
description: "Vector database infrastructure for AI/ML similarity search and embedding operations in astronomical computing workflows"
author: "VintageDon - https://github.com/vintagedon"
ai_contributor: "Claude 4 Sonnet (claude-4-sonnet-20250514)"
date: "2025-07-23"
version: "1.0"
status: "Published"
tags:
- type: directory-overview
- domain: vector-databases
- tech: milvus
- tech: pgvector
- phase: phase-1
related_documents:
- "[AI and Machine Learning](../README.md)"
- "[RAG Systems](../rag-raggraph/README.md)"
- "[PostgreSQL Databases](../../infrastructure/databases/postgresql/README.md)"
---
-->

# 🔍 **Vector Databases**

Vector database infrastructure and implementation for AI/ML workflows in the Proxmox Astronomy Lab, enabling similarity search and embedding-based operations for astronomical data analysis.

## **Overview**

This directory contains vector database implementations supporting AI/ML operations across our astronomical computing infrastructure. Vector databases enable efficient similarity search, embedding storage, and retrieval-augmented generation (RAG) workflows essential for modern astronomical data analysis and machine learning pipelines.

**Primary Focus**: Milvus vector database deployment and integration with astronomical data processing workflows, particularly supporting DESI spectral analysis and AI-powered research operations.

## **Current Implementation**

### **Milvus Vector Database**

- **Container Deployment**: Milvus standalone instance with Attu management interface
- **Integration**: pgvector PostgreSQL extension for hybrid vector/relational operations
- **Use Cases**: Spectral similarity search, embedding storage for astronomical object classification
- **Infrastructure**: Deployed on proj-milvus01 with 8 vCPU, 24GB RAM configuration

### **PostgreSQL pgvector Integration**

- **Hybrid Operations**: Vector similarity search within existing PostgreSQL databases
- **DESI Integration**: Spectral embedding storage alongside traditional astronomical catalogs
- **Performance**: Optimized indexing for high-dimensional astronomical data vectors

## **Key Features**

- **Similarity Search**: Efficient nearest-neighbor search for astronomical spectra and object embeddings
- **Embedding Storage**: Persistent storage for ML model outputs and feature vectors
- **RAG Support**: Vector retrieval capabilities for AI-powered astronomical research
- **Hybrid Queries**: Combined vector similarity and traditional SQL operations

## **Integration Points**

- **[AI Infrastructure](../README.md)** - Core AI/ML platform integration
- **[RAG Systems](../rag-raggraph/README.md)** - Retrieval-augmented generation workflows
- **[PostgreSQL Databases](../../infrastructure/databases/postgresql/README.md)** - Hybrid vector/relational operations

---

**Status**: Phase 1 - Basic vector database deployment and pgvector integration

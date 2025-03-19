# Contributing to Proxmox Astronomy Lab

Thank you for your interest in contributing to the Proxmox Astronomy Lab! This project combines enterprise-grade IT practices with radio astronomy research, creating a structured environment for both technology and scientific exploration.

This document provides guidelines for contributing to the project, whether you're improving documentation, adding code, or sharing research insights.

## Table of Contents

- [Contributing Philosophy](#contributing-philosophy)
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
  - [Documentation Contributions](#documentation-contributions)
  - [Code Contributions](#code-contributions)
  - [Infrastructure Improvements](#infrastructure-improvements)
  - [Research Contributions](#research-contributions)
- [Contribution Workflow](#contribution-workflow)
- [Document Standards](#document-standards)
- [Testing Guidelines](#testing-guidelines)
- [Review Process](#review-process)
- [Getting Help](#getting-help)

## Contributing Philosophy

The Proxmox Astronomy Lab follows a structured, enterprise-inspired approach to contribution. We value:

- **Documentation-First Development**: Changes should be documented before implementation
- **Structured Processes**: Following ITIL-inspired change management
- **Security Compliance**: Maintaining CISv8 standards across contributions
- **Knowledge Sharing**: Making complex topics accessible to different audiences

This project is a learning environment where we document both successes and failures transparently. We encourage thoughtful contributions that balance innovation with structured methodologies.

## Code of Conduct

Our community is dedicated to providing a harassment-free experience for everyone. We do not tolerate harassment in any form. Please be respectful and constructive in all interactions.

By participating, you agree to:
- Use welcoming and inclusive language
- Respect differing viewpoints and experiences
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards other community members

## Getting Started

Before making contributions, please:

1. **Explore the existing documentation** to understand the project's structure
2. **Set up a development environment** using the guidelines in our [Setup Documentation](docs/setup/README.md)
3. **Join our communication channels** to connect with the community
4. **Review our roadmap** to see where we're headed

## How to Contribute

### Documentation Contributions

Documentation is central to our project and follows specific templates and standards:

1. Use our templates found in the `documentation-processes/templates/` directory
2. Include YAML frontmatter in all Markdown documents
3. Follow our documentation hierarchy and linking conventions
4. Ensure compliance with RAG (Retrieval-Augmented Generation) optimization guidelines

```yaml
---
title: "Document Title"
description: "Brief description of content"
author: "Your Name"
tags: ["relevant-tag", "another-tag"]
category: "Main Category"
kb_type: "Reference/Tutorial/Policy/Procedure"
version: "1.0"
status: "Draft"
last_updated: "YYYY-MM-DD"
---
```

### Code Contributions

When contributing code:

1. Follow language-specific style guides:
   - Python: PEP 8
   - Bash: [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
   - Ansible: [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
2. Include comprehensive comments
3. Write tests for new functionality
4. Ensure security compliance with our CISv8 guidelines

### Infrastructure Improvements

For infrastructure-related contributions:

1. Document proposed changes using our Change Request template
2. Test changes in a development environment first
3. Consider impacts on security, monitoring, and backup systems
4. Follow the principle of infrastructure-as-code where possible

### Research Contributions

Scientific and research contributions should:

1. Include methodology documentation
2. Provide data processing information
3. Link to related datasets (if applicable)
4. Follow scientific best practices for reproducibility

## Contribution Workflow

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/AmazingFeature`)
3. **Document your proposed changes** using appropriate templates
4. **Commit your changes** with clear, descriptive commit messages
5. **Push to your branch** (`git push origin feature/AmazingFeature`)
6. **Open a Pull Request** with a detailed description
7. **Address review feedback** until approved
8. **Merge after approval**

All contributions should follow our conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Types include: docs, feat, fix, chore, style, refactor, perf, test

## Document Standards

Documentation should be:

- **Clear and concise**: Avoid jargon unless necessary
- **Comprehensive**: Cover all aspects of the topic
- **Structured**: Follow hierarchical organization
- **Properly formatted**: Use Markdown features appropriately
- **Tagged appropriately**: Include relevant metadata for searchability

## Testing Guidelines

1. **Unit Tests**: All code contributions should include unit tests
2. **Integration Tests**: For changes affecting multiple components
3. **Documentation Tests**: Ensure documentation builds and links work
4. **Security Testing**: Validate compliance with security standards

## Review Process

All contributions undergo a structured review process:

1. **Initial Review**: Basic checks for format and completeness
2. **Technical Review**: In-depth evaluation of technical correctness
3. **Security Review**: Assessment of security implications
4. **Final Approval**: Confirmation by project maintainers

Larger changes may require multiple reviews or a virtual Change Advisory Board (CAB) review.

## Getting Help

If you need assistance or have questions:

- **Open an Issue** for specific questions
- **Join our Discussion Forum** for broader topics
- **Check Existing Documentation** for answers to common questions

---

Thank you for contributing to the Proxmox Astronomy Lab! Your efforts help advance both our technical infrastructure and scientific research goals.

*This document is a living guide and will be updated as our project evolves.*

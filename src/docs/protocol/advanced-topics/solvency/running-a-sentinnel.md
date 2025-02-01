---
sidebar_position: 2
---

# Running a Sentinel

In our section on [Liquidations & TOGA](./liquidations-and-toga.mdx), we described how the Superfluid protocol handles solvency & liquidations. Sentinels play a vital role in this process. This page provides links to various resources that will aid you on your journey to help secure the protocol 🛡⚔️

### Who Should Run a Sentinel?

1. Crypto enthusiasts who want to help secure a new, innovative primitive for web3 😁
2. Teams that have a service running on Superfluid. Perhaps you’ve launched your own dapp or your own Super Token, and you want to be 100% certain that your users are in good standing.
3. Professional operators who want to run profitable enterprises. If you have DevOps skills and/or you’re able to acquire capital to become the PIC for several tokens, participating in this process could be a good opportunity!

## Getting Started

### Running a Sentinel - Step By Step Guide

<div style={{ textAlign: 'center', margin: '20px' }}>
<iframe width="700" height="400" src="https://www.youtube.com/embed/COo9IoVU9A0?si=OZFO1MOSNHNNr8sG&amp;start=1147" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</div>

### Sentinel Repository

If you want to start running a Sentinel today, you can clone [this repo](https://github.com/superfluid-finance/superfluid-sentinel) and customize your own `.env` file before starting the software. At minimum, you're going to need a reliable RPC URL, and a private key with native tokens to pay for gas when performing liquidations. Detailed instructions for running your Sentinel can be found in the repository's README and in the above video.

<div style={{ textAlign: 'center', margin: '20px' }}>
<a href="https://github.com/superfluid-finance/superfluid-sentinel" target="_blank" rel="noopener noreferrer">
    <img src="https://img.shields.io/badge/GitHub-View%20Repo-black?style=for-the-badge&logo=github" alt="GitHub" />
</a>
</div>

### Becoming the PIC

You can become the PIC by connecting your wallet at the [TOGA dashboard.](https://toga.superfluid.finance/) There, you'll also see information on the current PIC stake amount, stream data by token, and a real time list of all liquidations. TOGA contract addresses are also available in our [Explorer](https://Explorer.superfluid.finance/) for each network.


<div style={{ textAlign: 'center', margin: '20px' }}>
  <a href="https://toga.superfluid.finance" target="_blank" rel="noopener noreferrer">
    <button class="button-50" role="button">The TOGA Dashboard</button>
  </a>
</div>

### Additional Resources

Running sentinels does require some active management.&#x20;

We recommend you to join our discord server, and specifically the sentinels channel to keep in touch with any news and updates!

<div style={{ textAlign: 'center', margin: '20px' }}>
[![Join our Discord](https://img.shields.io/badge/Join%20our%20Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](http://discord.superfluid.finance)
</div>

## Glossary of Terms:

**Buffer**: The amount of tokens that an account must temporarily lock up when a stream is started.

**Liquidation**: Occurs when a stream is closed by a sentinel once an account's token balance hits zero while still streaming funds

**Sentinel**: A node that watches the Superfluid network & closes streams when they become critical or insolvent. Anyone can become a Sentinel by running a node

**PIC**: The Patrician in Charge who receives rewards each time a stream is closed in the priority period when an account goes critical

**TOGA**: the Transparent Ongoing Auction which allows anyone to become the Patrician in Charge (PIC) if they put up a higher staked amount than the previous PIC

**Stake**: The amount of funds locked in the TOGA contract by the Patrician in Charge (PIC)
---
sidebar_position: 1
---

import Link from '@docusaurus/Link';

# Auto-Wrap

## What's Auto-Wrap?

Auto-Wrap is an automated token wrapping system that automatically wraps ERC20 tokens to Super Tokens just in time to keep your streams running. When your Super Token balance reaches a certain lower threshold, Auto-Wrap steps in and wraps enough tokens into the needed Super Token on your behalf to ensure you never run out of balance, as that would make all streams stop.

<div style={{ textAlign: 'center', margin: '20px' }}>
   <a 
      href="https://www.notion.so/superfluidhq/Setting-Up-Superfluid-Auto-Wrap-9a565d53bbee4bdc953cc2a656c43761"
      className="button-link"
      style={{
         backgroundColor: 'green',
         color: 'white',
         fontSize: '16px',
         padding: '10px 20px',
         textDecoration: 'none',
         borderRadius: '4px',
         display: 'inline-block'
      }}
   >
      Click here for full a guide on how to set up an Auto-Wrap Automation
   </a>
</div>

## Why Auto-Wrap?

Most organizations don’t hold their assets as Super Tokens. DAOs are more likely to hold USDC than USDCx in their treasury to limit exposure to third party protocols. So when a DAO is paying contributors in streams of USDCx they need to ensure they periodically wrap additional USDC in USDCx to keep their streams running. This can be a tedious manual process because it requires you to:

1. Periodically check the Super Token balance to make sure it isn’t reaching zero.
2. If it is approaching zero, manually wrap additional USDC to USDCx to avoid running out of USDCx balance.

With Auto-Wrap, this manual process is fully automated. The system keeps monitoring a wallet balance of a specific token (i.e. USDC) and when it’s too low (normally less than 2 days worth of outgoing streaming) it automatically wraps a variable amount (normally 7 days worth of outgoing streaming) to keep streams running over time. All payroll admin needs to do is ensure they’re holding enough USDC in their wallet - the wrapping part is taken care of by Auto-Wrap.

## Example

1. Auto-Wrap identifies that the DAO’s DAIx balance is running low. In this example, it’s less than a two days away from running out of DAIx.

<div style={{ display: 'flex', justifyContent: 'center' }}>
![Auto-Wrap identifying low balance](/assets/image_(5)_(3)_(1).png)
</div>

2. Auto-Wrap automatically steps in and replenishes the DAIx balance back to seven days worth of outgoing stream so payment continues without interruption. No manual triggering required!

<div style={{ display: 'flex', justifyContent: 'center' }}>
![Auto-Wrap replenishing balance](/assets/image_(8).png)
</div>

## Setting Up Auto-Wrap

To set up Auto-Wrap for your organization, follow the detailed guide available here:

<div style={{ textAlign: 'center', margin: '20px' }}>
   <a 
      href="https://www.notion.so/superfluidhq/Setting-Up-Superfluid-Auto-Wrap-9a565d53bbee4bdc953cc2a656c43761"
      className="button-link"
      style={{
         backgroundColor: 'green',
         color: 'white',
         fontSize: '16px',
         padding: '10px 20px',
         textDecoration: 'none',
         borderRadius: '4px',
         display: 'inline-block'
      }}
   >
      Click here for full a guide on how to set up an Auto-Wrap Automation
   </a>
</div>

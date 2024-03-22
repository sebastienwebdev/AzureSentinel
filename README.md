<h1>Azure Sentinel </h1>

 ### [Medium Article Demonstration](https://medium.com/@sebastienwebdev/azure-sentinel-honeypot-522959b7b734)

<h2>Description</h2>
This project is by setting up a virtual honeypot lab using Azure Sentinel, Microsoft's advanced SIEM system. This project is tailored for beginners and MacBook users, providing a step-by-step guide to attract and analyze cyberattacks in a controlled environment. Starting with creating a vulnerable Azure VM, you’ll intentionally expose it to simulate real-world cyber threats. Integrating Azure Log Analytics and employing PowerShell scripts, you’ll extract and enrich attackers' IP data, gaining insights into the geographical origins of cyber threats.

<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*uvW4kjIJ-TbB3-qQX7qnBA.png" height="80%" width="80%" />

<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell: Extract RDP failed logon logs from Windows Event Viewer</b> 
- <b>ipgeolocation.io: IP Address to Geolocation API</b>

<h2>Environments Used </h2>

- <b>MacOS</b>
- <b>Azure Sentinel</b>

<h2>Program walk-through:</h2>

<p align="center">
Make the VM Vulnerable: <br/>
<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*pPET7HvZl0Xkt77fHwLkqQ.png" height="80%" width="80%" alt="VM Vulnerable Steps"/>
  <img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*AW9ypz0Zj7GWgOizfT4NlA.png" height="80%" width="80%" alt="VM Vulnerable Steps"/>
<br />
<br />
Setup Log Analytics:  <br/>
<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*zndQ3lg0D36LmbfF9mD-Zw.png" height="80%" width="80%" alt="Log Analytics Steps"/>
  <img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*iPiDGZAqDabUUrwXprkDkw.png" height="80%" width="80%" alt="Log Analytics Steps"/>
<br />
<br />
Attacks: <br/>
<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*LK-SxS0HULYhb3x2j3j3Qw.png" height="80%" width="80%" />

  <h2>World Map </h2>
<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*jzmzT8SSvrOrjLB2kvKroA.png" height="80%" width="80%" />
</p>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>

# Network Lists
Last update: 2025-01-15 08:07:26 UTC

## Usage with iptables

You can directly use these ipset lists with iptables. Here's how:

1. Create new ipset:
```bash
ipset create company_networks hash:net
```

2. Load the IPv4 networks (replace COMPANY with desired company name in lowercase):
```bash
curl -s https://raw.githubusercontent.com/Her0x27/cfa/master/ipv4.COMPANY.ipset | while read line; do ipset add company_networks $line; done
```

3. Use with iptables:
```bash
iptables -A INPUT -m set --match-set company_networks src -j DROP
```

## Available Company Lists
## Anthropic
- IPv4 Networks: 4 ([ipv4.anthropic.ipset](ipv4.anthropic.ipset))
- IPv6 Networks: 2 ([ipv6.anthropic.ipset](ipv6.anthropic.ipset))

## OpenAI
- IPv4 Networks: 7 ([ipv4.openai.ipset](ipv4.openai.ipset))
- IPv6 Networks: 1 ([ipv6.openai.ipset](ipv6.openai.ipset))

## Akamai
- IPv4 Networks: 764 ([ipv4.akamai.ipset](ipv4.akamai.ipset))
- IPv6 Networks: 413 ([ipv6.akamai.ipset](ipv6.akamai.ipset))

## Discord
- IPv4 Networks: 2 ([ipv4.discord.ipset](ipv4.discord.ipset))
- IPv6 Networks: 0 ([ipv6.discord.ipset](ipv6.discord.ipset))

## Valve
- IPv4 Networks: 82 ([ipv4.valve.ipset](ipv4.valve.ipset))
- IPv6 Networks: 37 ([ipv6.valve.ipset](ipv6.valve.ipset))

## YouTube
- IPv4 Networks: 40 ([ipv4.youtube.ipset](ipv4.youtube.ipset))
- IPv6 Networks: 24 ([ipv6.youtube.ipset](ipv6.youtube.ipset))

## Epic Games
- IPv4 Networks: 6 ([ipv4.epic games.ipset](ipv4.epic games.ipset))
- IPv6 Networks: 0 ([ipv6.epic games.ipset](ipv6.epic games.ipset))

## GOG
- IPv4 Networks: 68 ([ipv4.gog.ipset](ipv4.gog.ipset))
- IPv6 Networks: 4 ([ipv6.gog.ipset](ipv6.gog.ipset))

## Origin
- IPv4 Networks: 319 ([ipv4.origin.ipset](ipv4.origin.ipset))
- IPv6 Networks: 42 ([ipv6.origin.ipset](ipv6.origin.ipset))

## Blizzard Entertainment
- IPv4 Networks: 9 ([ipv4.blizzard entertainment.ipset](ipv4.blizzard entertainment.ipset))
- IPv6 Networks: 1 ([ipv6.blizzard entertainment.ipset](ipv6.blizzard entertainment.ipset))

## YouTube
- IPv4 Networks: 40 ([ipv4.youtube.ipset](ipv4.youtube.ipset))
- IPv6 Networks: 24 ([ipv6.youtube.ipset](ipv6.youtube.ipset))

## Summary
- Total IPv4 Networks: 1301
- Total IPv6 Networks: 524
- Combined IPv4 List: [ipv4.colist.ipset](ipv4.colist.ipset)
- Combined IPv6 List: [ipv6.colist.ipset](ipv6.colist.ipset)

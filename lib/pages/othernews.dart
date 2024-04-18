import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class startup extends StatelessWidget {
  final List<Map<String, String>> startupNews =[
    {
      "title": "Mexican fintech startup Stori reaches unicorn status with \$50M equity raise",
      "url": "https://techcrunch.com/2022/07/15/mexican-fintech-startup-stori-reaches-unicorn-status-with-50m-equity-raise/",
      "source": "techcrunch"
    },
    {
      "title": "The Week’s 10 Biggest Funding Rounds: Monolith Closes Monolithic Round; Pico Picks Up \$200M",
      "url": "https://news.crunchbase.com/venture/biggest-funding-rounds-vc-monolith-pico/",
      "source": "crunchbase"
    },
    {
      "title": "Monolith Raises \$300M+ To Reduce Fossil Fuel Dependency",
      "url": "https://news.crunchbase.com/clean-tech-and-energy/clean-energy-hydrogen-producer-monolith/",
      "source": "crunchbase"
    },
    {
      "title": "Areteia Therapeutics Raises \$350M To Create An Oral Asthma Treatment",
      "url": "https://news.crunchbase.com/venture/asthma-treatment-startup-areteia-bain-capital/",
      "source": "crunchbase"
    },
    {
      "title": "Alternative To Venture—Capchase Raises \$400M In Debt",
      "url": "https://news.crunchbase.com/venture/capchase-raises-400m-debt/",
      "source": "crunchbase"
    },
    {
      "title": "Bishop Fox Looks to Provide Offensive Security with \$75M In Additional Funding ",
      "url": "https://gritdaily.com/bishop-fox-looks-to-provide-offensive-security-with-75m-in-additional-funding/",
      "source": "gritdaily"
    },
    {
      "title": "Okendo Raises \$26M to Help Retailers Build Trust with High-Impact Customer Reviews ",
      "url": "https://gritdaily.com/okendo-raises-26m-to-help-retailers-build-trust-with-high-impact-customer-reviews/",
      "source": "gritdaily"
    },
    {
      "title": "Robin Receives \$30M to Make Hybrid Work More Convenient with Its Office Reservation Software ",
      "url": "https://gritdaily.com/robin-receives-30m-to-make-hybrid-work-more-convenient-with-its-office-reservation-software/",
      "source": "gritdaily"
    },
    {
      "title": "You Looks to Become the Next Big Search Engine with \$25M In Funding ",
      "url": "https://gritdaily.com/you-looks-to-become-the-next-big-search-engine-with-25m-in-funding/",
      "source": "gritdaily"
    },
    {
      "title": "Hivery Plans to Revolutionize Product Placement with \$30M In New Funding ",
      "url": "https://gritdaily.com/hivery-plans-to-revolutionize-product-placement-with-30m-in-new-funding/",
      "source": "gritdaily"
    },
    {
      "title": "Deci AI Raises \$25M to Solve AI Efficiency with AI and Bring Applications to Production Faster ",
      "url": "https://gritdaily.com/deci-ai-raises-25m-to-solve-ai-efficiency-with-ai-and-bring-applications-to-production-faster/",
      "source": "gritdaily"
    },
    {
      "title": "Incident.io Raises \$28.7M to Aid Organizations In Dealing with Incidents at Scale ",
      "url": "https://gritdaily.com/incident-io-raises-28-7m-to-aid-organizations-in-dealing-with-incidents-at-scale/",
      "source": "gritdaily"
    },
    {
      "title": "Bishop Fox Looks to Provide Offensive Security with \$75M In Additional Funding ",
      "url": "https://gritdaily.com/bishop-fox-looks-to-provide-offensive-security-with-75m-in-additional-funding/",
      "source": "gritdaily"
    },
    {
      "title": "Okendo Raises \$26M to Help Retailers Build Trust with High-Impact Customer Reviews ",
      "url": "https://gritdaily.com/okendo-raises-26m-to-help-retailers-build-trust-with-high-impact-customer-reviews/",
      "source": "gritdaily"
    },
    {
      "title": "Robin Receives \$30M to Make Hybrid Work More Convenient with Its Office Reservation Software ",
      "url": "https://gritdaily.com/robin-receives-30m-to-make-hybrid-work-more-convenient-with-its-office-reservation-software/",
      "source": "gritdaily"
    },
    {
      "title": "You Looks to Become the Next Big Search Engine with \$25M In Funding ",
      "url": "https://gritdaily.com/you-looks-to-become-the-next-big-search-engine-with-25m-in-funding/",
      "source": "gritdaily"
    },
    {
      "title": "Hivery Plans to Revolutionize Product Placement with \$30M In New Funding ",
      "url": "https://gritdaily.com/hivery-plans-to-revolutionize-product-placement-with-30m-in-new-funding/",
      "source": "gritdaily"
    },
    {
      "title": "Taking Your Business From \$0 to \$10M ARR with Kyle Racki ",
      "url": "https://gritdaily.com/kyle-racki-ceo-of-proposify-on-taking-your-business-from-0-to-10m-arr/",
      "source": "gritdaily"
    },
    {
      "title": "Deci AI Raises \$25M to Solve AI Efficiency with AI and Bring Applications to Production Faster ",
      "url": "https://gritdaily.com/deci-ai-raises-25m-to-solve-ai-efficiency-with-ai-and-bring-applications-to-production-faster/",
      "source": "gritdaily"
    },
    {
      "title": "Incident.io Raises \$28.7M to Aid Organizations In Dealing with Incidents at Scale ",
      "url": "https://gritdaily.com/incident-io-raises-28-7m-to-aid-organizations-in-dealing-with-incidents-at-scale/",
      "source": "gritdaily"
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup News'),
      ),
      body:  ListView.builder(
          itemCount: startupNews.length,
          itemBuilder: (context, index) {
            final newsItem = startupNews[index];
            return Card(
              child: ListTile(
                leading: Text("${index + 1}"),
                title: Text(newsItem['title'] ?? ''),
                onTap: () {
                  _launchURL(newsItem['url'] ?? '');
                },
              ),
            );
          },
        ),
      
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

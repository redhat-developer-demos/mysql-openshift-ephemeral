using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using mvcCustomer.Models;
using System.Net;
using Nancy.Json;

namespace mvcCustomer.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            List<CustomerSummary> summaryList = new List<CustomerSummary>();

            // Call service to get summary list of customers
            List<CustomerSummary> customerSummaryList = new List<CustomerSummary>();
            using (var client = new WebClient())
            {
                var json = client.DownloadString("getCustomerSummaryList");
                var serializer = new JavaScriptSerializer();
                customerSummaryList = serializer.Deserialize<List<CustomerSummary>>(json);
            }

            ViewBag.Message = customerSummaryList;
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

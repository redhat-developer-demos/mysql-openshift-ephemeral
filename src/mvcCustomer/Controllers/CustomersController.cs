using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using mvcCustomer.Models;
using Nancy.Json;

namespace mvcCustomer.Controllers
{
    public class CustomersController : Controller
    {
        public IActionResult Index()
        {
            // Call service to get summary list of customers
            List<CustomerSummary> customerSummaryList = new List<CustomerSummary>();
            using (var client = new System.Net.WebClient())
            {
//                string uri = "http://getcustomersummarylist-mysql-test.apps.mysql.rhdemos.com/customers";
//                string uri = "getcustomersummarylist/customers";
                string uri = Environment.GetEnvironmentVariable("GET_CUSTOMER_SUMMARY_LIST_URI");
                var json = client.DownloadString(uri);
                var serializer = new JavaScriptSerializer();
                customerSummaryList = serializer.Deserialize<List<CustomerSummary>>(json);
            }

            return View(customerSummaryList);
        }
        public IActionResult Customer(int id)
        {
            var customer = new Customer();
            using (var client = new System.Net.WebClient())
            {
//                string uri = "http://getcustomer-mysql-test.apps.mysql.rhdemos.com/customer/" + id.ToString();
//                string uri = "getcustomer/customer/" + id.ToString();
                string uri = Environment.GetEnvironmentVariable("GET_CUSTOMER_URI");
                var json = client.DownloadString(uri);
                var serializer = new JavaScriptSerializer();
                customer = serializer.Deserialize<Customer>(json);
            }
            return View(customer);
        }
    }
}
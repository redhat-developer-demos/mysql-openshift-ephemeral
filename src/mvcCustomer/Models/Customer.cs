using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace mvcCustomer.Models
{
    public class Customer
    {
        [Display(Name = "Customer ID")]
        public int Id { get; set; }

        [Display(Name = "Customer Name")]
        public string CustomerName { get; set; }
        
        [Display(Name = "Effective Date")]
        public DateTime EffectiveDate { get; set; }
        
        [Display(Name ="Description")]
        public string Description { get; set; }
        
        [Display(Name ="Status Code")]
        public int Status { get; set; }

        [Display(Name = "Status")]
        public string StatusDescription
        {
            get
            {
                if (Status == 1)
                {
                    return "Active";
                } else
                {
                    return "INACTIVE";
                }
            }
        }
    }
}
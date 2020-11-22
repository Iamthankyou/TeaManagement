//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Project
{
    using System;
    using System.Collections.Generic;
    
    public partial class Bill
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Bill()
        {
            this.Items = new HashSet<Item>();
        }
    
        public string BillId { get; set; }
        public Nullable<System.DateTime> OrderTimeStart { get; set; }
        public string Payments { get; set; }
        public string TableId { get; set; }
        public Nullable<int> Total { get; set; }
        public Nullable<System.DateTime> OrderTimeEnd { get; set; }
        public string UserName { get; set; }
        public string PhoneNumber { get; set; }
        public string CodeVoucher { get; set; }
    
        public virtual Customer Customer { get; set; }
        public virtual TableSpace TableSpace { get; set; }
        public virtual Staff Staff { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Item> Items { get; set; }
        public virtual Voucher Voucher { get; set; }
    }
}

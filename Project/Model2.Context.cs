﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class tea01Entities2 : DbContext
    {
        public tea01Entities2()
            : base("name=tea01Entities2")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Bill> Bills { get; set; }
        public virtual DbSet<Customer> Customers { get; set; }
        public virtual DbSet<Drink> Drinks { get; set; }
        public virtual DbSet<DrinkType> DrinkTypes { get; set; }
        public virtual DbSet<Item> Items { get; set; }
        public virtual DbSet<Permision> Permisions { get; set; }
        public virtual DbSet<PermisionDetail> PermisionDetails { get; set; }
        public virtual DbSet<Resource> Resources { get; set; }
        public virtual DbSet<Staff> Staffs { get; set; }
        public virtual DbSet<sysdiagram> sysdiagrams { get; set; }
        public virtual DbSet<TableSpace> TableSpaces { get; set; }
        public virtual DbSet<Topping> Toppings { get; set; }
    }
}
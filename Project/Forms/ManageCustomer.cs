﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Migrations;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project.Forms
{
    public partial class ManageCustomer : Form
    {
        public ManageCustomer()
        {
            InitializeComponent();
        }

        private void ManageCustomer_Load(object sender, EventArgs e)
        {
            updateGridView();
            topCustomer();
        }

        private void topCustomer()
        {
            tea01Entities2 db = new tea01Entities2();
            DateTime start = startDate.Value;
            DateTime end = endDate.Value;

            //var query = (from customer in db.Set<Customer>() join bill in db.Set<Bill>() on customer.PhoneNumber equals bill.PhoneNumber where bill.OrderTimeStart >= start && bill.OrderTimeStart <= end select new { customer.PhoneNumber, customer.FullName, bill.Total } into x group x by new { x.PhoneNumber, x.FullName, x.Total } into y select new { y.Key.FullName, Sum = y.Sum(u=>u.Total)}).OrderByDescending(z=>z.Sum) ;
            var query = (from customer in db.Set<Customer>() join bill in db.Set<Bill>() on customer.PhoneNumber equals bill.PhoneNumber where bill.OrderTimeStart >= start && bill.OrderTimeStart <= end select new { customer.PhoneNumber, customer.FullName, bill.Total } into x group x by new { x.PhoneNumber, x.FullName} into y select new { y.Key.FullName, Sum = y.Sum(u => u.Total)}).OrderByDescending(z=>z.Sum);

            gridViewTop.DataSource = query.ToList();
            
            if (gridViewTop.ColumnCount > 0)
            {
                gridView.Columns[0].HeaderText = "Tên khách";
                gridView.Columns[1].HeaderText = "Tổng";
            }
        }

        private void updateGridView()
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.Customers.ToList();

            for (int i=0; i<gridView.ColumnCount; i++)
            {
                if (i == 1)
                {
                    gridView.Columns[i].Visible = true;
                    gridView.Columns[i].HeaderText = "Tên khách";
                    continue;
                }

                gridView.Columns[i].Visible = false;
            }
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            Customer customer = db.Customers.Find(gridView.CurrentRow.Cells[0].Value);

            if (customer != null)
            {
                phone.Text = customer.PhoneNumber;
                name.Text = customer.FullName;
                address.Text = customer.Address;

                lbLevelPoint.Text = customer.Level.ToString();

                var sum = customer.Bills.Sum(u => u.Total);

                lbSum.Text = sum.ToString() + "VNĐ";
                
                var bill = customer.Bills.OrderByDescending(u => u.OrderTimeStart).FirstOrDefault();

                if (bill != null)
                {
                    lbRecentBill.Text = bill.BillId;
                }


                String drinkId = "";
                
                var bill2 = customer.Bills;

                var map = new Dictionary<string, int>();

                foreach (var i in bill2)
                {
                    foreach (var item in i.Items)
                    {
                        int count = 0;
                        if (map.ContainsKey(item.DrinkId))
                        {
                            map[item.DrinkId] = map[item.DrinkId]++;
                        }
                        else
                        {
                            map.Add(item.DrinkId, count);
                        }
                    }
                }

                if (map.Count > 0)
                {
                    var id = map.Max(u => u.Value);
                    foreach (var i in map.Keys.ToList())
                    {
                        if (map[i] == id)
                        {
                            drinkId = i;
                        }
                    }

                    if (db.Drinks.Find(drinkId) != null)
                    {
                        lbBestDrink.Text = db.Drinks.Find(drinkId).DrinkName;
                    }
                }


            }
        }

        private void bunifuButton7_Click(object sender, EventArgs e)
        {
            if (phone.Text.Length == 10 && name.Text != "" && address.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();

                db.Customers.AddOrUpdate(new Customer()
                {
                    PhoneNumber = phone.Text,
                    FullName = name.Text,
                    Address = address.Text,
                    Level = 0
                });

                db.SaveChanges();

                MessageBox.Show("Đã cập nhật vào cơ sở dữ liệu");
            }
        }

        private void bunifuButton11_Click(object sender, EventArgs e)
        {

            //MessageBox.Show(j.ActionName);
            PrevHome home = new PrevHome();

            this.Hide();
            home.ShowDialog();
            this.Close();
                
        }

        private void bunifuButton13_Click(object sender, EventArgs e)
        {
            topCustomer();
        }
    }
}

﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project.Forms
{
    public partial class PrevHome : Form
    {
        public PrevHome()
        {
            InitializeComponent();
        }

        private void bunifuImageButton1_Click(object sender, EventArgs e)
        {

        }

        private void PrevHome_Load(object sender, EventArgs e)
        {

        }

        private void bunifuFlatButton1_Click(object sender, EventArgs e)
        {
           

        }

        private void bunifuButton14_Click(object sender, EventArgs e)
        {
            ManageResource manageResource = new ManageResource();
            this.Hide();
            manageResource.ShowDialog();
            this.Close();
        }

        private void bunifuButton13_Click(object sender, EventArgs e)
        {
            ManageBill manageBill = new ManageBill();
            this.Hide();
            manageBill.ShowDialog();
            this.Close();
        }

        private void bunifuButton12_Click(object sender, EventArgs e)
        {
            ShowAddTopping showAddTopping = new ShowAddTopping();
            this.Hide();
            showAddTopping.ShowDialog();
            this.Close();
        }

        private void bunifuButton8_Click(object sender, EventArgs e)
        {
            ManageStaff manageStaff = new ManageStaff();
            this.Hide();
            manageStaff.ShowDialog();
            this.Close();
        }

        private void bunifuButton9_Click(object sender, EventArgs e)
        {
            Analysis analysis = new Analysis();
            this.Hide();
            analysis.ShowDialog();
            this.Close();
        }

        private void bunifuButton10_Click(object sender, EventArgs e)
        {
            ShowAddDrink showAddDrink = new ShowAddDrink();
            this.Hide();
            showAddDrink.ShowDialog();
            this.Close();
        }

        private void bunifuButton2_Click(object sender, EventArgs e)
        {
            ManageVoucher manageVoucher = new ManageVoucher();
            this.Hide();
            manageVoucher.ShowDialog();
            this.Close();
        }

        private void bunifuButton4_Click(object sender, EventArgs e)
        {
            AddTable addTable = new AddTable();
            this.Hide();
            addTable.ShowDialog();
            this.Close();
        }

        private void bunifuButton3_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            Staff staff = db.Staffs.Find(SignIn.username);
            Boolean flag = false;

            foreach (var i in staff.Permisions)
            {
                foreach (var j in i.PermisionDetails)
                {
                    if (j.ActionName == "C")
                    {
                        //MessageBox.Show(j.ActionName);
                        flag = true;
                        Home home = new Home();
                        this.Hide();
                        home.ShowDialog();
                        this.Close();
                    }
                }
            }

            if (!flag)
            {
                MessageBox.Show("Hãy phấn đấu và bạn sẽ có quyền vào đây");
            }
        }

        private void bunifuButton6_Click(object sender, EventArgs e)
        {
            SignIn signIn = new SignIn();
            this.Hide();
            signIn.ShowDialog();
            this.Close();
        }

        private void bunifuButton5_Click(object sender, EventArgs e)
        {
            ManageCustomer manageCustomer = new ManageCustomer();
            this.Hide();
            manageCustomer.ShowDialog();
            this.Close();
        }
    }
}

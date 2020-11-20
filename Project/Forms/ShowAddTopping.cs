using System;
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
    public partial class ShowAddTopping : Form
    {
        public ShowAddTopping()
        {
            InitializeComponent();
        }

        private void updateGridView()
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.Toppings.Select(u => new { u.ToppingId, u.ToppingName}).ToList();


            gridView.Columns[0].HeaderText = "Id Topping";
            gridView.Columns[1].HeaderText = "Tên Topping";

            txId.Text = (db.Toppings.ToList().Count + 1).ToString();

            gridView.Columns[0].Visible = false;
        }

        private void ShowAddTopping_Load(object sender, EventArgs e)
        {
            updateGridView();
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var topping = db.Toppings.Find(gridView.CurrentRow.Cells[0].Value.ToString());

            txId.Text = topping.ToppingId;
            txName.Text = topping.ToppingName;
            txPrice.Text = topping.Price.ToString();

        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txId.Text != "" && txName.Text != "" && txPrice.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();

                db.Toppings.AddOrUpdate(new Topping()
                {
                    ToppingId = txId.Text,
                    ToppingName = txName.Text,
                    Price = Convert.ToInt32(txPrice.Text),
                });

                db.SaveChanges();


                txId.Text = (db.Toppings.ToList().Count + 1).ToString();
                txName.Text = "";
                txPrice.Text = "";

                updateGridView();
            }

        }
    }
}

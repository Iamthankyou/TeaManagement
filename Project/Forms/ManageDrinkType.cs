using System;
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
    public partial class ManageDrinkType : Form
    {
        public ManageDrinkType()
        {
            InitializeComponent();
        }

        private void bunifuButton3_Click(object sender, EventArgs e)
        {

        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (txID.Text!="" && txName.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();
                int count = db.DrinkTypes.ToList().Count;

                db.DrinkTypes.Add(new DrinkType() { 
                    DrinkTypeId = (++count).ToString(),
                    DrinkTypeName = txName.Text
                });

                db.SaveChanges();

                updateGridView();

                txName.Text = "";
                txID.Text = (count + 1).ToString();
            }
        }

        private void updateGridView()
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.DrinkTypes.Select(x=> new {x.DrinkTypeId,x.DrinkTypeName}).ToList();

            gridView.Columns[0].HeaderText = "ID";
            gridView.Columns[1].HeaderText = "Tên loại trà";

        }

        private void updateCheckList()
        {
            tea01Entities2 db = new tea01Entities2();
            var drinks = db.Drinks;

            foreach (var i in drinks)
            {
                checkList.Items.Add(i.DrinkName);
            }
        }

        private void ManageDrinkType_Load(object sender, EventArgs e)
        {
            updateGridView();
            updateCheckList();

            tea01Entities2 db = new tea01Entities2();
            int count = db.DrinkTypes.ToList().Count;

            txID.Text = (count+1).ToString();
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            MessageBox.Show(gridView.CurrentRow.Cells[1].Value.ToString());
        }
    }
}

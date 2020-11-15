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
        private string[] idDrinkType;
        private string[] idDrink;

        public ManageDrinkType()
        {
            InitializeComponent();


            updateId();
            /*
            
            for (int i=0; i<db.Drinks.ToList().Count; i++)
            {
                MessageBox.Show(idDrink[i]);
            }*/
        }

        private void updateId()
        {
            tea01Entities2 db = new tea01Entities2();

            idDrinkType = new string[db.Drinks.ToList().Count + 5];
            idDrink = new string[db.Drinks.ToList().Count + 5];

            var drinks = db.Drinks;
            int c = 0;

            foreach (var i in drinks)
            {
                idDrinkType[c] = i.DrinkTypeId;
                idDrink[c] = i.DrinkId;

                c++;
            }

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
            int c = 0;

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
            //MessageBox.Show(gridView.CurrentRow.Cells[1].Value.ToString());

            tea01Entities2 db = new tea01Entities2();
            updateId();

            for (int i=0; i<db.Drinks.ToList().Count; i++)
            {
                if (gridView.CurrentRow.Cells[0].Value.ToString() == idDrinkType[i])
                {
                    checkList.SetItemChecked(i, true);
                }
                else
                {
                    checkList.SetItemChecked(i, false);
                }
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            String idCurrent = gridView.CurrentRow.Cells[0].Value.ToString();

            tea01Entities2 db = new tea01Entities2();
            var drinks = db.Drinks;
            int c = 0;

            foreach(var i in drinks.ToList())
            {
                if (checkList.GetItemCheckState(c) == CheckState.Checked)
                {
                    i.DrinkTypeId = idCurrent;
                    db.SaveChanges();
                }

                c++;
            }

        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Đồng ý xóa "+gridView.CurrentRow.Cells[1].Value.ToString(), "Message", MessageBoxButtons.YesNo) == System.Windows.Forms.DialogResult.Yes)
            {
                String idCurrent = gridView.CurrentRow.Cells[0].Value.ToString();
                tea01Entities2 db = new tea01Entities2();

                db.DrinkTypes.Remove(db.DrinkTypes.Find(idCurrent));
                db.SaveChanges();

                updateGridView();
            }

        }
    }
}



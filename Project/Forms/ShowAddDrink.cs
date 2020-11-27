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
    public partial class ShowAddDrink : Form
    {
        private string url = "";
        private string[] idListBox;
        private int count = 0;

        public ShowAddDrink()
        {
            InitializeComponent();
            tea01Entities2 db = new tea01Entities2();
            idListBox = new string[db.DrinkTypes.ToList().Count+5];
            count = 0;

            txId.Text = (db.Drinks.ToList().Count + 1).ToString();
        }

        private void bunifuPictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void btnChoose_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.InitialDirectory = System.IO.Directory.GetCurrentDirectory();
            openFileDialog.Title = "Chọn ảnh để hiển thị";

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                url = openFileDialog.FileName;
                imgBox.Image = Image.FromFile(openFileDialog.FileName);
            }
            else
            {
                MessageBox.Show("Không chọn ảnh ? ", "Open Dialog", MessageBoxButtons.OK);
            }
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txId.Text != "" && txName.Text!="" && txPrice.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();

                db.Drinks.AddOrUpdate(new Drink() { 
                    DrinkId = txId.Text,
                    DrinkName = txName.Text,
                    Price = Convert.ToInt32(txPrice.Text),
                    Image = url,
                    DrinkTypeId = idListBox[listBox.SelectedIndex]
                });

                db.SaveChanges();


                txId.Text = (db.Drinks.ToList().Count + 1).ToString();
                txName.Text = "";
                txPrice.Text = "";

                updateGridView();
            }

        }

        private void updateGridView()
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.Drinks.Select(u => new {u.DrinkId,u.DrinkName }).ToList();


            gridView.Columns[0].HeaderText = "Id Trà";
            gridView.Columns[1].HeaderText = "Tên trà";

            gridView.Columns[0].Visible = false;
        }

        private void ShowAddDrink_Load(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var drinkType = db.DrinkTypes;

            foreach (var i in drinkType)
            {
                listBox.Items.Add(i.DrinkTypeName.ToString());
                idListBox[count++] = i.DrinkTypeId;
            }

            updateGridView();
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var drink = db.Drinks.Find(gridView.CurrentRow.Cells[0].Value.ToString());

            txId.Text = drink.DrinkId;
            txName.Text = drink.DrinkName;
            txPrice.Text = drink.Price.ToString();

            imgBox.Image = Image.FromFile(drink.Image);
            url = drink.Image;

            var drinkType = db.DrinkTypes.Find(drink.DrinkTypeId);

            int c = 0;

            foreach (var i in listBox.Items)
            {
                if (i.ToString() == drinkType.DrinkTypeName)
                {
                    listBox.SetSelected(c,true);
                    break;
                }

                c++;
            }
        }

        private void bunifuButton7_Click(object sender, EventArgs e)
        {
            PrevHome prevHome = new PrevHome();
            this.Hide();
            prevHome.ShowDialog();
            this.Close();
        }

        private void bunifuFlatButton1_Click(object sender, EventArgs e)
        {
            ManageDrinkType manageDrinkType = new ManageDrinkType();
            this.Hide();
            manageDrinkType.ShowDialog();
            this.Close();
        }
    }
}

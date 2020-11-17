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
    public partial class AddTable : Form
    {

        private List<Button> listButtonTable = new List<Button>();

        public AddTable()
        {
            InitializeComponent();
        }

        private void tabNavigationPage1_Paint(object sender, PaintEventArgs e)
        {
            updateGridView();
        }

        private void updateGridView()
        {
            tea01Entities2 db = new tea01Entities2();

            txId.Text = (db.TableSpaces.ToList().Count + 1).ToString();
            gridView.DataSource = db.TableSpaces.Select(u=> new {u.TableId,u.TableName}).ToList();
            gridView.Columns[1].HeaderText = "Tên bàn khả dụng";
            gridView.Columns[0].Visible = false;
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txId.Text!="" && txName.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();
                db.TableSpaces.AddOrUpdate(new TableSpace()
                {
                    TableId = txId.Text,
                    TableName = txName.Text,
                    Status = 1
                }) ;

                db.SaveChanges();

                updateGridView();
                loadTables();
                txName.Text = "";
            }
        }

        private void AddTable_Load(object sender, EventArgs e)
        {
            updateGridView();
            loadTables();
        }

        private void loadTables()
        {
            tea01Entities2 db = new tea01Entities2();
            var tables = db.TableSpaces.ToList();
            
            foreach (var i in tables)
            {
                Button btn = new Button();
                btn.Text = i.TableName;
                btn.Size = new Size(180, 80);
                Image image;

                btn.Click += (s, e) => {
                    inforTable.Text = btn.Text;
                };

                if (i.Status == 1)
                {
                    image = Image.FromFile("D:\\TeaManagement\\Project\\bin\\Debug\\Images\\tableActive.png");

                }
                else
                {
                    image = Image.FromFile("D:\\TeaManagement\\Project\\bin\\Debug\\Images\\tableNotActive.png");
                }

                btn.Image = image;

                btn.BackgroundImageLayout = ImageLayout.Stretch;
                /*btn.ImageAlign = ContentAlignment.MiddleRight;
                btn.TextAlign = ContentAlignment.MiddleLeft;
                */
                listButtonTable.Add(btn);
            }

            panel.Controls.Clear();

            foreach (Button i in listButtonTable)
            {
                panel.Controls.Add(i);
            }
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txId.Text = gridView.CurrentRow.Cells[0].Value.ToString();
            txName.Text = gridView.CurrentRow.Cells[1].Value.ToString();
        }
        
        private void tabNavigationPage2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void tabNavigationPage3_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}

using Project.Utils;
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

        private List<buttonCustom> listButtonTable = new List<buttonCustom>();
        public static String idTableChoose = "";
        private string currentIdTable = "";

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
            gridView.DataSource = db.TableSpaces.Select(u => new { u.TableId, u.TableName }).ToList();
            gridView.Columns[1].HeaderText = "Tên bàn khả dụng";
            gridView.Columns[0].Visible = false;
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            if (txId.Text != "" && txName.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();
                db.TableSpaces.AddOrUpdate(new TableSpace()
                {
                    TableId = txId.Text,
                    TableName = txName.Text,
                    Status = 1
                });

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
            listButtonTable = new List<buttonCustom>();

            foreach (var i in tables)
            {
                buttonCustom btn = new buttonCustom();
                btn.Text = i.TableName;
                btn.idItem = i.TableId;
                btn.Size = new Size(180, 80);
                Image image;

                btn.Click += (s, e) => {
                    inforTable.Text = btn.Text;

                    updateGridViewCustomerActive(i.TableId);
                    currentIdTable = i.TableId;

                    if (i.Status == 1)
                    {
                        btnSubmitTable.Text = "Xác nhận chọn: " + i.TableName;
                        idTableChoose = i.TableId;
                    }
                    else
                    {
                        MessageBox.Show("Bàn này đã đủ người");
                        btnSubmitTable.Text = "Xác nhận chọn: ";
                        idTableChoose = "";
                    }
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

            foreach (buttonCustom i in listButtonTable)
            {
                panel.Controls.Add(i);
            }
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txId.Text = gridView.CurrentRow.Cells[0].Value.ToString();
            txName.Text = gridView.CurrentRow.Cells[1].Value.ToString();
        }

        private void updateGridViewCustomerActive(String idTable)
        {
            tea01Entities2 db = new tea01Entities2();
            gridViewCustomerActice.DataSource = db.Bills.Select(u => new { u.TableId, u.Customer.FullName, u.Customer.PhoneNumber,u.OrderTimeEnd,u.BillId}).Where(u => u.TableId == idTable && u.OrderTimeEnd == null).ToList();
            
            if (gridViewCustomerActice.ColumnCount > 1)
            {
                gridViewCustomerActice.Columns[0].Visible = false;
                gridViewCustomerActice.Columns[2].Visible = false;
                gridViewCustomerActice.Columns[3].Visible = false;
                gridViewCustomerActice.Columns[4].Visible = false;
                gridViewCustomerActice.Columns[1].HeaderText = "Thông tin khách ngồi";

            }

            numberEmpty.Text = (4 - gridViewCustomerActice.RowCount).ToString();

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

        private void btnSubmitTable_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void gridViewCustomerActice_CellClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void bunifuFlatButton1_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            
            if (MessageBox.Show("Xác nhận khách hàng "+ gridViewCustomerActice.CurrentRow.Cells[1].Value + " đã về", "Message", MessageBoxButtons.YesNo) == System.Windows.Forms.DialogResult.Yes)
            {
                var bill = db.Bills.Find(gridViewCustomerActice.CurrentRow.Cells[4].Value);

                bill.OrderTimeEnd = DateTime.Now;
                db.SaveChanges();

                updateGridViewCustomerActive(currentIdTable);
                loadTables();
            }
        }
    }
}

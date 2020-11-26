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
    public partial class ManageStaff : Form
    {
        public ManageStaff()
        {
            InitializeComponent();
        }

        private void bunifuDataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void ManageStaff_Load(object sender, EventArgs e)
        {
            updateGridViewStaff();
        }

        private void updateGridViewStaff()
        {
            tea01Entities2 db = new tea01Entities2();
            gridViewStaff.DataSource = db.Staffs.Where(u=>u.DayOf == null).ToList();

            for (int i=0; i<gridViewStaff.ColumnCount; i++)
            {
                if (i==2 || i == 0) {
                    gridViewStaff.Columns[i].Visible = true;
                    continue;
                }
                gridViewStaff.Columns[i].Visible = false;
            }
            
            gridViewStaff.Columns[2].HeaderText="Họ và tên";
            gridViewStaff.Columns[0].HeaderText = "Tài khoản";

            if (gridViewStaff.RowCount > 0)
            {
               // gridViewBill.DataSource = db.Bills.Where(u => u.Customer == gridViewStaff.Rows[0].Cells[4].Value).ToList();
            }
        }

        private void gridViewStaff_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            String userName = gridViewStaff.CurrentRow.Cells[0].Value.ToString();
            gridViewBill.DataSource = db.Bills.Where(u => u.UserName == userName).ToList();

            for (int i=0; i<gridViewBill.ColumnCount; i++)
            {
                if (i==0 || i == 4)
                {
                    gridViewBill.Columns[i].Visible = true;
                    continue;
                }
                gridViewBill.Columns[i].Visible = false;
            }

            gridViewBill.Columns[0].HeaderText = "Mã hóa đơn";
            gridViewBill.Columns[4].HeaderText = "Tổng tiền";
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            RegisterStaff registerStaff = new RegisterStaff();
            this.Hide();
            registerStaff.ShowDialog();
            this.Close();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            RegisterStaff registerStaff = new RegisterStaff();
            this.Hide();
            registerStaff.ShowDialog();
            this.Close();
        }

        private void btnPermision_Click(object sender, EventArgs e)
        {
            PermisionForm permisionForm = new PermisionForm();
            this.Hide();
            permisionForm.ShowDialog();
            this.Close();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            Staff staff = db.Staffs.Find(gridViewStaff.CurrentRow.Cells[0].Value);

            if (MessageBox.Show("Xóa nhân viên "+ staff.FullName+" ?", "Message", MessageBoxButtons.YesNo) == System.Windows.Forms.DialogResult.Yes)
            {
                staff.DayOf = DateTime.Now;
                db.SaveChanges();
                MessageBox.Show("Đã xóa");
                updateGridViewStaff();
            }
        }

        private void bunifuButton4_Click(object sender, EventArgs e)
        {

            PrevHome prevHome = new PrevHome();
            this.Hide();
            prevHome.ShowDialog();
            this.Close();

        }
    }
}

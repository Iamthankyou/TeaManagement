using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity.Migrations;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project.Forms
{
    public partial class ManageVoucher : Form
    {
        public ManageVoucher()
        {
            InitializeComponent();
        }

        private void ManageVoucher_Load(object sender, EventArgs e)
        {
            updateGridView();
        }

        private void updateGridView()
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.Vouchers.ToList();
            gridView.Columns[0].HeaderText = "Code";
            gridView.Columns[1].HeaderText = "Bắt đầu";
            gridView.Columns[2].HeaderText = "Kết thúc";
            gridView.Columns[3].HeaderText = "% giảm giá";

        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            txCode.Text = gridView.CurrentRow.Cells[0].Value.ToString();
            txRatio.Text = gridView.CurrentRow.Cells[3].Value.ToString();
            start.Value = (DateTime)db.Vouchers.Find(txCode.Text).dateStart;
            end.Value = (DateTime)db.Vouchers.Find(txCode.Text).dateEnd;
        }

        private void bunifuFlatButton2_Click(object sender, EventArgs e)
        {

            if (MessageBox.Show("Yes or no", "Bạn có chắc chắn muốn xóa voucher này ?", MessageBoxButtons.YesNo) == System.Windows.Forms.DialogResult.Yes)
            {
                tea01Entities2 db = new tea01Entities2();
                txCode.Text = gridView.CurrentRow.Cells[0].Value.ToString();

                var tmp = db.Vouchers.Find(txCode.Text);
                db.Vouchers.Remove(tmp);
                db.SaveChanges();

                updateGridView();
            }
        }

        private void bunifuFlatButton1_Click(object sender, EventArgs e)
        {
            if (txCode.Text!="" && txRatio.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();
                
                db.Vouchers.AddOrUpdate(new Voucher() { 
                    Code = txCode.Text,
                    dateStart = (DateTime)start.Value,
                    dateEnd = end.Value,
                    ratio = Convert.ToInt32(txRatio.Text)
                });

                db.SaveChanges();

                MessageBox.Show("Đã cập nhật");

                updateGridView();
            }
        }

        private void bunifuButton9_Click(object sender, EventArgs e)
        {

            PrevHome prevHome = new PrevHome();
            this.Hide();
            prevHome.ShowDialog();
            this.Close();

        }
    }
}

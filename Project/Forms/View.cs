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
    public partial class View : Form
    {
        public View()
        {
            InitializeComponent();
        }

        private void View_Load(object sender, EventArgs e)
        {

        }

        private void bunifuButton1_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.View01_HoaDonBanTrongNgay.ToList();
        }

        private void bunifuButton2_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.View04_ThongKeTongTienHangThang.ToList();
        }

        private void bunifuButton3_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            gridView.DataSource = db.proc01_ThongKe().ToList();
        }
    }
}

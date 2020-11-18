using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DevExpress.XtraEditors;

namespace Project.Forms
{
    public partial class BillDetail : DevExpress.XtraEditors.XtraForm
    {
        public BillDetail()
        {
            InitializeComponent();
        }

        private void BillDetail_Load(object sender, EventArgs e)
        {
           
            printButton.IdleFillColor = Color.FromArgb(138,180,248);
            sellDate.Text = sellDate.Text + DateTime.Now.ToString() ;
            listItem.MaximumSize = new Size(this.listItem.Width, 0);
            listItem.AutoSize = true;

            for (int i = 0; i < 50; i++)
            {
                listItem.Rows.Add(new object[]
                {
                "Trà sữa bạc hà ",
                500000,
                1,
                500000

                 });
            }
     





        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void bunifuVScrollBar1_Scroll(object sender, Bunifu.UI.WinForms.BunifuVScrollBar.ScrollEventArgs e)
        {

        }

        private void panel3_Paint(object sender, PaintEventArgs e)
        {

        }
        Bitmap bmp;
        private void printButton_Click(object sender, EventArgs e)
        {


     
        }

       

        private void printDocument1_PrintPage(object sender, System.Drawing.Printing.PrintPageEventArgs e)
        {

        }

        private void cancelPrint_Click(object sender, EventArgs e)
        {

        }
    }
}
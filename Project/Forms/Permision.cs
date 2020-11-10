using DevExpress.Data.Helpers;
using DevExpress.Utils.DirectXPaint.Svg;
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
    public partial class PermisionForm : Form
    {
        public PermisionForm()
        {
            InitializeComponent();
        }

        private List<Permision> listPermistion;
        private int count;

        private void Permision_Load(object sender, EventArgs e)
        {
            updateGridView();
            tea01Entities2 db = new tea01Entities2();
            var listPer = db.Permisions.ToList();
            listPermistion = listPer;
            count = listPer.Count;

            foreach (var i in listPer)
            {
                checkedListBox1.Items.Add(i.PermisionName);
            }

        }

        private void updateGridView()
        {
            tea01Entities2 db = new tea01Entities2();

            var res = db.Staffs.Select(x=>new {x.FullName,x.UserName}).ToList();

            gridView.DataSource = res;

            gridView.Columns[0].HeaderText = "Họ và tên";
            gridView.Columns[1].HeaderText = "Tên người dùng";

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void btnFull_Click(object sender, EventArgs e)
        {
            /*if (checkFull.Checked)
            {
                checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }*/
            
        }

        private void btnAdmin_Click(object sender, EventArgs e)
        {

            /*if (checkAdmin.Checked)
            {
                checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }*/
        }

        private void btnRead_Click(object sender, EventArgs e)
        {
            /*if (checkRead.Checked)
            {
                checkRead.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                checkRead.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }*/
        }

        private void btnCreate_Click(object sender, EventArgs e)
        {
            /*if (checkCreate.Checked)
            {
                checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }*/
        }

        private void resetCheck()
        {
            /*
            checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkRead.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            */
        }

        private void btnView_Click(object sender, EventArgs e)
        {
            /*if (checkView.Checked)
            {
                checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }*/
        }

        private void resetCheckList()
        {
            for (int i = 0; i < checkedListBox1.Items.Count; i++)
            {
                checkedListBox1.SetItemCheckState(i, CheckState.Unchecked);
            }
        }

        private void updateGridCheck()
        {
            resetCheckList();

            tea01Entities2 db = new tea01Entities2();
            Staff userCurrent = db.Staffs.Find(gridView.CurrentRow.Cells[1].Value.ToString());

            var per = userCurrent.Permisions.ToArray();

            foreach (var o in per)
            {
                int count = 0;
                bool flag = false;

                foreach (var i in checkedListBox1.Items)
                {
                    var tmp = i;

                    if (o.PermisionName.CompareTo(tmp.ToString()) == 0)
                    {
                        flag = true;
                        break;
                    }

                    count++;
                }

                if (flag = true)
                {
                    checkedListBox1.SetItemCheckState(count, CheckState.Checked);
                }
            }
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            lbMess.Text = "Danh sách quyền của: " + gridView.CurrentRow.Cells[0].Value.ToString();

            updateGridCheck();
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            //tea01Entities2 db = new tea01Entities2();
            

            for (int i = 0; i < checkedListBox1.Items.Count; i++)
            {
                if (checkedListBox1.GetItemCheckState(i) == CheckState.Checked)
                {
                    MessageBox.Show(checkedListBox1.Items[i].ToString());

                    //        var permision = db.Permisions.Where(u=>u.PermisionName == checkedListBox1.Items[i].ToString()).Select(u=>u).First();
                    using (var context = new tea01Entities2())
                    {
                        Staff userCurrent = context.Staffs.Find(gridView.CurrentRow.Cells[1].Value.ToString());
                        userCurrent.Permisions.Add(new Permision()
                        {
                            PermisionID = (++count).ToString(),
                            PermisionName = checkedListBox1.Items[i].ToString()
                        });

                        context.SaveChanges();

                    }
                }
            }

            
        }
    }
}

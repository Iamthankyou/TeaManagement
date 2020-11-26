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
            reloadUncheck();
            reloadUncheck2();
            tea01Entities2 db = new tea01Entities2();
            var listPer = db.Permisions.ToList();
            listPermistion = listPer;
            count = listPer.Count;
            
            
            



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
            /*for (int i = 0; i < checkedListBox1.Items.Count; i++)
            {
                checkedListBox1.SetItemCheckState(i, CheckState.Unchecked);
            }*/
        }

        private void updateGridCheck()
        {
            resetCheckList();
            reloadUncheck2();
            reloadUncheck();

            tea01Entities2 db = new tea01Entities2();
            Staff userCurrent = db.Staffs.Find(gridView.CurrentRow.Cells[1].Value.ToString());

            var listPer = userCurrent.Permisions.ToList();
            
            if (listPer.Count == 0)
            {
                reloadUncheck();
            }

            foreach (var i in listPer)
            {
                foreach (var j in i.PermisionDetails)
                {
                    if (j.ActionName == "C")
                    {
                        checkThem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                    }
                    
                    if (j.ActionName == "E")
                    {
                        checkSua.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                    }
                    
                    if (j.ActionName == "D")
                    {
                        checkXoa.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                    }

                    if (j.ActionName == "V")
                    {
                        checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                    }
                }
            }

            foreach (var i in listPer)
            {   
                if (i.PermisionName == "Full")
                {
                    reloadUncheck();
                    checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
                else if (i.PermisionName == "Admin")
                {
                    reloadUncheck();
                    checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
                else if (i.PermisionName == "Create")
                {
                    reloadUncheck();
                    checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
                else if (i.PermisionName == "Edit")
                {
                    reloadUncheck();
                    checkEdit.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
                else if (i.PermisionName == "View")
                {
                    reloadUncheck();
                    checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
                else
                {
                    reloadUncheck();
                    checkCustom.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
            }
        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            string name = gridView.CurrentRow.Cells[0].Value.ToString();
            string[] arr = name.Split(' ');
            lbMess.Text = "Quyền của: " + arr[arr.Length-1];

            updateGridCheck();
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            //tea01Entities2 db = new tea01Entities2();

            /*
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
            */

            tea01Entities2 db = new tea01Entities2();
            Staff userCurrent = db.Staffs.Find(gridView.CurrentRow.Cells[1].Value.ToString());


            for(int i = 0; i< userCurrent.Permisions.Count; i++) {
                var rm = db.Permisions.Find(userCurrent.Permisions.ToList()[i].PermisionID);
                userCurrent.Permisions.Remove(userCurrent.Permisions.ToList()[i]);
                
             //   db.Permisions.Remove(rm);
            }

            


            string permisionName = "";

            if (checkFull.Checked)
            {
                permisionName = "Full";
            }
            else if (checkCreate.Checked)
            {
                permisionName = "Create";
            }
            else if (checkEdit.Checked)
            {
                permisionName = "Edit";
            }
            else if (checkView.Checked)
            {
                permisionName = "View";
            }
            else if (checkAdmin.Checked)
            {
                permisionName = "Admin";
            }
            else
            {
                permisionName = "Custom";
            }

            Permision permision = new Permision()
            {
                PermisionID = (++count).ToString(),
                PermisionName = permisionName
            };

            userCurrent.Permisions.Add(permision);
            db.SaveChanges();

            if (checkXem.Checked)
            {
                int count = db.PermisionDetails.ToList().Count;

                permision.PermisionDetails.Add(new PermisionDetail()
                {
                    PermisionDetailId = (++count).ToString(),
                    ActionName = "V"
                });
            }
            db.SaveChanges();

            if (checkXoa.Checked)
            {
                int count = db.PermisionDetails.ToList().Count;

                permision.PermisionDetails.Add(new PermisionDetail()
                {
                    PermisionDetailId = (++count).ToString(),
                    ActionName = "D"
                });
            }
            db.SaveChanges();

            if (checkSua.Checked)
            {
                int count = db.PermisionDetails.ToList().Count;

                permision.PermisionDetails.Add(new PermisionDetail()
                {
                    PermisionDetailId = (++count).ToString(),
                    ActionName = "E"
                });
            }
            db.SaveChanges();

            if (checkThem.Checked)
            {
                int count = db.PermisionDetails.ToList().Count;

                permision.PermisionDetails.Add(new PermisionDetail()
                {
                    PermisionDetailId = (++count).ToString(),
                    ActionName = "C"
                });
            }
            db.SaveChanges();

            /*
            var listPer = userCurrent.Permisions.ToList();

            foreach (var i in listPer)
            {
                i.PermisionDetails.remove();
            }
            */
            db.SaveChanges();

            MessageBox.Show("Đã cập nhật quyền cho nhân viên này");

        }

        private void reloadUncheck()
        {
            checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkEdit.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkCustom.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
        }

        private void bunifuButton1_Click(object sender, EventArgs e)
        {
            if (checkCreate.Checked)
            {
                
                checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                reloadUncheck();
                checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                reloadUncheck2();

                checkThem.Enabled = true;
                checkXoa.Enabled = true;
                checkSua.Enabled = true;
                checkXem.Enabled = true;

                checkThem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;

                checkThem.Enabled = false;
                checkXoa.Enabled = false;
                checkSua.Enabled = false;
                checkXem.Enabled = false;

            }
        }

        private void bunifuCheckBox1_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            if (checkCreate.Checked)
            {
                reloadUncheck();
                checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }
            else
            {
                checkCreate.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
        }

        private void Full_Click(object sender, EventArgs e)
        {
            if (checkFull.Checked)
            {
                checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {

                reloadUncheck();
                checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                reloadUncheck2();


                checkThem.Enabled = true;
                checkXoa.Enabled = true;
                checkSua.Enabled = true;
                checkXem.Enabled = true;

                checkThem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                checkXoa.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                checkSua.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;

                checkThem.Enabled = false;
                checkXoa.Enabled = false;
                checkSua.Enabled = false;
                checkXem.Enabled = false;

            }
        }

        private void btnAdmin_Click_1(object sender, EventArgs e)
        {
            if (checkAdmin.Checked)
            {
                checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {

                reloadUncheck();
                checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                reloadUncheck2();

                checkThem.Enabled = true;
                checkXoa.Enabled = true;
                checkSua.Enabled = true;
                checkXem.Enabled = true;

                checkThem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                checkSua.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;

                checkThem.Enabled = false;
                checkXoa.Enabled = false;
                checkSua.Enabled = false;
                checkXem.Enabled = false;
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (checkEdit.Checked)
            {
                checkEdit.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                reloadUncheck();
                checkEdit.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                reloadUncheck2();

                checkThem.Enabled = true;
                checkXoa.Enabled = true;
                checkSua.Enabled = true;
                checkXem.Enabled = true;


                checkSua.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;

                checkThem.Enabled = false;
                checkXoa.Enabled = false;
                checkSua.Enabled = false;
                checkXem.Enabled = false;

            }
        }

        private void btnView_Click_1(object sender, EventArgs e)
        {
            if (checkView.Checked)
            {
                checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                reloadUncheck();
                checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                reloadUncheck2();

                checkThem.Enabled = true;
                checkXoa.Enabled = true;
                checkSua.Enabled = true;
                checkXem.Enabled = true;


                checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;

                checkThem.Enabled = false;
                checkXoa.Enabled = false;
                checkSua.Enabled = false;
                checkXem.Enabled = false;

            }
        }

        private void groupControl1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void btnCustom_Click(object sender, EventArgs e)
        {
            if (checkCustom.Checked)
            {
                checkCustom.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
            else
            {
                reloadUncheck();
                reloadUncheck2();

                checkThem.Enabled = true;
                checkXoa.Enabled = true;
                checkSua.Enabled = true;
                checkXem.Enabled = true;


                checkCustom.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }
        }

        private void checkFull_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            if (checkFull.Checked)
            {
                reloadUncheck();
                checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }
            else
            {
                checkFull.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
        }

        private void checkAdmin_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            if (checkAdmin.Checked)
            {
                reloadUncheck();
                checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }   
            else
            {
                checkAdmin.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
        }

        private void checkEdit_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            if (checkEdit.Checked)
            {
                reloadUncheck();
                checkEdit.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }
            else
            {
                checkEdit.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }
        }

        private void checkView_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            if (checkView.Checked)
            {
                reloadUncheck();
                checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                
            }
            else
            {
                checkView.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }

        }

        private void checkCustom_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            if (checkCustom.Checked)
            {
                reloadUncheck();
                checkCustom.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
            }
            else
            {
                checkCustom.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            }

        }

        private void bunifuLabel2_Click(object sender, EventArgs e)
        {

        }

        private void reloadUncheck2()
        {
            checkThem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkXoa.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkSua.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
            checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            if (checkCustom.Checked)
            {
                if (checkThem.Checked)
                {
                    checkThem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
                }
                else
                {
                    checkThem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
            }
            
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            if (checkCustom.Checked)
            {
                if (checkXoa.Checked)
                {
                    checkXoa.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
                }
                else
                {
                    checkXoa.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
            }
            
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            if (checkCustom.Checked)
            {
                if (checkSua.Checked)
                {
                    checkSua.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
                }
                else
                {
                    checkSua.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
            }
            
        }

        private void btnXem_Click(object sender, EventArgs e)
        {
            if (checkCustom.Checked)
            {
                if (checkXem.Checked)
                {
                    checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Unchecked;
                }
                else
                {
                    checkXem.CheckState = Bunifu.UI.WinForms.BunifuCheckBox.CheckStates.Checked;
                }
            }
        }

        private void checkThem_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            
        }

        private void checkXoa_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            
        }

        private void checkSua_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            
        }

        private void checkXem_CheckedChanged(object sender, Bunifu.UI.WinForms.BunifuCheckBox.CheckedChangedEventArgs e)
        {
            
        }

        private void bunifuButton2_Click(object sender, EventArgs e)
        {
            PrevHome home = new PrevHome();
            this.Hide();
            home.ShowDialog();
            this.Close();
        }
    }
}

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
using System.Text.RegularExpressions;

namespace Project.Forms
{
    public partial class SignIn : DevExpress.XtraEditors.XtraForm
    {
        public static String username;

        public SignIn()
        {
            InitializeComponent();
        }

        private void txUserName_TextChanged(object sender, EventArgs e)
        {

        }

        private void txUserName_KeyPress(object sender, KeyPressEventArgs e)
        {
            
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            String hash = Encryption.Crypt(txPass.Text);

            if (hash.Length > 100)
            {
                hash = hash.Substring(0, 99);
            }

            tea01Entities2 db = new tea01Entities2();
            var user = db.Staffs.Find(txUserName.Text);

            if (user == null || !user.Password.Equals(hash))
            {
                MessageBox.Show("Tên tài khoản hoặc mật khẩu không đúng");
            }
            else
            {
                username = txUserName.Text;
                MessageBox.Show("Đăng nhập thành công");
            }

            if (tickRemember.Checked)
            {
                MessageBox.Show("?");

                if (tickRemember.Checked)
                {
                    Properties.Settings.Default.UserName = this.txUserName.Text;
                    Properties.Settings.Default.PassWord = this.txPass.Text;
                    Properties.Settings.Default.RememberMe = "true";
                    Properties.Settings.Default.Save();
                }
                else
                {
                    Properties.Settings.Default.UserName = this.txUserName.Text;
                    Properties.Settings.Default.PassWord = "";
                    Properties.Settings.Default.RememberMe = "false";
                    Properties.Settings.Default.Save();
                }
            }
        }

        private void SignIn_Load(object sender, EventArgs e)
        {
            //MessageBox.Show((string)Properties.Settings.Default.userName);
            if (Properties.Settings.Default.RememberMe == "true")
            {
                txUserName.Text = Properties.Settings.Default.UserName;
                txPass.Text = Properties.Settings.Default.PassWord;
                tickRemember.Checked = true;
            }
            else
            {
                txUserName.Text = "";
                txPass.Text = "";
                tickRemember.Checked = false;
            }
        }

        private void btnRegister_Click_1(object sender, EventArgs e)
        {
            String hash = Encryption.Crypt(txPass.Text);

            if (hash.Length > 100)
            {
                hash = hash.Substring(0, 99);
            }

            tea01Entities2 db = new tea01Entities2();
            var user = db.Staffs.Find(txUserName.Text);


            if (tickRemember.Checked)
            {
                Properties.Settings.Default.UserName = this.txUserName.Text;
                Properties.Settings.Default.PassWord = this.txPass.Text;
                Properties.Settings.Default.RememberMe = "true";
                Properties.Settings.Default.Save();
            }
            else
            {
                Properties.Settings.Default.UserName = this.txUserName.Text;
                Properties.Settings.Default.PassWord = "";
                Properties.Settings.Default.RememberMe = "false";
                Properties.Settings.Default.Save();
            }

            if (user == null || !user.Password.Equals(hash))
            {
                MessageBox.Show("Tên tài khoản hoặc mật khẩu không đúng");
            }
            else
            {
                username = txUserName.Text;
                PrevHome prevHome = new PrevHome();
                this.Hide();
                prevHome.ShowDialog();
                this.Close();
            }
        }

        private void txUserName_KeyPress_1(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 32 || (txUserName.Text != "" && !Regex.IsMatch(txUserName.Text, "^[a-zA-Z][a-zA-Z0-9\\._\\-]{0,22}?[a-zA-Z0-9]{0,2}$")))
            {
                e.Handled = true;
                txUserName.Text = "";
            }

            if (e.Handled)
            {
                MessageBox.Show("Tên người dùng viết liền không dấu, không được bắt đầu bằng số");
            }
        }

        private void hyperlinkLabelControl1_Click(object sender, EventArgs e)
        {
            RegisterStaff registerStaff = new RegisterStaff();
            this.Hide();
            registerStaff.ShowDialog();
            this.Close();
        }
    }
}
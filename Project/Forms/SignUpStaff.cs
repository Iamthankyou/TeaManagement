using Project.Forms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project
{
    public partial class RegisterStaff : Form
    {
        private string url = "";

        public RegisterStaff()
        {
            InitializeComponent();
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            
            if (txUserName.Text != "" && txPhone.Text!="" && txFullName.Text!="" && txBirthday.Text!="" && txAddress.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();

                if (txPass.TextLength < 8)
                {
                    MessageBox.Show("Mật khẩu bắt buộc phải trên 8 ký tự");
                }
                else if (txPhone.TextLength != 10)
                {
                    MessageBox.Show("Số điện thoại phải 10 chữ số");
                }
                else if (db.Staffs.Find(txUserName.Text) != null)
                {
                    MessageBox.Show("Tài khoản đã tồn tại");
                }
                else {
                    MessageBox.Show(Encryption.Crypt(txPass.Text));

                    String tmp = Encryption.Crypt(txPass.Text);

                    if (tmp.Length > 100)
                    {
                        tmp = tmp.Substring(0, 99);
                    }

                    db.Staffs.Add(new Staff()
                    {
                        UserName = txUserName.Text,
                        Password = tmp,
                        FullName = txFullName.Text,
                        Age = txBirthday.DateTime,
                        PhoneNumber = txPhone.Text,
                        Address = txAddress.Text,
                        Avatar = url
                    });
                    db.SaveChanges();
                    
                    MessageBox.Show("Đã lưu");
                }
            }
            else
            {
                MessageBox.Show("Không được để trống trường nào cả");
            }
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            txBirthday.DateTime = DateTime.Now;
        }

        private void btnChooseImg_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFile = new OpenFileDialog();
            openFile.InitialDirectory = System.IO.Directory.GetCurrentDirectory() + "\\Images";
            openFile.Title = "Chọn ảnh đại diện";

            if (openFile.ShowDialog() == DialogResult.OK)
            {
                url = openFile.FileName;
                //File.Copy(System.IO.Directory.GetCurrentDirectory() + "\\Images",openFile.FileName, true);
                imgAvatar.Image = Image.FromFile(url);
                imgAvatar.SizeMode = PictureBoxSizeMode.StretchImage;
            }
            else
            {
                MessageBox.Show("Để ảnh mặc định ? ", "Thông báo", MessageBoxButtons.OK);
            }
        }

        private void txUserName_KeyPress(object sender, KeyPressEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();

            if (e.KeyChar == 32 || (txUserName.Text!="" && !Regex.IsMatch(txUserName.Text, "^[a-zA-Z][a-zA-Z0-9\\._\\-]{0,22}?[a-zA-Z0-9]{0,2}$")))
            {
                e.Handled = true;
                txUserName.Text = "";
            }
            
            if (e.Handled)
            {
                MessageBox.Show("Tên người dùng viết liền không dấu, không được bắt đầu bằng số");
            }

            if (db.Staffs.Find(txUserName.Text) != null)
            {
                MessageBox.Show("Tài khoản đã tồn tại");
                e.Handled = true;
                txUserName.Text = "";
            }
        }

        private void txPhone_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = !char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar);

            if (e.Handled)
            {
                MessageBox.Show("Chỉ được nhập số");
            }
        }
    }
}

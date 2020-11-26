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
    public partial class Home : Form
    {
        private List<buttonCustom> listButtonTea = new List<buttonCustom>();
        private List<Label> listLabelTea = new List<Label>();
        private List<buttonCustom> listButtonTopping = new List<buttonCustom>();
        private List<Label> listLabelTopping = new List<Label>();
        private buttonCustom currentTea;
        private Label currentLabel;

        private buttonCustom currentTopping;
        private Label currentLabelTopping;


        public static List<List<String>> listView = new List<List<String>>();
        public static String phoneCustomer;

        public Home()
        {
            InitializeComponent();
        }

        private void bunifuButton2_Click(object sender, EventArgs e)
        {

        }

        private void gradientLabel1_Click(object sender, EventArgs e)
        {

        }

        private void Home_Load(object sender, EventArgs e)
        {
            updatePanelTea();
            updatePanelTopping();
            updateComboBox();
            listBox.ItemHeight = 20;
        }

        private void updateComboBox()
        {
            tea01Entities2 db = new tea01Entities2();
            
            foreach(var i in db.DrinkTypes)
            {
                comboBox.Items.Add(i.DrinkTypeName + "-" + i.DrinkTypeId);
            }

            comboBox.Items.Add("Tất cả");
        }


        private void updatePanelTopping()
        {
            tea01Entities2 db = new tea01Entities2();
            var toppings = db.Toppings.ToList();

            Random rand = new Random();
            Color[] c = { Color.Red, Color.Blue, Color.Green, Color.Cyan, Color.Magenta };

            listButtonTopping = new List<buttonCustom>();

            foreach (var i in toppings)
            {
                //Bunifu.UI.WinForms.BunifuButton.BunifuButton btn = new Bunifu.UI.WinForms.BunifuButton.BunifuButton();
                buttonCustom btn = new buttonCustom();
                btn.Text = i.ToppingName + " " + i.Price + "đ";
                btn.idItem = i.ToppingId; 
                btn.Size = new Size(120, 80);
                Image image;
                Label lb = new Label();
                lb.Size = new Size(20, 20);
                lb.Text = "0";

                btn.Click += (s, e) => {
                    currentTopping = btn;
                    currentLabelTopping = lb;
                    toppingClick();
                };

                btn.BackColor = c[rand.Next(0, c.Length)];
                btn.ForeColor = Color.White;
                btn.Font = new Font(btn.Font.FontFamily, 10);
                btn.Font = new Font(btn.Font, FontStyle.Bold);
                btn.ForeColorChanged += (s, e) => {
                    btn.Font = new Font(btn.Font, FontStyle.Bold);
                };


                btn.BackgroundImageLayout = ImageLayout.Stretch;
                /*btn.ImageAlign = ContentAlignment.MiddleRight;
                btn.TextAlign = ContentAlignment.MiddleLeft;
                */
                listButtonTopping.Add(btn);
                listLabelTopping.Add(lb);
            }

            panelTopping.Controls.Clear();

            for (int i = 0; i < listButtonTopping.Count; i++)
            {
                panelTopping.Controls.Add(listButtonTopping[i]);
                panelTopping.Controls.Add(listLabelTopping[i]);
            }

        }

        private void updateListView()
        {
            //gridView.DataSource = listView;
        }

        private void updateGridBox()
        {
            tea01Entities2 db = new tea01Entities2();
            listBox.Items.Clear();

            int price = 0;

            foreach (var i in listView)
            {
                String res = db.Drinks.Find(i[0]).DrinkName;

                price += Convert.ToInt32(db.Drinks.Find(i[0]).Price);

                for (int iter=1; iter<i.Count; iter++)
                {
                    String topping = db.Toppings.Find(i[iter]).ToppingName;
                    res += "+ " + topping;

                    price += Convert.ToInt32(db.Toppings.Find(i[iter]).Price);
                }

                listBox.Items.Add(res);
            }

            lbPrice.Text = price.ToString() + " VNĐ";

        }

        private void teaClick()
        {
            // MessageBox.Show(currentTea.Text);
            currentLabel.Text = (Convert.ToInt32(currentLabel.Text) + 1).ToString();
            listView.Add(new List<String>());
            listView[listView.Count - 1].Add(currentTea.idItem);
            //updateListView();

            updateGridBox();
        }

        private void toppingClick()
        {
            currentLabelTopping.Text = (Convert.ToInt32(currentLabelTopping.Text) + 1).ToString();
            listView[listView.Count - 1].Add(currentTopping.idItem);

            updateGridBox();
        }

        private void updatePanelTea()
        {
            tea01Entities2 db = new tea01Entities2();
            var drinks = db.Drinks.ToList();

            listButtonTea = new List<buttonCustom>();

            foreach (var i in drinks)
            {
                //Bunifu.UI.WinForms.BunifuButton.BunifuButton btn = new Bunifu.UI.WinForms.BunifuButton.BunifuButton();
                buttonCustom btn = new buttonCustom();
                btn.Text = i.DrinkName + " " + i.Price.ToString() + "đ";
                btn.idItem = i.DrinkId;
                btn.Size = new Size(120, 80);
                Image image;
                Label lb = new Label();
                lb.Size = new Size(20, 20);
                lb.Text = "0";

                btn.Click += (s, e) => {
                    //MessageBox.Show(btn.idItem);
                    currentTea = btn;
                    currentLabel = lb;
                    teaClick();
                };

                image = Image.FromFile(i.Image);
                btn.BackgroundImage = image;
                btn.ForeColor = Color.White;
                btn.Font = new Font(btn.Font.FontFamily, 10);
                btn.Font = new Font(btn.Font,FontStyle.Bold);
                btn.ForeColorChanged += (s, e) => {
                    btn.Font = new Font(btn.Font, FontStyle.Bold);
                };


                btn.BackgroundImageLayout = ImageLayout.Stretch;
                /*btn.ImageAlign = ContentAlignment.MiddleRight;
                btn.TextAlign = ContentAlignment.MiddleLeft;
                */
                listButtonTea.Add(btn);
                listLabelTea.Add(lb);
            }

            panelTea.Controls.Clear();
            
            for (int i=0; i<listButtonTea.Count; i++)
            {
                panelTea.Controls.Add(listButtonTea[i]);
                panelTea.Controls.Add(listLabelTea[i]);
            }

        }

        private void panelTopping_Paint(object sender, PaintEventArgs e)
        {

        }

        private void comboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox.SelectedItem.ToString() == "Tất cả")
            {
                updatePanelTea();
            }
            else
            {
                String[] i = comboBox.SelectedItem.ToString().Split('-');
                tea01Entities2 db = new tea01Entities2();
                DrinkType type = db.DrinkTypes.Find(i[1]);

                listButtonTea.Clear();
                listButtonTea = new List<buttonCustom>();

                listLabelTea.Clear();
                listLabelTea = new List<Label>();


                foreach (var iter in type.Drinks)
                {

                    buttonCustom btn = new buttonCustom();
                    btn.Text = iter.DrinkName + " " + iter.Price.ToString() + "đ";
                    btn.idItem = iter.DrinkId;
                    btn.Size = new Size(120, 80);
                    Image image;
                    Label lb = new Label();
                    lb.Size = new Size(20, 20);
                    lb.Text = "0";

                    btn.Click += (s, ee) => {
                        //MessageBox.Show(btn.idItem);
                        currentTea = btn;
                        currentLabel = lb;
                        teaClick();
                    };

                    image = Image.FromFile(iter.Image);
                    btn.BackgroundImage = image;
                    btn.ForeColor = Color.White;
                    btn.Font = new Font(btn.Font.FontFamily, 10);
                    btn.Font = new Font(btn.Font, FontStyle.Bold);

                    btn.ForeColorChanged += (s, ee) => {
                        btn.Font = new Font(btn.Font, FontStyle.Bold);
                    };


                    btn.BackgroundImageLayout = ImageLayout.Stretch;
                    /*btn.ImageAlign = ContentAlignment.MiddleRight;
                    btn.TextAlign = ContentAlignment.MiddleLeft;
                    */
                    listButtonTea.Add(btn);
                    listLabelTea.Add(lb);
                }

                panelTea.Controls.Clear();
                    
                for (int ii = 0; ii < listButtonTea.Count; ii++)
                {
                    panelTea.Controls.Add(listButtonTea[ii]);
                    panelTea.Controls.Add(listLabelTea[ii]);
                }

            }

        }

        private void bunifuMaterialTextbox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                e.Handled = !Char.IsDigit(e.KeyChar) && e.KeyChar != 8 && e.KeyChar != 13;

                if (phone.Text.Length > 10)
                {
                    e.Handled = true;
                }

                if (e.Handled)
                {
                    MessageBox.Show("Chỉ nhập số điện thoại có 10 chữ số");
                    phone.Text = "";
                }

                if (phone.Text.Length == 10)
                {
                    tea01Entities2 db = new tea01Entities2();
                    var customer = db.Customers.Find(phone.Text);

                    if (customer != null)
                    {
                        name.Text = customer.FullName;
                        address.Text = customer.Address;

                        bestDrink();
                        recentBill();
                        lbLevelPoint.Text = "Level " + customer.Level.ToString();
                    }
                }
                else
                {

                    MessageBox.Show("Chỉ nhập số điện thoại có 10 chữ số");
                    name.Text = "";
                    address.Text = "";
                }
            }
        }

        private void bunifuButton7_Click(object sender, EventArgs e)
        {
            if (phone.Text.Length==10 && name.Text!="" && address.Text != "")
            {
                tea01Entities2 db = new tea01Entities2();

                db.Customers.AddOrUpdate(new Customer() { 
                    PhoneNumber = phone.Text,
                    FullName = name.Text,
                    Address = address.Text,
                    Level = 0
                });

                db.SaveChanges();

                MessageBox.Show("Đã cập nhật vào cơ sở dữ liệu");
            }
        }

        private void bunifuButton14_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var customer = db.Customers.Find(phone.Text);

            if (phone.Text != "" && customer!=null)
            {
                phoneCustomer = phone.Text;
                BillEnter bill = new BillEnter();
                bill.ShowDialog();
            }
            else
            {
                MessageBox.Show("Vui lòng nhập thông tin khách hàng");
            }
        }

        private void bunifuButton12_Click(object sender, EventArgs e)
        {
            //     MessageBox.Show(SignIn.username);
            //recentBill();
            //bestDrink();
            phoneCustomer = phone.Text;
            CustomerBill customerBill = new CustomerBill();
            customerBill.ShowDialog();
        }

        private void recentBill()
        {
            tea01Entities2 db = new tea01Entities2();
            var customer = db.Customers.Find(phone.Text);
            var bill = customer.Bills.OrderByDescending(u => u.OrderTimeStart).FirstOrDefault();

            if (bill != null)
            {
                /*
                String res = "";

                foreach (var i in bill)
                {
                    res += i.BillId + "\n";
                }

                MessageBox.Show(res);
                */

                lbRecentBill.Text = bill.BillId;
            }
        }

        private void bestDrink()
        {
            tea01Entities2 db = new tea01Entities2();
            var customer = db.Customers.Find(phone.Text);
            var bill = customer.Bills;

            String drinkId = "";
            var map = new Dictionary<string,int>();

            foreach (var i in bill)
            {
                foreach(var item in i.Items)
                {
                    int count = 0;
                    if (map.ContainsKey(item.DrinkId))
                    {
                        map[item.DrinkId] = map[item.DrinkId]++;
                    }
                    else
                    {
                        map.Add(item.DrinkId, count);
                    }
                }
            }

            if (map.Count > 0)
            {
                var id = map.Max(u => u.Value);
                foreach (var i in map.Keys.ToList())
                {
                    if (map[i] == id)
                    {
                        drinkId = i;
                    }
                }

                if (db.Drinks.Find(drinkId) != null)
                {
                    lbBestDrink.Text = db.Drinks.Find(drinkId).DrinkName;
                }
            }

            

            //MessageBox.Show(db.Drinks.Find(drinkId).DrinkName);
        }

        private void listBox_DoubleClick(object sender, EventArgs e)
        {
            MessageBox.Show(listBox.SelectedIndex.ToString());
            listView.RemoveAt(listBox.SelectedIndex);
            updateGridBox();
        }

        private void bunifuButton1_Click(object sender, EventArgs e)
        {
            PrevHome prevHome = new PrevHome();
            this.Hide();
            prevHome.ShowDialog();
            this.Close();
        }
    }
}

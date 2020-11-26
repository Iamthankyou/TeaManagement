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
    public partial class CustomerBill : Form
    {
        public CustomerBill()
        {
            InitializeComponent();
        }

        private void CustomerBill_Load(object sender, EventArgs e)
        {
            updateGridView();
            updateWelcome();
        }

        private void updateWelcome()
        {
            tea01Entities2 db = new tea01Entities2();
            lbWelcome.Text = "Danh sách hóa đơn mua hàng của khách hàng: " + db.Customers.Find(Home.phoneCustomer).FullName;
        }

             private void updateGridView()
            {
                tea01Entities2 db = new tea01Entities2();
                int voucher = 1;

                //MessageBox.Show(Home.phoneCustomer);

    //            gridView.DataSource = db.Bills.Where(u => u.Customer.PhoneNumber == Home.phoneCustomer).ToList().Select(u=>new {u.BillId, v = u.Total * (u.Voucher == null ? 1: (double)(100-u.Voucher.ratio)/100), u.OrderTimeStart, u.Staff.FullName}).OrderByDescending(u=>u.OrderTimeStart).ToList();
                //MessageBox.Show(Home.phoneCustomer);
                gridView.DataSource = db.Bills.Where(u => u.Customer.PhoneNumber == Home.phoneCustomer).Select(u=>new {u.BillId, v = u.Total * (u.Voucher == null ? 1: (double)(100-u.Voucher.ratio)/100), u.OrderTimeStart, u.Staff.FullName}).OrderByDescending(u=>u.OrderTimeStart).ToList();

                gridView.Columns[0].HeaderText = "Mã hóa đơn";
                gridView.Columns[1].HeaderText = "Tiền thanh toán";
                gridView.Columns[2].Visible = false;
                gridView.Columns[3].Visible = false;

                if (gridView.RowCount > 0)
                {
                    dateBill1.Value = (DateTime)db.Bills.Find(gridView.Rows[0].Cells[0].Value).OrderTimeStart;
                    dateBill2.Value = (DateTime)db.Bills.Find(gridView.Rows[0].Cells[0].Value).OrderTimeStart;
                    txCodeBill.Text = gridView.Rows[0].Cells[0].Value.ToString();
                    lbStaff.Text = gridView.Rows[0].Cells[3].Value.ToString();

                    var items = db.Bills.Find(gridView.Rows[0].Cells[0].Value).Items;
                    panel.Controls.Clear();
                
                    foreach (var item in items)
                    {
                        var drink = item.Drink;
                        FlowLayoutPanel subPanel = new FlowLayoutPanel();
                        subPanel.FlowDirection = FlowDirection.LeftToRight;
                        subPanel.AutoSize = true;

                        Button btn = new Button();
                        btn.Text = drink.DrinkName;
                        btn.Size = new Size(120, 80);
                        Image image;

                        image = Image.FromFile(drink.Image);
                        btn.BackgroundImage = image;
                        btn.ForeColor = Color.White;
                        btn.Font = new Font(btn.Font.FontFamily, 10);
                        btn.Font = new Font(btn.Font, FontStyle.Bold);

                        btn.ForeColorChanged += (s, ee) => {
                            btn.Font = new Font(btn.Font, FontStyle.Bold);
                        };


                        btn.BackgroundImageLayout = ImageLayout.Stretch;
                    

                        panel.Controls.Add(subPanel);
                        subPanel.Controls.Add(btn);
                        subPanel.BorderStyle = BorderStyle.Fixed3D;

                        Random rand = new Random();
                        Color[] c = { Color.Red, Color.Blue, Color.Green, Color.Cyan, Color.Magenta };

                        if (item.ItemToppings != null)
                        {
                            foreach (var i in item.ItemToppings)
                            {
                                Button btnTopping = new Button();
                                btnTopping.Text = i.Topping.ToppingName;
                                btnTopping.Size = new Size(120, 80);

                                btnTopping.BackColor = c[rand.Next(0, c.Length)];
                                btnTopping.ForeColor = Color.White;
                                btnTopping.Font = new Font(btn.Font.FontFamily, 10);
                                btnTopping.Font = new Font(btn.Font, FontStyle.Bold);
                            
                                btnTopping.BackgroundImageLayout = ImageLayout.Stretch;

                                subPanel.Controls.Add(btnTopping);
                            }

                        }
                    }
                }
            }

        private void updatePanel()
        {


        }

        private void gridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var items = db.Bills.Find(gridView.CurrentRow.Cells[0].Value).Items;

            panel.Controls.Clear();

            dateBill1.Value = (DateTime)db.Bills.Find(gridView.CurrentRow.Cells[0].Value).OrderTimeStart;
            dateBill2.Value = (DateTime)db.Bills.Find(gridView.CurrentRow.Cells[0].Value).OrderTimeStart;
            txCodeBill.Text = gridView.CurrentRow.Cells[0].Value.ToString();
            lbStaff.Text = gridView.CurrentRow.Cells[3].Value.ToString();


            foreach (var item in items)
            {
                var drink = item.Drink;
                FlowLayoutPanel subPanel = new FlowLayoutPanel();
                subPanel.FlowDirection = FlowDirection.LeftToRight;
                subPanel.AutoSize = true;

                Button btn = new Button();
                btn.Text = drink.DrinkName;
                btn.Size = new Size(120, 80);
                Image image;

                image = Image.FromFile(drink.Image);
                btn.BackgroundImage = image;
                btn.ForeColor = Color.White;
                btn.Font = new Font(btn.Font.FontFamily, 10);
                btn.Font = new Font(btn.Font, FontStyle.Bold);

                btn.BackgroundImageLayout = ImageLayout.Stretch;

                panel.Controls.Add(subPanel);
                subPanel.Controls.Add(btn);
                subPanel.BorderStyle = BorderStyle.Fixed3D;

                Random rand = new Random();
                Color[] c = { Color.Red, Color.Blue, Color.Green, Color.Cyan, Color.Magenta };

                if (item.ItemToppings != null)
                {
                    foreach (var i in item.ItemToppings)
                    {
                        Button btnTopping = new Button();
                        btnTopping.Text = i.Topping.ToppingName;
                        btnTopping.Size = new Size(120, 80);


                        btnTopping.BackColor = c[rand.Next(0, c.Length)];
                        btnTopping.ForeColor = Color.White;
                        btnTopping.Font = new Font(btn.Font.FontFamily, 10);
                        btnTopping.Font = new Font(btn.Font, FontStyle.Bold);

                        btnTopping.BackgroundImageLayout = ImageLayout.Stretch;

                        subPanel.Controls.Add(btnTopping);
                    }

                }
            }
        }

        private void txCodeBill_KeyPress(object sender, KeyPressEventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var bill = db.Bills.Find(txCodeBill.Text);

            if (e.KeyChar == 13)
            {
                if (bill != null && bill.Customer.PhoneNumber == Home.phoneCustomer)
                {
                    var items = bill.Items;

                    panel.Controls.Clear();

                    dateBill1.Value = (DateTime)bill.OrderTimeStart;
                    dateBill2.Value = (DateTime)bill.OrderTimeStart;
                    txCodeBill.Text = bill.BillId;
                    lbStaff.Text = bill.Staff.FullName;

                    foreach (var item in items)
                    {
                        var drink = item.Drink;
                        FlowLayoutPanel subPanel = new FlowLayoutPanel();
                        subPanel.FlowDirection = FlowDirection.LeftToRight;
                        subPanel.AutoSize = true;

                        Button btn = new Button();
                        btn.Text = drink.DrinkName;
                        btn.Size = new Size(120, 80);
                        Image image;

                        image = Image.FromFile(drink.Image);
                        btn.BackgroundImage = image;
                        btn.ForeColor = Color.White;
                        btn.Font = new Font(btn.Font.FontFamily, 10);
                        btn.Font = new Font(btn.Font, FontStyle.Bold);

                        btn.BackgroundImageLayout = ImageLayout.Stretch;

                        panel.Controls.Add(subPanel);
                        subPanel.Controls.Add(btn);
                        subPanel.BorderStyle = BorderStyle.Fixed3D;

                        Random rand = new Random();
                        Color[] c = { Color.Red, Color.Blue, Color.Green, Color.Cyan, Color.Magenta };

                        if (item.ItemToppings != null)
                        {
                            foreach (var i in item.ItemToppings)
                            {
                                Button btnTopping = new Button();
                                btnTopping.Text = i.Topping.ToppingName;
                                btnTopping.Size = new Size(120, 80);


                                btnTopping.BackColor = c[rand.Next(0, c.Length)];
                                btnTopping.ForeColor = Color.White;
                                btnTopping.Font = new Font(btn.Font.FontFamily, 10);
                                btnTopping.Font = new Font(btn.Font, FontStyle.Bold);

                                btnTopping.BackgroundImageLayout = ImageLayout.Stretch;

                                subPanel.Controls.Add(btnTopping);
                            }

                        }
                    }
                }
                else
                {
                    MessageBox.Show("Không tồn tại hóa đơn đó của khách hàng này");
                }
            }

            
        }

        private void i(object sender, EventArgs e)
        {

        }

        private void bunifuButton1_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            int voucher = 1;

            gridView.DataSource = db.Bills.Where(u => u.Customer.PhoneNumber == Home.phoneCustomer && u.OrderTimeStart>=dateBill1.Value && u.OrderTimeStart<=dateBill2.Value).ToList().Select(u => new { u.BillId, v = u.Total * (u.Voucher == null ? 1 : (double)(100 - u.Voucher.ratio) / 100), u.OrderTimeStart, u.Staff.FullName }).OrderByDescending(u => u.OrderTimeStart).ToList();
            //MessageBox.Show(Home.phoneCustomer);
            gridView.Columns[0].HeaderText = "Mã hóa đơn";
            gridView.Columns[1].HeaderText = "Tiền thanh toán";
            gridView.Columns[2].Visible = false;
            gridView.Columns[3].Visible = false;

            if (gridView.RowCount > 0)
            {
                dateBill1.Value = (DateTime)db.Bills.Find(gridView.Rows[0].Cells[0].Value).OrderTimeStart;
                dateBill2.Value = (DateTime)db.Bills.Find(gridView.Rows[0].Cells[0].Value).OrderTimeStart;
                txCodeBill.Text = gridView.Rows[0].Cells[0].Value.ToString();
                lbStaff.Text = gridView.Rows[0].Cells[3].Value.ToString();

                var items = db.Bills.Find(gridView.Rows[0].Cells[0].Value).Items;
                panel.Controls.Clear();

                foreach (var item in items)
                {
                    var drink = item.Drink;
                    FlowLayoutPanel subPanel = new FlowLayoutPanel();
                    subPanel.FlowDirection = FlowDirection.LeftToRight;
                    subPanel.AutoSize = true;

                    Button btn = new Button();
                    btn.Text = drink.DrinkName;
                    btn.Size = new Size(120, 80);
                    Image image;

                    image = Image.FromFile(drink.Image);
                    btn.BackgroundImage = image;
                    btn.ForeColor = Color.White;
                    btn.Font = new Font(btn.Font.FontFamily, 10);
                    btn.Font = new Font(btn.Font, FontStyle.Bold);

                    btn.ForeColorChanged += (s, ee) => {
                        btn.Font = new Font(btn.Font, FontStyle.Bold);
                    };


                    btn.BackgroundImageLayout = ImageLayout.Stretch;


                    panel.Controls.Add(subPanel);
                    subPanel.Controls.Add(btn);
                    subPanel.BorderStyle = BorderStyle.Fixed3D;

                    Random rand = new Random();
                    Color[] c = { Color.Red, Color.Blue, Color.Green, Color.Cyan, Color.Magenta };

                    if (item.ItemToppings != null)
                    {
                        foreach (var i in item.ItemToppings)
                        {
                            Button btnTopping = new Button();
                            btnTopping.Text = i.Topping.ToppingName;
                            btnTopping.Size = new Size(120, 80);

                            btnTopping.BackColor = c[rand.Next(0, c.Length)];
                            btnTopping.ForeColor = Color.White;
                            btnTopping.Font = new Font(btn.Font.FontFamily, 10);
                            btnTopping.Font = new Font(btn.Font, FontStyle.Bold);

                            btnTopping.BackgroundImageLayout = ImageLayout.Stretch;

                            subPanel.Controls.Add(btnTopping);
                        }

                    }
                }
            }
        }

        private void dateBill1_onValueChanged(object sender, EventArgs e)
        {

        }
    }
}

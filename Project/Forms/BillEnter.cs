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
    public partial class BillEnter : Form
    {
        private String codeBill;

        public BillEnter()
        {
            InitializeComponent();
        }

        private void Bill_Load(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            lbPhone.Text = Home.phoneCustomer;
            var customer = db.Customers.Find(lbPhone.Text);
            lbName.Text = customer.FullName;
            lbAddress.Text = customer.Address;
            labelLevel.Text = (customer.Level).ToString();

            sumSub.Text = "0 VNĐ";
            sumRes.Text = "0 VNĐ";
            updateGridBox();
            generateBill();
        }

        private void generateBill()
        {
            DateTime dateTime = DateTime.Now;
            codeBill = "";
            codeBill += dateTime.Day.ToString() + dateTime.Month.ToString() + dateTime.Hour.ToString() + dateTime.Minute.ToString() + dateTime.Second.ToString();
            lbBill.Text = "Chi tiết hóa đơn: "+ codeBill;
        }

        private void updateGridBox()
        {

            int price = 0;
            tea01Entities2 db = new tea01Entities2();

            foreach (var i in Home.listView)
            {
                String res = db.Drinks.Find(i[0]).DrinkName;

                price += Convert.ToInt32(db.Drinks.Find(i[0]).Price);
                int currentPrice = Convert.ToInt32(db.Drinks.Find(i[0]).Price);

                for (int iter = 1; iter < i.Count; iter++)
                {
                    String topping = db.Toppings.Find(i[iter]).ToppingName;
                    res += "+ " + topping;

                    price += Convert.ToInt32(db.Toppings.Find(i[iter]).Price);
                    currentPrice += Convert.ToInt32(db.Toppings.Find(i[iter]).Price);
                }

                listBox.Items.Add(res + ": " + currentPrice.ToString() + "VNĐ");
            }

            sumRaw.Text = price.ToString() + " VNĐ";
            sumSub.Text = "0 VNĐ";
            sumRes.Text = (Convert.ToInt32(sumRaw.Text.Split(' ')[0]) - Convert.ToInt32(sumSub.Text.Split(' ')[0])).ToString() + " VNĐ";
        }

        private void txVoucher_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                tea01Entities2 db = new tea01Entities2();
                var voucher = db.Vouchers.Find(txVoucher.Text);

                if (voucher == null)
                {
                    MessageBox.Show("Không tồn tại voucher");
                    txVoucher.Text = "";
                }
                else
                {
                    if (voucher.dateStart<=DateTime.Now && voucher.dateEnd >= DateTime.Now)
                    {
                        int sub = Convert.ToInt32(sumRaw.Text.Split(' ')[0]) * ((int)voucher.ratio) / 100;
                        sumSub.Text = sub.ToString() + " VNĐ";
                        sumRes.Text = (Convert.ToInt32(sumRaw.Text.Split(' ')[0]) - Convert.ToInt32(sumSub.Text.Split(' ')[0])).ToString() + " VNĐ";
                    }
                    else
                    {
                        sumSub.Text = "0 VNĐ";
                        sumRes.Text = (Convert.ToInt32(sumRaw.Text.Split(' ')[0]) - Convert.ToInt32(sumSub.Text.Split(' ')[0])).ToString() + " VNĐ";

                        MessageBox.Show("Voucher không khả dụng tại thời điểm này");
                    }
                         
                }
            }
        }

        private void bunifuFlatButton2_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();

            string payment = "";

            if (checkRawMoney.Checked == true)
            {
                payment = "OFFLINE";
            }
            else
            {
                payment = "ONLINE";
            }

            if (txVoucher.Text != "")
            {
                if (AddTable.idTableChoose != "")
                {
                    db.Bills.Add(new Bill()
                    {
                        BillId = codeBill,
                        OrderTimeStart = DateTime.Now,
                        Payments = payment,
                        Total = Convert.ToInt32(sumRaw.Text.Split(' ')[0]),
                        UserName = SignIn.username,
                        PhoneNumber = Home.phoneCustomer,
                        CodeVoucher = txVoucher.Text,
                        TableId = AddTable.idTableChoose
                    });
                }
                else
                {
                    db.Bills.Add(new Bill()
                    {
                        BillId = codeBill,
                        OrderTimeStart = DateTime.Now,
                        Payments = payment,
                        Total = Convert.ToInt32(sumRaw.Text.Split(' ')[0]),
                        UserName = SignIn.username,
                        PhoneNumber = Home.phoneCustomer,
                        CodeVoucher = txVoucher.Text,
                    });
                }

            }
            else
            {
                if (AddTable.idTableChoose != "")
                {
                    db.Bills.Add(new Bill()
                    {
                        BillId = codeBill,
                        OrderTimeStart = DateTime.Now,
                        Payments = payment,
                        Total = Convert.ToInt32(sumRaw.Text.Split(' ')[0]),
                        UserName = SignIn.username,
                        PhoneNumber = Home.phoneCustomer,
                        TableId = AddTable.idTableChoose
                    });
                }
                else
                {
                    db.Bills.Add(new Bill()
                    {
                        BillId = codeBill,
                        OrderTimeStart = DateTime.Now,
                        Payments = payment,
                        Total = Convert.ToInt32(sumRaw.Text.Split(' ')[0]),
                        UserName = SignIn.username,
                        PhoneNumber = Home.phoneCustomer
                    });
                }
            }


            //db.SaveChanges();

            //MessageBox.Show(SignIn.username);

            foreach (var i in Home.listView)
            {
                String idDrink = i[0];
                var drink = db.Drinks.Find(idDrink);

                Item item = new Item();
                item.DrinkId = idDrink;
                item.BillId = codeBill;
                /*
                                drink.Items.Add(new Item() { 
                                    DrinkId = idDrink,
                                    BillId = codeBill
                                });


                 */

                drink.Items.Add(item);

                //db.SaveChanges();

                for (int j=1; j<i.Count; j++)
                {
                    var topping = db.Toppings.Find(i[j]);
                    //drink.Toppings.Add(topping);

                    //item.Toppings.Add();
                    //fix:item.Toppings.Add(topping);
                    item.ItemToppings.Add(new ItemTopping()
                    {
                        BillId = item.BillId,
                        DrinkId = item.DrinkId,
                        ToppingId = topping.ToppingId,
                        ItemId = item.ItemId
                    });
                }

            }

            db.SaveChanges();

            MessageBox.Show("Thanh toán thành công");
            this.Close();

        }

        private void checkRawMoney_Click(object sender, EventArgs e)
        {
            checkInternetMoney.Checked = !checkRawMoney.Checked;
        }

        private void checkInternetMoney_Click(object sender, EventArgs e)
        {
            checkRawMoney.Checked = !checkInternetMoney.Checked;
        }

        private void bunifuFlatButton1_Click(object sender, EventArgs e)
        {
            AddTable addTable = new AddTable();
            addTable.ShowDialog();
        }
    }
}  

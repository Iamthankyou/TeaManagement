using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project.Forms
{
    public partial class Analysis : Form
    {
        public Analysis()
        {
            InitializeComponent();
        }

        private void Analysis_Load(object sender, EventArgs e)
        {
            loadFirstBill();
            loadFirstStaff();
            loadFirstTea();
            loadFirstTopping();
        }

        private void loadFirstBill()
        {
            tea01Entities2 db = new tea01Entities2();
            var tomorow = DateTime.Now.AddDays(1);
            gridViewBill.DataSource = db.Bills.Where(u=> DbFunctions.TruncateTime(u.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now)).ToList();

            if (gridViewBill.ColumnCount > 0)
            {
                for (int i=0; i<gridViewBill.ColumnCount; i++)
                {
                    if (i == 0 || i == 4)
                    {
                        gridViewBill.Columns[i].Visible = true;
                        continue;
                    }
                    gridViewBill.Columns[i].Visible = false;
                }

                gridViewBill.Columns[0].HeaderText = "Mã hóa đơn";
                gridViewBill.Columns[4].HeaderText = "Tổng tiền";
            }
        }

        private void loadFirstTea()
        {
            tea01Entities2 db = new tea01Entities2();

            var query = from drink in db.Set<Drink>() join item in db.Set<Item>() on drink.DrinkId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId where DbFunctions.TruncateTime(bill.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now) select new { drink } into x group x by  new { x.drink.DrinkId, x.drink.DrinkName} into y select new {Drink = y.Key.DrinkName,Count = y.Count()} ;
           // var query = from drink in db.Set<Drink>() join item in db.Set<Item>() on drink.DrinkId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId select new { drink };

            var res = query.Select(u=>new { u.Drink, u.Count });
            
            gridViewTea.DataSource = res.ToList();

            if (gridViewTea.ColumnCount > 0)
            {
                gridViewTea.Columns[1].Width = 50;
                gridViewTea.Columns[0].HeaderText = "Tên trà";
                gridViewTea.Columns[1].HeaderText = "Tổng";
            }
        }

        private void loadFirstTopping()
        {
            tea01Entities2 db = new tea01Entities2();

            var query = from bill in db.Set<Bill>() join item in db.Set<Item>() on bill.BillId equals item.BillId join itemTopping in db.Set<ItemTopping>() on item.BillId equals itemTopping.BillId join topping in db.Set<Topping>() on itemTopping.ToppingId equals topping.ToppingId where DbFunctions.TruncateTime(bill.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now) select new { topping.ToppingId,topping.ToppingName } into x group x by new { x.ToppingId, x.ToppingName } into y select new { Topping = y.Key.ToppingName, Count = y.Count()};

            
            gridViewTopping.DataSource = query.ToList();

            if (gridViewTopping.ColumnCount > 0)
            {
                gridViewTopping.Columns[1].Width = 50;
                gridViewTopping.Columns[0].HeaderText = "Tên topping";
                gridViewTopping.Columns[1].HeaderText = "Tổng";
            }

            //var tmp = from item in db.Set<Item>() join topping in db.Set<ItemTopping>() on select new { topping} ;

            //  var tmp = db.Items.GroupJoin(db.Set<Topping>);

            /*
            var query = from topping in db.Set<Topping>() join itemTopping in db.Set<ItemTopping> join item in db.Set<Item>() on topping.ToppingId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId where DbFunctions.TruncateTime(bill.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now) select new { drink } into x group x by new { x.drink.DrinkId, x.drink.DrinkName } into y select new { Drink = y.Key.DrinkName, Count = y.Count() };
            // var query = from drink in db.Set<Drink>() join item in db.Set<Item>() on drink.DrinkId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId select new { drink };

            var res = query.Select(u => new { u.Drink, u.Count });

            gridViewTea.DataSource = res.ToList();

            if (gridViewTea.ColumnCount > 0)
            {
                gridViewTea.Columns[1].Width = 50;
                gridViewTea.Columns[0].HeaderText = "Tên trà";
                gridViewTea.Columns[1].HeaderText = "Tổng";
            }*/

        }

        private void loadFirstStaff()
        {

        }

        private void buttonBunifuCustom8_Click(object sender, EventArgs e)
        {
            PrevHome prevHome = new PrevHome();
            this.Hide();
            prevHome.ShowDialog();
            this.Close();
        }
    }
}

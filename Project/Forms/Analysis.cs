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
            gridViewBill.DataSource = db.Bills.Where(u=> DbFunctions.TruncateTime(u.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now)).OrderByDescending(i=>i.Total).ToList();

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

            var sum = db.Bills.Where(u => DbFunctions.TruncateTime(u.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now)).Sum(i=>i.Total);
            var count = db.Bills.Where(u => DbFunctions.TruncateTime(u.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now)).ToList().Count;

            txCountBill.Text = count.ToString() + " hóa đơn";
            txSumBill.Text = sum.ToString() + " VNĐ";


        }

        private void loadFirstTea()
        {
            tea01Entities2 db = new tea01Entities2();

            var query = (from drink in db.Set<Drink>() join item in db.Set<Item>() on drink.DrinkId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId where DbFunctions.TruncateTime(bill.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now) select new { drink } into x group x by  new { x.drink.DrinkId, x.drink.DrinkName,x.drink.Price} into y select new {Drink = y.Key.DrinkName,Count = y.Count(),y.Key.Price}).OrderByDescending(i=>i.Count) ;
           // var query = from drink in db.Set<Drink>() join item in db.Set<Item>() on drink.DrinkId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId select new { drink };

            var res = query.Select(u=>new { u.Drink, u.Count, u.Price});
            
            gridViewTea.DataSource = res.ToList();

            if (gridViewTea.ColumnCount > 0)
            {
                gridViewTea.Columns[1].Width = 50;
                gridViewTea.Columns[0].HeaderText = "Tên trà";
                gridViewTea.Columns[1].HeaderText = "Tổng";
                gridViewTea.Columns[2].Width = 50;
                gridViewTea.Columns[2].HeaderText = "Giá";

            }


            if (gridViewTea.RowCount > 0)
            {
                var sum = res.Sum(u => u.Price * u.Count);
                var count = res.Sum(u => u.Count);
                txSumTea.Text = sum.ToString() + " VNĐ";
                txCountTea.Text = count.ToString() + " Trà";

            }
            else
            {
                txSumTea.Text = "0 VNĐ";
                txCountTea.Text = "0 Trà";
            }
        }

        private void loadFirstTopping()
        {
            tea01Entities2 db = new tea01Entities2();

            var query = (from bill in db.Set<Bill>() join item in db.Set<Item>() on bill.BillId equals item.BillId join itemTopping in db.Set<ItemTopping>() on item.BillId equals itemTopping.BillId join topping in db.Set<Topping>() on itemTopping.ToppingId equals topping.ToppingId where DbFunctions.TruncateTime(bill.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now) select new { topping.ToppingId,topping.ToppingName,topping.Price} into x group x by new { x.ToppingId, x.ToppingName,x.Price} into y select new { Topping = y.Key.ToppingName, Count = y.Count(),y.Key.Price}).OrderByDescending(i=>i.Count);

            
            gridViewTopping.DataSource = query.ToList();

            if (gridViewTopping.ColumnCount > 0)
            {
                gridViewTopping.Columns[1].Width = 50;
                gridViewTopping.Columns[0].HeaderText = "Tên topping";
                gridViewTopping.Columns[1].HeaderText = "Tổng";
                gridViewTopping.Columns[2].HeaderText = "Giá";
                gridViewTopping.Columns[2].Width = 50;
            }

            if (gridViewTopping.RowCount > 0)
            {
                var sum = query.Sum(u => u.Price * u.Count);
                var count = query.Sum(u => u.Count);
                txSumTopping.Text = sum.ToString() + " VNĐ";
                txCountTopping.Text = count.ToString() + " Topping";

            }
            else
            {
                txSumTopping.Text =  "0 VNĐ";
                txCountTopping.Text =  "0 Topping";

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
            tea01Entities2 db = new tea01Entities2();

            var query = (from bill in db.Set<Bill>()
                         join staff in db.Set<Staff>() on bill.UserName equals staff.UserName
                         where DbFunctions.TruncateTime(bill.OrderTimeStart) == DbFunctions.TruncateTime(DateTime.Now)
                         select new { staff.FullName, bill.BillId, staff.UserName } into x
                         group x by new { x.UserName, x.FullName } into y
                         select new
                         {
                             Name = y.Key.FullName,
                             Count = y.Count()
                         }).OrderByDescending(i => i.Count);

            gridViewStaff.DataSource = query.ToList();

            if (gridViewStaff.ColumnCount > 0)
            {
                gridViewStaff.Columns[1].Width = 100;
                gridViewStaff.Columns[0].HeaderText = "Tên ";
                gridViewStaff.Columns[1].HeaderText = "Số bills";
            }

        }

        private void buttonBunifuCustom8_Click(object sender, EventArgs e)
        {
            PrevHome prevHome = new PrevHome();
            this.Hide();
            prevHome.ShowDialog();
            this.Close();
        }

        private void filterBill()
        {
            tea01Entities2 db = new tea01Entities2();
            DateTime start = startBill.Value;
            DateTime end = endBill.Value;

            gridViewBill.DataSource = db.Bills.Where(u => u.OrderTimeStart>=start && u.OrderTimeStart<=end).OrderByDescending(i => i.Total).ToList();

            if (gridViewBill.ColumnCount > 0)
            {
                for (int i = 0; i < gridViewBill.ColumnCount; i++)
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

            var sum = db.Bills.Where(u => u.OrderTimeStart >= start && u.OrderTimeStart <= end).Sum(i => i.Total);
            var count = db.Bills.Where(u => u.OrderTimeStart >= start && u.OrderTimeStart <= end).ToList().Count;

            txCountBill.Text = count.ToString() + " hóa đơn";
            txSumBill.Text = sum.ToString() + " VNĐ";

        }

        private void btnSubmitFilterBill_Click(object sender, EventArgs e)
        {
            filterBill();
        }

        private void filterTea()
        {
            tea01Entities2 db = new tea01Entities2();
            DateTime start = startTea.Value;
            DateTime end = endTea.Value;

            var query = (from drink in db.Set<Drink>() join item in db.Set<Item>() on drink.DrinkId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId where bill.OrderTimeStart>=start && bill.OrderTimeStart<=end select new { drink } into x group x by new { x.drink.DrinkId, x.drink.DrinkName, x.drink.Price} into y select new { Drink = y.Key.DrinkName, Count = y.Count(), y.Key.Price}).OrderByDescending(i => i.Count);
            // var query = from drink in db.Set<Drink>() join item in db.Set<Item>() on drink.DrinkId equals item.DrinkId join bill in db.Set<Bill>() on item.BillId equals bill.BillId select new { drink };

            var res = query.Select(u => new { u.Drink, u.Count, u.Price});

            gridViewTea.DataSource = res.ToList();

            if (gridViewTea.ColumnCount > 0)
            {
                gridViewTea.Columns[1].Width = 50;
                gridViewTea.Columns[0].HeaderText = "Tên trà";
                gridViewTea.Columns[1].HeaderText = "Tổng";
                gridViewTea.Columns[2].Width = 50;
                gridViewTea.Columns[2].HeaderText = "Tổng";

                
            }

            if (gridViewTea.RowCount > 0)
            {
                var sum = res.Sum(u => u.Price * u.Count);
                var count = res.Sum(u => u.Count);
                txSumTea.Text = sum.ToString() + " VNĐ";
                txCountTea.Text = count.ToString() + " Trà";

            }
            else
            {
                txSumTea.Text = "0 VNĐ";
                txCountTea.Text = "0 Trà";
            }

        }

        private void btnSubmitFilterTea_Click(object sender, EventArgs e)
        {
            filterTea();
        }

        private void filterTopping()
        {

            tea01Entities2 db = new tea01Entities2();
            DateTime start = startTopping.Value;
            DateTime end = endTopping.Value;

            var query = (from bill in db.Set<Bill>() join item in db.Set<Item>() on bill.BillId equals item.BillId join itemTopping in db.Set<ItemTopping>() on item.BillId equals itemTopping.BillId join topping in db.Set<Topping>() on itemTopping.ToppingId equals topping.ToppingId where bill.OrderTimeStart >= start && bill.OrderTimeStart <= end select new { topping.ToppingId, topping.ToppingName, topping.Price } into x group x by new { x.ToppingId, x.ToppingName, x.Price} into y select new { Topping = y.Key.ToppingName, Count = y.Count(), y.Key.Price}).OrderByDescending(i => i.Count);

            gridViewTopping.DataSource = query.ToList();

            if (gridViewTopping.ColumnCount > 0)
            {
                gridViewTopping.Columns[1].Width = 50;
                gridViewTopping.Columns[0].HeaderText = "Tên topping";
                gridViewTopping.Columns[1].HeaderText = "Tổng";

                gridViewTopping.Columns[2].HeaderText = "Giá";
                gridViewTopping.Columns[2].Width = 50;

            }

            if (gridViewTopping.RowCount > 0)
            {

                var sum = query.Sum(u => u.Price * u.Count);
                var count = query.Sum(u => u.Count);
                txSumTopping.Text = sum.ToString() + " VNĐ";
                txCountTopping.Text = count.ToString() + " Topping";

            }
            else
            {
                txSumTopping.Text = "0 VNĐ";
                txCountTopping.Text = "0 Topping";
            }

        }

        private void btnSubmitFilterTopping_Click(object sender, EventArgs e)
        {
            filterTopping();
        }

        private void filterStaff()
        {
            DateTime start = startStaff.Value;
            DateTime end = endStaff.Value;

            tea01Entities2 db = new tea01Entities2();

            var query = (from bill in db.Set<Bill>()
                         join staff in db.Set<Staff>() on bill.UserName equals staff.UserName
                         where bill.OrderTimeStart >= start && bill.OrderTimeStart <= end
                         select new { staff.FullName, bill.BillId, staff.UserName } into x
                         group x by new { x.UserName, x.FullName } into y
                         select new
                         {
                             Name = y.Key.FullName,
                             Count = y.Count()
                         }).OrderByDescending(i => i.Count);

            gridViewStaff.DataSource = query.ToList();

            if (gridViewStaff.ColumnCount > 0)
            {
                gridViewStaff.Columns[1].Width = 100;
                gridViewStaff.Columns[0].HeaderText = "Tên ";
                gridViewStaff.Columns[1].HeaderText = "Số bills";
            }


        }

        private void btnSubmitFilterStaff_Click(object sender, EventArgs e)
        {
            filterStaff();
        }

        private void updateSumBill()
        {
            
        }
    }
}

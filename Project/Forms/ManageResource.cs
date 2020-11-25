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
    public partial class ManageResource : Form
    {
        private List<checkBoxBunifuCustom> listCheckbox;

        public ManageResource()
        {
            InitializeComponent();
        }

        private void bunifuButton7_Click(object sender, EventArgs e)
        {

        }

        private void bunifuMetroTextbox2_OnValueChanged(object sender, EventArgs e)
        {


        }

        private void ManageResource_Load(object sender, EventArgs e)
        {
            updateGridViewListResource();
            updateGridViewListDrink();
            updateGridViewListTopping();
            loadPanel();
        }

        private void loadPanel()
        {
            tea01Entities2 db = new tea01Entities2();
            var resources = db.Resources;

            panel.Controls.Clear();
            panel.FlowDirection = FlowDirection.LeftToRight;
            listCheckbox = new List<checkBoxBunifuCustom>();

            foreach(var resource in resources)
            {
                checkBoxBunifuCustom checkBox = new checkBoxBunifuCustom();
                buttonBunifuCustom button = new buttonBunifuCustom();
                Label label = new Label();
                FlowLayoutPanel subPanel = new FlowLayoutPanel();

                label.Text = "0";
                checkBox.idItem = resource.ResourceId;
                button.idItem = resource.ResourceId;
                button.Text = resource.ResourceName;
                button.Size = new Size(193, 30);
                checkBox.Checked = false;
                checkBox.amount = 0;

                checkBox.MouseClick += (s, e) => { 
                    if (checkBox.Checked == true)
                    {
                        checkBox.Checked = true;
                        string value = "0";
                        if (DialogCustom.InputBox("Input", "Nhập vào số lượng:", ref value) == DialogResult.OK)
                        {
                            checkBox.amount = Convert.ToInt32(value);
                            label.Text = (checkBox.amount).ToString();

                            if (checkBox.amount == 0)
                            {
                                checkBox.Checked = false;
                            }

                        }
                    }
                    else
                    {
                        checkBox.Checked = false;
                        checkBox.amount = 0;
                        label.Text = (checkBox.amount).ToString();

                    }
                };

                listCheckbox.Add(checkBox);
    
                subPanel.FlowDirection = FlowDirection.LeftToRight;
                subPanel.Controls.Add(checkBox);
                subPanel.Controls.Add(label);
                subPanel.Controls.Add(button);

                panel.Controls.Add(subPanel);
            }
        }

        private void updateGridViewListDrink()
        {
            tea01Entities2 db = new tea01Entities2();
            gridViewListDrink.DataSource = db.Drinks.ToList();

            for (int i=0; i<gridViewListDrink.ColumnCount; i++)
            {
                if (i == 1)
                {
                    gridViewListDrink.Columns[1].Visible = true;
                    gridViewListDrink.Columns[1].HeaderText = "Tên trà";
                    continue;
                }

                gridViewListDrink.Columns[i].Visible = false;
            }
        }


        private void updateGridViewListTopping()
        {
            tea01Entities2 db = new tea01Entities2();
            gridViewListTopping.DataSource = db.Toppings.ToList();

            for (int i = 0; i < gridViewListTopping.ColumnCount; i++)
            {
                if (i == 1)
                {
                    gridViewListTopping.Columns[1].Visible = true;
                    gridViewListDrink.Columns[1].HeaderText = "Tên topping";
                    continue;
                }

                gridViewListTopping.Columns[i].Visible = false;
            }
        }


        private void updateGridViewListResource()
        {
            tea01Entities2 db = new tea01Entities2();
            gridViewListResource.DataSource = db.Resources.ToList();
            gridViewListResource.Columns[0].Visible = false;
            gridViewListResource.Columns[2].Visible = false;
            gridViewListResource.Columns[3].Visible = false;
            gridViewListResource.Columns[4].Visible = false;
            gridViewListResource.Columns[1].HeaderText = "Tên nguyên liệu";
        }

        private void gridViewListResource_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            txIdResource.Text = gridViewListResource.CurrentRow.Cells[0].Value.ToString();
            txNameResource.Text = gridViewListResource.CurrentRow.Cells[1].Value.ToString();
            txAmountResource.Text = gridViewListResource.CurrentRow.Cells[2].Value.ToString();
        }

        private void btnSubmitResource_Click(object sender, EventArgs e)
        {

        }

        private void z(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();

            if (txAmountResource.Text!="" && txIdResource.Text!="" && txNameResource.Text != "")
            {
                db.Resources.AddOrUpdate(new Resource() { 
                    ResourceId = txIdResource.Text,
                    ResourceName = txNameResource.Text,
                    Amount = Convert.ToInt32(txAmountResource.Text)
                });

                db.SaveChanges();
                updateGridViewListResource();
                MessageBox.Show("Đã cập nhật cơ sở dữ liệu");
            }
        }

        private void loadPanelForDrink()
        {
            tea01Entities2 db = new tea01Entities2();
            var resources = db.Resources;
            var drink = db.Drinks.Find(gridViewListDrink.CurrentRow.Cells[0].Value);
            var drink_Resource = drink.Drink_Resource;

            panel.Controls.Clear();
            panel.FlowDirection = FlowDirection.LeftToRight;
            listCheckbox = new List<checkBoxBunifuCustom>();

            foreach (var resource in resources)
            {
                checkBoxBunifuCustom checkBox = new checkBoxBunifuCustom();
                buttonBunifuCustom button = new buttonBunifuCustom();
                Label label = new Label();
                FlowLayoutPanel subPanel = new FlowLayoutPanel();

                label.Text = "0";
                checkBox.idItem = resource.ResourceId;
                button.idItem = resource.ResourceId;
                button.Text = resource.ResourceName;
                button.Size = new Size(193, 30);
                checkBox.Checked = false;
                checkBox.amount = 0;

                // Update checkbox for drink
                
                if (drink_Resource.Where(u=>u.ResourceId == resource.ResourceId).FirstOrDefault() != null)
                {
                    checkBox.Checked = true;
                    checkBox.amount = (int)drink_Resource.Where(u => u.ResourceId == resource.ResourceId).First().Amount;

                    label.Text = (checkBox.amount).ToString();
                }

                checkBox.MouseClick += (s, e) => {
                    if (checkBox.Checked == true)
                    {
                        checkBox.Checked = true;
                        string value = "0";
                        if (DialogCustom.InputBox("Input", "Nhập vào số lượng:", ref value) == DialogResult.OK)
                        {
                            checkBox.amount = Convert.ToInt32(value);
                            label.Text = (checkBox.amount).ToString();

                            if (checkBox.amount == 0)
                            {
                                checkBox.Checked = false;
                            }

                        }
                    }
                    else
                    {
                        checkBox.Checked = false;
                        checkBox.amount = 0;
                        label.Text = (checkBox.amount).ToString();

                    }
                };

                listCheckbox.Add(checkBox);

                subPanel.FlowDirection = FlowDirection.LeftToRight;
                subPanel.Controls.Add(checkBox);
                subPanel.Controls.Add(label);
                subPanel.Controls.Add(button);

                panel.Controls.Add(subPanel);
            }
        }

        private void gridViewListDrink_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            loadPanelForDrink();
        }

        private void loadPanelForTopping()
        {
            tea01Entities2 db = new tea01Entities2();
            var resources = db.Resources;
            var topping = db.Toppings.Find(gridViewListTopping.CurrentRow.Cells[0].Value);
            var topping_Resource = topping.Topping_Resource;

            panel.Controls.Clear();
            panel.FlowDirection = FlowDirection.LeftToRight;
            listCheckbox = new List<checkBoxBunifuCustom>();

            foreach (var resource in resources)
            {
                checkBoxBunifuCustom checkBox = new checkBoxBunifuCustom();
                buttonBunifuCustom button = new buttonBunifuCustom();
                Label label = new Label();
                FlowLayoutPanel subPanel = new FlowLayoutPanel();

                label.Text = "0";
                checkBox.idItem = resource.ResourceId;
                button.idItem = resource.ResourceId;
                button.Text = resource.ResourceName;
                button.Size = new Size(193, 30);
                checkBox.Checked = false;
                checkBox.amount = 0;

                // Update checkbox for drink

                if (topping_Resource.Where(u => u.ResourceId == resource.ResourceId).FirstOrDefault() != null)
                {
                    checkBox.Checked = true;
                    checkBox.amount = (int)topping_Resource.Where(u => u.ResourceId == resource.ResourceId).First().Amount;

                    label.Text = (checkBox.amount).ToString();
                }

                checkBox.MouseClick += (s, e) => {
                    if (checkBox.Checked == true)
                    {
                        checkBox.Checked = true;
                        string value = "0";
                        if (DialogCustom.InputBox("Input", "Nhập vào số lượng:", ref value) == DialogResult.OK)
                        {
                            checkBox.amount = Convert.ToInt32(value);
                            label.Text = (checkBox.amount).ToString();

                            if (checkBox.amount == 0)
                            {
                                checkBox.Checked = false;
                            }

                        }
                    }
                    else
                    {
                        checkBox.Checked = false;
                        checkBox.amount = 0;
                        label.Text = (checkBox.amount).ToString();

                    }
                };

                listCheckbox.Add(checkBox);

                subPanel.FlowDirection = FlowDirection.LeftToRight;
                subPanel.Controls.Add(checkBox);
                subPanel.Controls.Add(label);
                subPanel.Controls.Add(button);

                panel.Controls.Add(subPanel);
            }
        }

        private void gridViewListDrink_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnSubmitDrink_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var drink = db.Drinks.Find(gridViewListDrink.CurrentRow.Cells[0].Value);
            
            //Clear
            drink.Drink_Resource.Clear();
            db.SaveChanges();

            foreach (var resource in listCheckbox)
            {
                if (resource.amount > 0 && resource.Checked == true)
                {
                    var res = db.Resources.Find(resource.idItem);
                    Drink_Resource drink_Resource = new Drink_Resource();
                    drink_Resource.DrinkId = drink.DrinkId;
                    drink_Resource.ResourceId = res.ResourceId;
                    drink_Resource.Amount = resource.amount;
                    
                    drink.Drink_Resource.Add(drink_Resource);
                    db.SaveChanges();
                }
            }

            MessageBox.Show("Đã cập nhật thành phần cho trà này");
        }

        private void gridViewListTopping_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            loadPanelForTopping();
        }

        private void btnSubmitTopping_Click(object sender, EventArgs e)
        {
            tea01Entities2 db = new tea01Entities2();
            var topping = db.Toppings.Find(gridViewListTopping.CurrentRow.Cells[0].Value);

            //Clear
            topping.Topping_Resource.Clear();
            db.SaveChanges();

            foreach (var resource in listCheckbox)
            {
                if (resource.amount > 0 && resource.Checked == true)
                {
                    var res = db.Resources.Find(resource.idItem);
                    Topping_Resource topping_Resource = new Topping_Resource();
                    topping_Resource.ToppingId = topping.ToppingId;
                    topping_Resource.ResourceId = res.ResourceId;
                    topping_Resource.Amount = resource.amount;

                    topping.Topping_Resource.Add(topping_Resource);
                    db.SaveChanges();
                }
            }

            MessageBox.Show("Đã cập nhật thành phần cho topping này");
        }
    }
}

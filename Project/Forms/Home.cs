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
    public partial class Home : Form
    {
        private List<Button> listButtonTea = new List<Button>();
        private List<Label> listLabelTea = new List<Label>();
        private List<Button> listButtonTopping = new List<Button>();
        private List<Label> listLabelTopping = new List<Label>();

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
        }

        private void updatePanelTopping()
        {
            tea01Entities2 db = new tea01Entities2();
            var toppings = db.Toppings.ToList();

            Random rand = new Random();
            Color[] c = { Color.Red, Color.Blue, Color.Green, Color.Cyan, Color.Magenta };

            foreach (var i in toppings)
            {
                //Bunifu.UI.WinForms.BunifuButton.BunifuButton btn = new Bunifu.UI.WinForms.BunifuButton.BunifuButton();
                Button btn = new Button();
                btn.Text = i.ToppingName + " " + i.Price + "đ";
                btn.Size = new Size(120, 80);
                Image image;
                Label lb = new Label();
                lb.Size = new Size(20, 20);
                lb.Text = "0";

                btn.Click += (s, e) => {

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

        private void updatePanelTea()
        {
            tea01Entities2 db = new tea01Entities2();
            var drinks = db.Drinks.ToList();

            foreach (var i in drinks)
            {
                //Bunifu.UI.WinForms.BunifuButton.BunifuButton btn = new Bunifu.UI.WinForms.BunifuButton.BunifuButton();
                Button btn = new Button();
                btn.Text = i.DrinkName + " " + i.Price.ToString() + "đ";
                btn.Size = new Size(120, 80);
                Image image;
                Label lb = new Label();
                lb.Size = new Size(20, 20);
                lb.Text = "0";

                btn.Click += (s, e) => {

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
d
        }
    }
}

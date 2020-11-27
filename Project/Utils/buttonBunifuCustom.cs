using Bunifu.UI.WinForms.BunifuButton;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.Utils
{
    class buttonBunifuCustom:BunifuButton
    {
        public string idItem { get; set; }

        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            // buttonBunifuCustom
            // 
            this.DisabledBorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(191)))), ((int)(((byte)(191)))), ((int)(((byte)(191)))));
            this.Name = "buttonBunifuCustom";
            this.Click += new System.EventHandler(this.buttonBunifuCustom_Click);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        private void buttonBunifuCustom_Click(object sender, EventArgs e)
        {

        }
    }
}

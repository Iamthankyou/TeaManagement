﻿using Project.Forms;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Project
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new RegisterStaff());
            //           Application.Run(new Forms.PermisionForm());
            Application.Run(new SignIn());  
            //Application.Run(new ManageDrinkType());
            //Application.Run(new ShowAddDrink());
            //Application.Run(new Home());
            //Application.Run(new BillDetail());
            //           Application.Run(new ShowAddTopping());
            //Application.Run(new Home());
            //Application.Run(new ManageVoucher());
            //Application.Run(new CustomerBill());
            //Application.Run(new ManageResource());

            //Application.Run(new PrevHome());
            //Application.Run(new Analysis());
            //Application.Run(new ManageStaff());
            //Application.Run(new ManageBill());
        }
    }
}

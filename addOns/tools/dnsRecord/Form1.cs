using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net.Sockets;
using DnDns.Enums;
using DnDns.Query;
using DnDns.Records;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            textBox3.Text = "";
            DnDns.Enums.NsType r = NsType.A;
            DnsQueryRequest request3 = new DnsQueryRequest();
            if (textBox2.Text == "A") r = NsType.A;
            if (textBox2.Text == "CNAME") r = NsType.CNAME;
            if (textBox2.Text == "MX") r = NsType.MX;
            try
            {
                DnsQueryResponse response3 = request3.Resolve(textBox1.Text, r, NsClass.INET, ProtocolType.Tcp);
                foreach (DnDns.Records.DnsRecordBase x in response3.Answers)
                {
                    textBox3.Text += x.Answer + "\n";

                    String myRec = x.Answer.Substring(x.Answer.IndexOf("Mail Exchanger: ") + 16).Trim();
                    DnsQueryRequest request4 = new DnsQueryRequest();
                    DnsQueryResponse response4 = request4.Resolve(myRec.ToString(), NsType.A, NsClass.INET, ProtocolType.Tcp);

                    MessageBox.Show(response4.Answers[0].Answer.Substring(response4.Answers[0].Answer.IndexOf("Address: ")+9));
                }
            }
            catch (Exception err) {
                MessageBox.Show(err.Message);
            }
            //return (response3[0].Name.ToString());
        }

  
    }
}

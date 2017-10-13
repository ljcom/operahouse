using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections;
using System.Globalization;

// For the SQL Server integration
using Microsoft.SqlServer.Server;

// Other things we need for WebRequest
using System.Net;
using System.Text;
using System.IO;

using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace dnsRequest
{
    public partial class Functions
    {

        // Function to request DNS Entry
        [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
        public static SqlString getDNS(SqlString domainName, SqlString server)
        {
            SqlString myIP = null;

            //Error handler to handle unexpected errors, if works fine will not land on catch.
            try
            {
                string myHost = System.Net.Dns.GetHostName();


                for (int i = 0; i <= System.Net.Dns.GetHostEntry(myHost).AddressList.Length - 1; i++)
                {
                    if (System.Net.Dns.GetHostEntry(myHost).AddressList[i].IsIPv6LinkLocal == false)
                    {
                        myIP += System.Net.Dns.GetHostEntry(myHost).AddressList[i].ToString() + ' ';
                    }
                }
            }

            catch (Exception exc)
            {
                // send error back
                SqlContext.Pipe.Send(exc.Message);
                //document = exc.Message;
            }
            return (myIP);
        }


    }
}

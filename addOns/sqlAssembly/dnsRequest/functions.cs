using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections;
using System.Globalization;

// For the SQL Server integration
using Microsoft.SqlServer.Server;

using System.Net.Sockets;
using DnDns.Enums;
using DnDns.Query;
using DnDns.Records;

namespace dnsRequest
{
    public partial class Functions
    {
        // Function to request DNS Entry
        [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
        public static SqlString getDNS(SqlString domainName, SqlString recType)
        {

            String myRec = "";
            DnDns.Enums.NsType r = NsType.A;
            DnsQueryRequest request3 = new DnsQueryRequest();
            if (recType == "A") r = NsType.A;
            if (recType == "CNAME") r = NsType.CNAME;
            if (recType == "MX") r = NsType.MX;

            DnsQueryResponse response3 = request3.Resolve(domainName.ToString(), r, NsClass.INET, ProtocolType.Tcp);
            foreach (DnDns.Records.DnsRecordBase x in response3.Answers)
            {
                myRec += x.Answer + "\n";
            }

            return (myRec);
        }

        // Function to request DNS Entry
        [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
        public static bool checkMX(SqlString domainName, SqlString IPAddress)
        {
            bool r = false;
            String myRec = "";
            DnsQueryRequest request3 = new DnsQueryRequest();
            try
            {
                DnsQueryResponse response3 = request3.Resolve(domainName.ToString(), NsType.MX, NsClass.INET, ProtocolType.Tcp);
                foreach (DnDns.Records.DnsRecordBase x in response3.Answers)
                {
                    myRec = x.Answer.Substring(x.Answer.IndexOf("Mail Exchanger: ") + 16).Trim();
                    try
                    {
                        DnsQueryRequest request4 = new DnsQueryRequest();
                        DnsQueryResponse response4 = request4.Resolve(myRec.ToString(), NsType.A, NsClass.INET, ProtocolType.Tcp);
                        if (response4.Answers.Length > 0)
                        {
                            int n = response4.Answers[0].Answer.IndexOf("Address: ");
                            if (n >= 0 && response4.Answers[0].Answer.Substring(n + 9) == IPAddress.ToString())
                            {
                                r = true;
                                break;
                            }
                        }
                    }
                    finally { }
                }
            }
            finally { }

            return (r);
        }




    }
}

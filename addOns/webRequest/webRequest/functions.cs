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

namespace webRequest
{
    public partial class Functions
    {
        // Function to return a web URL as a string value.
        [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
        public static SqlString GET(SqlString uri, SqlString username, SqlString passwd)
        {
            // The SqlPipe is how we send data back to the caller
            SqlPipe pipe = SqlContext.Pipe;
            SqlString document;

            // Set up the request, including authentication
            WebRequest req = WebRequest.Create(Convert.ToString(uri));
            if (Convert.ToString(username) != null & Convert.ToString(username) != "")
            {
                req.Credentials = new NetworkCredential(
                    Convert.ToString(username),
                    Convert.ToString(passwd));
            }
            ((HttpWebRequest)req).UserAgent = "CLR web client on SQL Server";

            // Fire off the request and retrieve the response.
            // We'll put the response in the string variable "document".
            WebResponse resp = req.GetResponse();
            Stream dataStream = resp.GetResponseStream();
            StreamReader rdr = new StreamReader(dataStream);
            document = (SqlString)rdr.ReadToEnd();

            // Close up everything...
            rdr.Close();
            dataStream.Close();
            resp.Close();

            // .. and return the output to the caller.
            return (document);
        }

        // Function to submit a HTTP POST and return the resulting output.
        [Microsoft.SqlServer.Server.SqlFunction(DataAccess = DataAccessKind.Read)]
        public static SqlString POST(SqlString uri, SqlString postData, SqlString username, SqlString passwd)
        {
            SqlPipe pipe = SqlContext.Pipe;
            SqlString document;
            byte[] postByteArray = Encoding.UTF8.GetBytes(Convert.ToString(postData));

            // Set up the request, including authentication, 
            // method=POST and encoding:

            WebRequest req = WebRequest.Create(Convert.ToString(uri));
            ((HttpWebRequest)req).UserAgent = "CLR web client on SQL Server";
            if (Convert.ToString(username) != null & Convert.ToString(username) != "")
            {
                req.Credentials = new NetworkCredential(
                    Convert.ToString(username),
                    Convert.ToString(passwd));
            }
            req.Method = "POST";
            req.ContentType = "application/x-www-form-urlencoded";

            System.Net.ServicePointManager.Expect100Continue = false;
            

            // Submit the POST data
            Stream dataStream = req.GetRequestStream();
            dataStream.Write(postByteArray, 0, postByteArray.Length);
            dataStream.Close();

            // Collect the response, put it in the string variable "document"
            WebResponse resp = req.GetResponse();
            dataStream = resp.GetResponseStream();
            StreamReader rdr = new StreamReader(dataStream);
            document = (SqlString)rdr.ReadToEnd();

            // Close up and return
            rdr.Close();
            dataStream.Close();
            resp.Close();

            return (document);
        }
    }
}

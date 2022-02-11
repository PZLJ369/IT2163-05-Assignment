using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace IT2163_Assignment
{
    public partial class Login : System.Web.UI.Page
    {
        string ASDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ASDB"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;
        string userid;
        string count;
        public static int MaxInvalidPasswordAttempts { get; }
        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // prevent going back to login page after successful login.
            if (Session["LoggedIn"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            {
                if (Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                {
                    Response.Redirect("Home.aspx", false);
                }
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string userid = tb_email.Text.ToString().Trim();
            int lockoutCount = ReadLockout(userid);
            DateTime lockoutTiming = ReadLockoutTime(userid);
            DateTime currentTime = DateTime.Now;

            // account lockout acfter 3 failures
            // auto account recovery after lockout
            if (lockoutCount > 2 && lockoutTiming != null)
            {
                lblMessage.Text = "Too many failure account lockout!";
                lblMessage.ForeColor = Color.Red;
                DateTime UnlockTime = lockoutTiming.AddSeconds(30);
                if (currentTime > UnlockTime)
                {
                    lblMessage.Text = "Account recovered";
                    lblMessage.ForeColor = Color.Green;
                    AccountRecover(userid);
                }
                else
                {
                    lblMessage.Text = "Account recover at " +UnlockTime;
                    lblMessage.ForeColor = Color.Red;
                }
            }
            else
            {
                string pwd = tb_password.Text.ToString().Trim();
                //userid = tb_email.Text.ToString().Trim();
                SHA512Managed hashing = new SHA512Managed();
                string dbHash = getDBHash(userid);
                string dbSalt = getDBSalt(userid);
                try
                {
                    if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                    {
                        string pwdWithSalt = pwd + dbSalt;
                        byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                        string userHash = Convert.ToBase64String(hashWithSalt);
                        if (userHash.Equals(dbHash))
                        {
                            Session["LoginCount"] = 0;
                            Session["LoggedIn"] = tb_email.Text.Trim();

                            // create a new GUID and save into the session
                            string guid = Guid.NewGuid().ToString();
                            Session["AuthToken"] = guid;

                            // now create a new cookie with this guid value
                            Response.Cookies.Add(new HttpCookie("AuthToken", guid));

                            Session["ID"] = userid;
                            Response.Redirect("Home.aspx", false);
                        }
                        else
                        {
                            Session["LoginCount"] = Convert.ToInt32(Session["LoginCount"]) + 1;
                            lblMessage.Text = "Invalid username or password";
                            lblMessage.ForeColor = Color.Red;
                            if (Convert.ToInt32(Session["LoginCount"]) > 2)
                            {
                                lblMessage.Text = "Too many failure account lockout!";
                                lblMessage.ForeColor = Color.Red;
                                AccountLockout(userid);
                            }
                        }
                    }
                    else
                    {
                        Session["LoginCount"] = Convert.ToInt32(Session["LoginCount"]) + 1;
                        lblMessage.Text = "Invalid username or password";
                        lblMessage.ForeColor = Color.Red;
                        if (Convert.ToInt32(Session["LoginCount"]) > 2)
                        {
                            lblMessage.Text = "Too many failure account lockout!";
                            lblMessage.ForeColor = Color.Red;
                            AccountLockout(userid);
                        }
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.ToString());
                }
                finally { }
            }

        }

        protected string getDBHash(string userid)
        {
            string h = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "select PasswordHash FROM Account WHERE Email=@ID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@ID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["PasswordHash"] != null)
                        {
                            if (reader["PasswordHash"] != DBNull.Value)
                            {
                                h = reader["PasswordHash"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return h;
        }

        protected string getDBSalt(string userid)
        {
            string s = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "select PASSWORDSALT FROM ACCOUNT WHERE Email=@ID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@ID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PASSWORDSALT"] != null)
                        {
                            if (reader["PASSWORDSALT"] != DBNull.Value)
                            {
                                s = reader["PASSWORDSALT"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return s;
        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                //ICryptoTransform decryptTransform = cipher.CreateDecryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0,
               plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }

        protected string AccountLockout(string userid)
        {
            DateTime currentTime = DateTime.Now;
            var LoginFailCount = Convert.ToInt32(Session["LoginCount"]);
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "UPDATE Account SET LoginFail = @LoginFailCount, LockoutTime = @CurrentTime WHERE Email=@ID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@ID", userid);
            command.Parameters.AddWithValue("@LoginFailCount", LoginFailCount);
            command.Parameters.AddWithValue("@CurrentTime", currentTime);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return "Lockout";
        }

        protected Int32 ReadLockout(string userid)
        {
            Int32 FailCount = 0; 
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "SELECT LoginFail FROM Account WHERE Email=@ID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@ID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["LOGINFAIL"] != null)
                        {
                            if (reader["LOGINFAIL"] != DBNull.Value)
                            {
                                FailCount = Convert.ToInt32(reader["LOGINFAIL"]);
                            }
                        }
                    }
                }
                connection.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return FailCount;
        }

        protected DateTime ReadLockoutTime(string userid)
        {
            DateTime LockoutTimecount = DateTime.Now;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "SELECT LockoutTime FROM Account WHERE Email=@ID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@ID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["LockoutTime"] != null)
                        {
                            if (reader["LockoutTime"] != DBNull.Value)
                            {
                                LockoutTimecount = Convert.ToDateTime(reader["LockoutTime"]);
                            }
                        }
                    }
                }
                connection.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return LockoutTimecount;
        }

        protected DateTime? AccountRecover(string userid)
        {
            DateTime? newTime = null;
            SqlConnection connection = new SqlConnection(ASDBConnectionString);
            string sql = "UPDATE Account SET LoginFail = @LoginFailCount, LockoutTime = @LockoutTime WHERE Email=@ID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@ID", userid);
            command.Parameters.AddWithValue("@LoginFailCount", 0);
            command.Parameters.AddWithValue("@LockoutTime", DBNull.Value);
            try
            {
                connection.Open();
                command.ExecuteReader();
                connection.Close();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return newTime;
        }

        public bool ValidateCaptcha()
        {
            bool result = true;

            //When user submits the recaptcha form, the user gets a response POST parameter. 
            //captchaResponse consist of the user click pattern. Behaviour analytics! AI :) 
            string captchaResponse = Request.Form["g-recaptcha-response"];

            //To send a GET request to Google along with the response and Secret key.
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create
           (" https://www.google.com/recaptcha/api/siteverify?secret=6Lfsck4eAAAAAJR5JF8HrJfBSl7oo7y0I1O1nZBk &response=" + captchaResponse);


            try
            {

                //Codes to receive the Response in JSON format from Google Server
                using (WebResponse wResponse = req.GetResponse())
                {
                    using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
                    {
                        //The response in JSON format
                        string jsonResponse = readStream.ReadToEnd();

                        //To show the JSON response string for learning purpose
                        lbl_gScore.Text = jsonResponse.ToString();

                        JavaScriptSerializer js = new JavaScriptSerializer();

                        //Create jsonObject to handle the response e.g success or Error Deserialize Json
                        MyObject jsonObject = js.Deserialize<MyObject>(jsonResponse);

                        //Convert the string "False" to bool false or "True" to bool true
                        result = Convert.ToBoolean(jsonObject.success);//

                    }
                }

                return result;
            }
            catch (WebException ex)
            {
                throw ex;
            }
        }
    }
}
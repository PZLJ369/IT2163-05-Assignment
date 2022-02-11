using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;

namespace IT2163_Assignment
{
    public partial class Registration : System.Web.UI.Page
    {
        string ASDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ASDB"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        static string line = "\r";

        public class MyObject
        {
            public string success { get; set; }
            public List<string> ErrorMessage { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // prevent going back to register page after successful login.
            if (Session["LoggedIn"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            {
                if (Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                {
                    Response.Redirect("Home.aspx", false);
                }
            }
        }

        protected void btn_Register_Click(object sender, EventArgs e)
        {

            string pwd = tb_password.Text.ToString().Trim(); ;

            //Generate random "salt" 
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];

            //Fills array of bytes with a cryptographically strong sequence of random values.
            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);

            SHA512Managed hashing = new SHA512Managed();

            string pwdWithSalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

            finalHash = Convert.ToBase64String(hashWithSalt);

            RijndaelManaged cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;

            //check password complexity
            int scores = checkPassword(tb_password.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;
                case 2:
                    status = "Weak";
                    break;
                case 3:
                    status = "Medium";
                    break;
                case 4:
                    status = "Medium";
                    break;
                case 5:
                    status = "Strong";
                    break;
                default:
                    break;
            }
            lbl_pwdscore.Text = "Status : " + status;

            if (scores < 5)
            {
                lbl_pwdscore.ForeColor = Color.Red;
                return;
            }
            else
            {
                lbl_pwdscore.ForeColor = Color.Green;

                // check whether email already exist
                SqlConnection connection = new SqlConnection(ASDBConnectionString);
                string sql = "SELECT Email FROM Account";
                SqlCommand command = new SqlCommand(sql, connection);
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    var InputEmail = tb_email.Text.Trim();
                    List<string> EmailList = new List<string>();
                    while (reader.Read())
                    {
                        EmailList.Add(reader["Email"].ToString());
                    }

                    if (EmailList.Contains(InputEmail))
                    {
                        lbl_emailexist.Text = "Email has been taken.Try another!";
                        lbl_emailexist.ForeColor = Color.Red;
                    }
                    else
                    {
                        lbl_emailexist.Text = "Good to go";
                        lbl_emailexist.ForeColor = Color.Green;
                        createAccount();
                        Response.Redirect("Login.aspx", false);
                    }  
                }
                connection.Close();

            }
            

        }


        protected void createAccount()
        {
            using (SqlConnection con = new SqlConnection(ASDBConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@Firstname, @Lastname, @Creditcard, @Email, @Birthdate, @Photo, @LoginFail, @LockoutTime, @PasswordHash, @PasswordSalt, @DateTimeRegistered, @IV, @Key)"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.AddWithValue("@Firstname", tb_firstname.Text.Trim());
                        cmd.Parameters.AddWithValue("@Lastname", tb_lastname.Text.Trim());
                        cmd.Parameters.AddWithValue("@Creditcard", Convert.ToBase64String(encryptData(tb_creditcard.Text.Trim())));
                        cmd.Parameters.AddWithValue("@Email", tb_email.Text.Trim());
                        cmd.Parameters.AddWithValue("@Birthdate", tb_birthdate.Text.Trim());
                        cmd.Parameters.AddWithValue("@Photo", tb_photo.Text.Trim());
                        cmd.Parameters.AddWithValue("@LoginFail", 0);
                        cmd.Parameters.AddWithValue("@LockoutTime", DBNull.Value);
                        cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                        cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                        cmd.Parameters.AddWithValue("@DateTimeRegistered", DateTime.Now);
                        cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                        cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));
                        cmd.Connection = con;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(ex.ToString());
                        }
                        finally
                        {
                            con.Close();
                        }

                    }
                }
            }
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
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }

            finally { }
            return cipherText;
        }


        private int checkPassword(string password)
        {
            int score = 0;

            if (password.Length < 12)
            {
                return 1;
            }
            else
            {
                score = 1;
            }

            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
            }
            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score++;
            }
            if (Regex.IsMatch(password, "[0-9]"))
            {
                score++;
            }
            if (Regex.IsMatch(password, "[^A-Za-z0-9]"))
            {
                score++;
            }
            return score;
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
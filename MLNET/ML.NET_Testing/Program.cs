using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;

namespace NOAADataDownloader
{
    class Program
    {
        // NOAA API token (TODO: setup as config file with .gitignore, env variable, or something else so token isnt posted publically)
        private static readonly string ApiToken = "YOUR_API_TOKEN";
        // URL for NOAA CDO API
        private static readonly string BaseUrl = "https://www.ncei.noaa.gov/cdo-web/api/v2/";

        static async Task Main(string[] args)
        {
            // Daily temperature data for New York state
            string endpoint = "data";
            string datasetId = "GHCND";
            // Requested temperature data types
            string dataTypes = "TMIN,TMAX";
            DateTime todaysDate = DateTime.Today;
            string startDate = todaysDate.AddYears(-1).ToString();
            string endDate = todaysDate.ToString();
            // FIPS for New York
            string locationId = "FIPS:36";
            // Maximum records per request
            int recordLimit = 1000;

            // Build query parameters
            string query = $"?datasetid={datasetId}&datatypeid={dataTypes}" +
                           $"&locationid={locationId}&startdate={startDate}&enddate={endDate}&limit={recordLimit}";

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(BaseUrl);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                client.DefaultRequestHeaders.Add("token", ApiToken);

                HttpResponseMessage response = await client.GetAsync(endpoint + query);

                if (response.IsSuccessStatusCode)
                {
                    string jsonResponse = await response.Content.ReadAsStringAsync();
                    JObject data = JObject.Parse(jsonResponse);

                    var results = data["results"];
                    if (results != null)
                    {
                        Console.WriteLine("Received Data:");
                        Console.WriteLine(results.ToString());
                    }
                    else
                    {
                        Console.WriteLine("results returned as Null");
                    }
                }
                else
                {
                    Console.WriteLine($"Error: {response.StatusCode}");
                }
            }
        }
    }
}

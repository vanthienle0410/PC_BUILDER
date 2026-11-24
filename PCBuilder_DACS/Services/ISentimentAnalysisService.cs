namespace PCBuilder_DACS.Services
{
    public interface ISentimentAnalysisService
    {
        string AnalyzeSentiment(string text);
        void TrainModel();
    }
}

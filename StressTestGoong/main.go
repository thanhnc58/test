package main

import (
	"flag"
	"fmt"
	vegeta "github.com/tsenart/vegeta/v12/lib"
	"github.com/tsenart/vegeta/v12/lib/plot"
	"os"
	"time"
)

func main() {
	pathToWriteReport := flag.String("report-file", "resource/report", "the path to the report file")
	reportType := flag.String("report-type", "text", "the type of the output report")
	targetsPath := flag.String("targets-file", "resource/urls.txt", "the list of urls to send request")
	durationText := flag.Int("duration", 1, "duration of the test in seconds")
	frequency := flag.Int("frequency", 1, "amount of requests per seconds, 0 means as fast as possible")
	flag.Parse()

	reader, err := os.Open(*targetsPath)
	if err != nil {
		fmt.Println(err)
		return
	}
	duration := time.Duration(*durationText) * time.Second
	rate := vegeta.Rate{
		Freq: *frequency,
		Per:  time.Second,
	}

	fmt.Println("========================= Start stress testing ==============================")
	target := vegeta.NewHTTPTargeter(reader, nil, nil)

	attacker := vegeta.NewAttacker()

	metrics, graph := attackWithMetrics(attacker, &target, &rate, duration)
	if err := writeReport(*reportType, *pathToWriteReport, metrics); err != nil {
		fmt.Println(err)
		return
	}
	if err = drawPlot("resource/plot", graph); err != nil {
		fmt.Println(err)
		return
	}

	fmt.Println("========================= Finished stress testing ==============================")
}

func attackWithMetrics(attacker *vegeta.Attacker, target *vegeta.Targeter, rate *vegeta.Rate, duration time.Duration) (*vegeta.Metrics, *plot.Plot) {
	var metrics vegeta.Metrics
	plotGraph := plot.New(plot.Title("Goong Stress Test"), plot.Downsample(4000), plot.Label(plot.ErrorLabeler))

	for res := range attacker.Attack(*target, rate, duration, "Boom!") {
		metrics.Add(res)
		err := plotGraph.Add(res)
		if err != nil {
			fmt.Println(err)
		}
	}
	metrics.Close()
	plotGraph.Close()
	return &metrics, plotGraph
}

func writeReport(typ, filePath string, metrics *vegeta.Metrics) error {
	var reporter vegeta.Reporter
	extension := ""
	switch typ {
	case "text":
		reporter = vegeta.NewTextReporter(metrics)
		extension = ".txt"
	case "json":
		reporter = vegeta.NewJSONReporter(metrics)
		extension = ".json"
	case "hdrplot":
		reporter = vegeta.NewHDRHistogramPlotReporter(metrics)
		extension = ".txt"
	default:
		return fmt.Errorf("there is no such type of report")
	}

	file, err := os.OpenFile(filePath+extension, os.O_CREATE|os.O_WRONLY, 0777)
	if err != nil {
		return fmt.Errorf("failed when opening file to write report with %s", err)
	}

	if err = reporter.Report(file); err != nil {
		return fmt.Errorf("failed when writing report to file iwth %s", err)
	}

	if err = file.Close(); err != nil {
		return err
	}

	return nil
}

func drawPlot(filePath string, plot *plot.Plot) error {
	a, err := os.OpenFile(filePath, os.O_CREATE|os.O_WRONLY, 0777)
	if err != nil {
		return fmt.Errorf("failed when drawing plot to file with %s", err)
	}

	_, err = plot.WriteTo(a)
	a.Close()
	return nil
}

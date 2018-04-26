BEGIN{
	recSize = 0;
	startTime =0 ;
	stopTime = 0;
}
{
	event = $1;
	time = $2;
	nodeId = $3;
	level = $4;
	packetSize = $8;
	
	if(level == "AGT" && event == "s" && packetSize >= 512)
		if(time < startTime)
			startTime = time;
	
	if(level == "AGT" && event == "s" && packetSize >= 512)
	{
		if(time > stopTime)
			stopTime = time;
		tempSize = packetSize % 512;
		packetSize = tempSize;
		recSize += packetSize;
	}	
}
END{
	printf("\n Average Goodput = %f\n\n",(recSize/(stopTime-startTime))*(8/1000));
}


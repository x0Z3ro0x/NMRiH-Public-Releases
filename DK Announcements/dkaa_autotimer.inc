public Action Timer_Auto(Handle timer)
{
	int diceRoll = GetRandomInt(0, 2);
	bool hasLink = true;
	new isRandom = GetConVarInt(dkaa_isRandomMsg);
	
	if (isRandom == 1)
	{
		switch (diceRoll)
		{
			case 0:
			{
				autoMsg = "Need an admin, some help, or just have a question? Come to our \
				community for all of that and more.";
			}
			case 1:
			{
				autoMsg = "Players bugging you? We are a public server open to everyone. We will \
				remove anyone found to bully or act like an asshat to others. You can report \
				players on our discord server -";
			}
			case 2:
			{
				autoMsg = "Did you know you folks can vote on new maps or restart the current \
				one? Just press esc and click on 'call vote'. No permissions needed. Dead \
				folks cannot call a vote as the permission flag to allow spectator voting doesn't \
				work.";
				hasLink = false;
			}
		}
	}
	else
	{
		if (rollStart == 0)
		{
			rollStart = 1;
			autoMsg = "Need an admin, some help, or just have a question? Come to our community for all of \
			that and more.";
		}
		else if (rollStart == 1)
		{
			rollStart = 2;
			autoMsg = "Players bugging you? We are a public server open to everyone. We will \
			remove anyone found to bully or act like an asshat to others. You can report \
			players on our discord server -";
		}
		else if (rollStart == 2)
		{
			rollStart = 0;
			autoMsg = "Did you know you folks can vote on new maps or restart the current \
			one? Just press esc and click on 'call vote'. No permissions needed. Dead \
			folks cannot call a vote as the permission flag to allow spectator voting doesn't \
			work.";
			hasLink = false;
		}
	}
	
	if (hasLink) 
	{
		CPrintToChatAll("%s\n\n{red}%s", autoMsg, link);
		return Plugin_Continue;
	}
	else 
	{
		CPrintToChatAll("%s", autoMsg);
		return Plugin_Continue;
	}
}
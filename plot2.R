# Load and down select data
power <- read.csv("../data/household_power_consumption.txt", na.strings = "?", sep = ";")
power <- tbl_df(power)
power <- power %>% mutate(Date = as.Date(Date, format="%d/%m/%Y")) %>%
  filter(Date == '2007-02-01' | Date == '2007-02-02') %>%
  mutate(datetime = ymd_hms(paste(Date, Time, sep = ""))) %>%
  select(datetime, Global_active_power:Sub_metering_3)

# Set device
png("plot2.png", height = 480, width = 480)

# line graph (datetime vs. Global Active Power)
plot(power$datetime, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Turn device off
dev.off()
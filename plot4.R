# Load and down select data
power <- read.csv("../data/household_power_consumption.txt", na.strings = "?", sep = ";")
power <- tbl_df(power)
power <- power %>% mutate(Date = as.Date(Date, format="%d/%m/%Y")) %>%
  filter(Date == '2007-02-01' | Date == '2007-02-02') %>%
  mutate(datetime = ymd_hms(paste(Date, Time, sep = ""))) %>%
  select(datetime, Global_active_power:Sub_metering_3)

# Set device
png("plot4.png", height = 480, width = 480)

# Set device layout
par(mfrow = c(2,2))

# Top left Global Active Power histogram
hist(power$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Top right line graph (datetime vs. Global Active Power)
plot(power$datetime, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Bottom left line graph (datetime vs. Sub metering 1, 2, 3)
plot(power$datetime, power$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright", "", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black", "red","blue"))

# Bottom right line graph (datetime vs. Global reactive power)
with(power, plot(datetime, Global_reactive_power, type = "l"))

# Turn off device
dev.off()
machines = %w[
elssearchcuriosity-simplified01
]
fdisk_cmd = "'d
2
n







w
'"

machines.each do |m|
        # Process.wait spawn("ssh -o StrictHostKeyChecking=no search@#{m} 'sudo resize2fs /dev/xvda2'")
        cmd = "ssh -o StrictHostKeyChecking=no search@#{m} \"echo #{fdisk_cmd} | sudo fdisk /dev/xvda\""
        puts cmd
        Process.wait spawn(cmd)
end

machines.each do |m|
        # Process.wait spawn("ssh -o StrictHostKeyChecking=no search@#{m} 'sudo resize2fs /dev/xvda2'")
        cmd = "ssh -o StrictHostKeyChecking=no search@#{m} \"sudo shutdown -r now & disown\""
        puts cmd
        Process.wait spawn(cmd)
end

puts "\nsleep for 30 seconds, wait for resize......"
sleep 30  #20 seconds

machines.each do |m|
        # Process.wait spawn("ssh -o StrictHostKeyChecking=no search@#{m} 'sudo resize2fs /dev/xvda2'")
        cmd = "ssh -o StrictHostKeyChecking=no search@#{m} \"sudo resize2fs /dev/xvda2\""
        puts cmd
        Process.wait spawn(cmd)
end

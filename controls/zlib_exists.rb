plan_name = input("plan_name", value: "zlib")
lib_path = input('base_dir', value: '/lib/libz.so')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

hab_pkg_path = command("hab pkg path #{plan_ident}")
describe hab_pkg_path do
  its('exit_status') { should eq 0 }
  its('stdout') { should_not be_empty }
end

target_path = File.join(hab_pkg_path.stdout.strip, lib_path)
describe command("ls -al #{target_path}") do
  its('stdout') { should_not be_empty }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end

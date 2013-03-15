open Printf

let caps_to_string caps =
	let cap_to_string = function
		| Xenctrl.CAP_HVM -> "CAP_HVM"
		| Xenctrl.CAP_DirectIO -> "CAP_DirectIO"
	in
	Printf.sprintf "[%s]"
		(String.concat "; " (List.map cap_to_string caps))

let _ =
	let xc = Xenctrl.interface_open () in
	let p = Xenctrl.physinfo xc in
	Xenctrl.interface_close xc;
	printf "Physical info dump:\n";
	printf "threads_per_core = %d\n" p.Xenctrl.threads_per_core;
	printf "cores_per_socket = %d\n" p.Xenctrl.cores_per_socket;
	printf "nr_cpus = %d\n" p.Xenctrl.nr_cpus;
	printf "max_node_id = %d\n" p.Xenctrl.max_node_id;
	printf "cpu_khz = %d\n" p.Xenctrl.cpu_khz;
	printf "total_pages = %nd\n" p.Xenctrl.total_pages;
	printf "free_pages = %nd\n" p.Xenctrl.free_pages;
	printf "scrub_pages = %nd\n" p.Xenctrl.scrub_pages;
	printf "capabilities = %s\n" (caps_to_string p.Xenctrl.capabilities);
	printf "max_nr_cpus = %d\n" p.Xenctrl.max_nr_cpus;
	printf "Physical info dump over\n";
	let nr_sockets =
		p.Xenctrl.nr_cpus /
		(p.Xenctrl.threads_per_core * p.Xenctrl.cores_per_socket)
	in
	printf "It looks like your machine has %d sockets\n" nr_sockets

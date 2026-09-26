
kernel_model_extern_data.x64:	file format elf64-x86-64

Disassembly of section .text:

<read_jiffies>:
               	movq	$0x0, %rax
		R_X86_64_32S	jiffies
               	movq	(%rax), %rax
               	retq

<jiffies_addr>:
               	movq	$0x0, %rax
		R_X86_64_32S	jiffies
               	retq

<net_index>:
               	movq	$0x0, %rax
		R_X86_64_32S	init_net
               	movslq	(%rax), %rax
               	retq

<family>:
               	movq	$0x0, %rax
		R_X86_64_32S	cpu_info
               	movzbq	(%rax), %rax
               	retq

<pcpu_base>:
               	movslq	%edi, %rdi
               	movq	(,%rdi,8), %rax
		R_X86_64_32S	__per_cpu_offset
               	retq

<ctype_class>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movzbq	(,%rax), %rax
		R_X86_64_32S	_ctype
               	retq

<cmp_fn>:
               	movq	$0x0, %rax
		R_X86_64_32S	strcmp
               	retq

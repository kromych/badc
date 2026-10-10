
kernel_model_extern_data.x64:	file format elf64-x86-64

Disassembly of section .text:

<read_ticks>:
               	movq	$0x0, %rax
		R_X86_64_32S	ticks
               	movq	(%rax), %rax
               	retq

<ticks_addr>:
               	movq	$0x0, %rax
		R_X86_64_32S	ticks
               	retq

<net_index>:
               	movq	$0x0, %rax
		R_X86_64_32S	net0
               	movl	(%rax), %eax
               	retq

<family>:
               	movq	$0x0, %rax
		R_X86_64_32S	cpu0
               	movzbq	(%rax), %rax
               	retq

<cpu_base>:
               	movslq	%edi, %rdi
               	movq	(,%rdi,8), %rax
		R_X86_64_32S	cpu_offset
               	retq

<char_class>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movzbq	(,%rax), %rax
		R_X86_64_32S	class_tab
               	retq

<cmp_fn>:
               	movq	$0x0, %rax
		R_X86_64_32S	strcmp
               	retq

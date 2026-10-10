
global_addr_multidim_index.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x15, 0x24(%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x63, 0x5c(%rcx)
               	movl	$0x7, (%rax)
               	movl	0x24(%rax), %edx
               	cmpl	$0x15, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	0x5c(%rcx), %ecx
               	cmpl	$0x63, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq

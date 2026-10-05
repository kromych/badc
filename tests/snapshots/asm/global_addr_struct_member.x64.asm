
global_addr_struct_member.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x2a, 0x24(%rcx)
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdx
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0x8(%rax), %rdx
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x18(%rax), %rax
               	cmpl	$0xd, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0x24(%rcx), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq

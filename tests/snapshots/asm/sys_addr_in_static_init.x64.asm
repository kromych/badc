
sys_addr_in_static_init.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	movq	%rsi, %rdx
               	callq	*%rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x4, %edx
               	movq	0x8(%rsp), %rdi
               	callq	*%rax
               	movq	%rax, (%rsp)
               	movq	<rip>, %rax # <addr>
               	movq	0x8(%rsp), %rdi
               	callq	*%rax
               	movq	(%rsp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq

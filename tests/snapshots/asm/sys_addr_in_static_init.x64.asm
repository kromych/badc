
sys_addr_in_static_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	movl	$0x4, %esi
               	callq	*%rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	xorl	%edx, %edx
               	callq	*%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, (%rsp)
               	movq	%rax, %rdi
               	leaq	0x18(%rsp), %rsi
               	movl	$0x4, %edx
               	callq	*%rcx
               	movq	%rax, 0x8(%rsp)
               	movq	(%rsp), %rax
               	movq	<rip>, %rcx # <addr>
               	movq	%rax, %rdi
               	callq	*%rcx
               	movq	0x8(%rsp), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
               	retq
               	movl	$0x2a, %eax
               	addq	$0x28, %rsp
               	retq

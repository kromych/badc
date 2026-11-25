
libc_atoll_wcsrtombs.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movabsq	$-0x218711a00, %r11     # imm = 0xFFFFFFFDE78EE600
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, (%rsp)
               	leaq	0x8(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	movl	$0x8, %edx
               	xorl	%ecx, %ecx
               	callq	<addr>
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq

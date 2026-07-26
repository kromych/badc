
union_bitfield_layout.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$-0x10, %rcx
               	orq	$0x5, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	0x4(%rax), %edx
               	andq	$-0x10, %rdx
               	orq	$0x3, %rdx
               	movl	%edx, 0x4(%rax)
               	movl	%ecx, %eax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	%edx, %eax
               	andq	$0xf, %rax
               	shlq	$0x3c, %rax
               	sarq	$0x3c, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq


bitop_common_type_sign_extend.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mix_ui>:
               	movl	%edi, %eax
               	orq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<mix_iu>:
               	movl	%esi, %eax
               	orq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<xor_ui>:
               	movl	%edi, %eax
               	xorq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<and_ui>:
               	movl	%edi, %eax
               	andq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<pc_advance>:
               	movzbq	(%rdi), %rax
               	shlq	$0x18, %rax
               	movl	%eax, %ecx
               	movzbq	0x1(%rdi), %rax
               	shlq	$0x10, %rax
               	orq	%rax, %rcx
               	movzbq	0x2(%rdi), %rax
               	shlq	$0x8, %rax
               	orq	%rcx, %rax
               	movzbq	0x3(%rdi), %rcx
               	orq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	subq	%rsi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	0x8(%rcx), %rdx
               	movzbq	(%rax), %rcx
               	shlq	$0x18, %rcx
               	movl	%ecx, %esi
               	movzbq	0x1(%rax), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rsi
               	movzbq	0x2(%rax), %rcx
               	shlq	$0x8, %rcx
               	orq	%rsi, %rcx
               	movzbq	0x3(%rax), %rax
               	orq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	subq	%rdx, %rax
               	cmpq	$-0x23e, %rax           # imm = 0xFDC2
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

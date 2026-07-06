
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
               	movl	%eax, %eax
               	movzbq	0x1(%rdi), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movzbq	0x2(%rdi), %rcx
               	shlq	$0x8, %rcx
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
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
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
               	addq	$0x8, %rcx
               	movzbq	(%rax), %rdx
               	shlq	$0x18, %rdx
               	movl	%edx, %edx
               	movzbq	0x1(%rax), %rsi
               	shlq	$0x10, %rsi
               	orq	%rsi, %rdx
               	movzbq	0x2(%rax), %rsi
               	shlq	$0x8, %rsi
               	orq	%rsi, %rdx
               	movzbq	0x3(%rax), %rax
               	orq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	subq	%rcx, %rax
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
               	addb	%al, 0x41(%rdx)


two_d_array_param_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_short_row>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<sum_int_row>:
               	movslq	%esi, %rsi
               	imulq	$0xc, %rsi, %rax
               	addq	%rdi, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<sum_char_row>:
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movsbq	(%rax), %rcx
               	movsbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x4c0, %rsp            # imm = 0x4C0
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	xorq	%rsi, %rsi
               	movw	%si, (%rdx)
               	leaq	-0x400(%rbp), %rdx
               	movq	%rax, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rdx
               	movw	%si, 0x2(%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x100, %rax            # imm = 0x100
               	jl	<addr>
               	leaq	-0x400(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x14(%rax)
               	leaq	-0x400(%rbp), %rax
               	movl	$0x10, %ecx
               	movw	%cx, 0x16(%rax)
               	leaq	-0x400(%rbp), %rax
               	addq	$0x14, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1244, %rax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x480(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rsi, %rdx
               	addq	$0x0, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x0, %rsi
               	movl	%esi, (%rdx)
               	leaq	-0x480(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	incq	%rsi
               	movl	%esi, 0x4(%rdx)
               	leaq	-0x480(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rsi
               	addq	$0x2, %rsi
               	movl	%esi, 0x8(%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	jl	<addr>
               	leaq	-0x480(%rbp), %rax
               	addq	$0x54, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x837, %rax            # imm = 0x837
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x4a8(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	addq	$0x0, %rdx
               	leaq	0x41(%rax), %rsi
               	addq	$0x0, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, (%rdx)
               	leaq	-0x4a8(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	leaq	0x41(%rax), %rsi
               	incq	%rsi
               	movslq	%esi, %rdi
               	movb	%dil, 0x1(%rdx)
               	leaq	-0x4a8(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	leaq	0x41(%rax), %rsi
               	addq	$0x2, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, 0x2(%rdx)
               	leaq	-0x4a8(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	leaq	0x41(%rax), %rsi
               	addq	$0x3, %rsi
               	movslq	%esi, %rdi
               	movb	%dil, 0x3(%rdx)
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jl	<addr>
               	leaq	-0x4a8(%rbp), %rax
               	addq	$0xc, %rax
               	movsbq	(%rax), %rcx
               	movsbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x116, %rax            # imm = 0x116
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x4c0, %rsp            # imm = 0x4C0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)

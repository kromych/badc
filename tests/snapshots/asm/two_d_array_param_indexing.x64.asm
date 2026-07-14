
two_d_array_param_indexing.x64:	file format elf64-x86-64

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
               	subq	$0x4c0, %rsp            # imm = 0x4C0
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdx, %rsi
               	xorq	%rdx, %rdx
               	movw	%dx, (%rsi)
               	leaq	-0x400(%rbp), %rsi
               	movq	%rcx, %rdi
               	shlq	$0x2, %rdi
               	addq	%rdi, %rsi
               	movw	%dx, 0x2(%rsi)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x100, %rcx            # imm = 0x100
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	leaq	(%rdx), %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x0, %rdx
               	movl	%edx, (%rsi)
               	leaq	-0x480(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	incq	%rdx
               	movl	%edx, 0x4(%rsi)
               	leaq	-0x480(%rbp), %rdx
               	imulq	$0xc, %rax, %rsi
               	addq	%rdx, %rsi
               	imulq	$0x64, %rax, %rdx
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rsi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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
               	leaq	(%rdx), %rdi
               	leaq	0x41(%rax), %rdx
               	addq	$0x0, %rdx
               	movslq	%edx, %rsi
               	movb	%sil, (%rdi)
               	leaq	-0x4a8(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdx, %rsi
               	leaq	0x41(%rax), %rdx
               	incq	%rdx
               	movslq	%edx, %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x4a8(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdx, %rsi
               	leaq	0x41(%rax), %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdi
               	movb	%dil, 0x2(%rsi)
               	leaq	-0x4a8(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdx, %rsi
               	leaq	0x41(%rax), %rdx
               	addq	$0x3, %rdx
               	movslq	%edx, %rdi
               	movb	%dil, 0x3(%rsi)
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
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
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


two_d_array_param_indexing.x64:	file format elf64-x86-64

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
               	subq	$0x400, %rsp            # imm = 0x400
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	-0x400(%rbp), %rdx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	movw	%cx, (%rdx)
               	movw	%cx, 0x2(%rdx)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	leaq	-0x400(%rbp), %rax
               	movw	$0x1234, 0x14(%rax)     # imm = 0x1234
               	movw	$0x10, 0x16(%rax)
               	addq	$0x14, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x1244, %eax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x78(%rbp), %rcx
               	imulq	$0xc, %rax, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rdx
               	movl	%edx, (%rcx)
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, 0x4(%rcx)
               	addq	$0x2, %rdx
               	movl	%edx, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0xa, %eax
               	jl	<addr>
               	leaq	-0x78(%rbp), %rax
               	addq	$0x54, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x837, %eax            # imm = 0x837
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	0x41(%rax), %rdx
               	movb	%dl, (%rcx)
               	incq	%rdx
               	movb	%dl, 0x1(%rcx)
               	leaq	0x41(%rax), %rdx
               	leaq	0x2(%rdx), %rsi
               	movb	%sil, 0x2(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	addq	$0x3, %rdx
               	movb	%dl, 0x3(%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0xc, %rax
               	movsbq	(%rax), %rcx
               	movsbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movsbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x116, %eax            # imm = 0x116
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

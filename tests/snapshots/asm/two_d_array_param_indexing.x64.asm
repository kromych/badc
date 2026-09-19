
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
               	subq	$0x410, %rsp            # imm = 0x410
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jge	<addr>
               	leaq	-0x400(%rbp), %rsi
               	movslq	%eax, %rdi
               	movq	%rdi, %r8
               	shlq	$0x2, %r8
               	leaq	(%rsi,%r8), %rdx
               	movw	%cx, (%rdx)
               	movw	%cx, 0x2(%rdx)
               	incq	%rax
               	cmpl	$0x100, %eax            # imm = 0x100
               	jl	<addr>
               	leaq	-0x400(%rbp), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, 0x14(%rax)
               	movl	$0x10, %ecx
               	movw	%cx, 0x16(%rax)
               	addq	$0x14, %rax
               	movzwq	(%rax), %rcx
               	movzwq	0x2(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x1244, %eax           # imm = 0x1244
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	cmpl	$0xa, %eax
               	jge	<addr>
               	leaq	-0x78(%rbp), %r9
               	movslq	%eax, %rdx
               	imulq	$0xc, %rdx, %rsi
               	leaq	(%r9,%rsi), %rdi
               	leaq	(%rdi), %rbx
               	imulq	$0x64, %rdx, %rcx
               	leaq	(%rcx), %r8
               	movl	%r8d, (%rbx)
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, 0x4(%rdi)
               	leaq	-0x78(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	$0x2, %rcx
               	movl	%ecx, 0x8(%rsi)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	-0x20(%rbp), %r9
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%r9,%rsi), %rdi
               	leaq	(%rdi), %r12
               	leaq	0x41(%rcx), %rdx
               	leaq	(%rdx), %r8
               	movq	%r8, %rbx
               	movb	%bl, (%r12)
               	incq	%rdx
               	movq	%rdx, %r8
               	movb	%r8b, 0x1(%rdi)
               	leaq	-0x20(%rbp), %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	0x41(%rcx), %rdx
               	leaq	0x2(%rdx), %rsi
               	movq	%rsi, %r9
               	movb	%r9b, 0x2(%r8)
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	leaq	0x3(%rdx), %rcx
               	movq	%rcx, %rdx
               	movb	%dl, 0x3(%rsi)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq


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
               	jmp	<addr>
               	leaq	-0x400(%rbp), %rdi
               	movslq	%eax, %rdx
               	movq	%rdx, %r8
               	shlq	$0x2, %r8
               	leaq	(%rdi,%r8), %rsi
               	movw	%cx, (%rsi)
               	movw	%cx, 0x2(%rsi)
               	leaq	0x1(%rdx), %rax
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x78(%rbp), %r9
               	movslq	%ecx, %rdx
               	imulq	$0xc, %rdx, %rsi
               	leaq	(%r9,%rsi), %rdi
               	leaq	(%rdi), %rbx
               	imulq	$0x64, %rdx, %rax
               	leaq	(%rax), %r8
               	movl	%r8d, (%rbx)
               	leaq	0x1(%rax), %r8
               	movl	%r8d, 0x4(%rdi)
               	leaq	-0x78(%rbp), %rdi
               	addq	%rdi, %rsi
               	addq	$0x2, %rax
               	movl	%eax, 0x8(%rsi)
               	leaq	0x1(%rdx), %rcx
               	cmpl	$0xa, %ecx
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
               	jmp	<addr>
               	leaq	-0x20(%rbp), %r9
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%r9,%rsi), %rdi
               	leaq	(%rdi), %r12
               	leaq	0x41(%rcx), %rdx
               	leaq	(%rdx), %r8
               	movslq	%r8d, %rbx
               	movb	%bl, (%r12)
               	incq	%rdx
               	movslq	%edx, %r8
               	movb	%r8b, 0x1(%rdi)
               	leaq	-0x20(%rbp), %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	0x41(%rcx), %rdx
               	leaq	0x2(%rdx), %rsi
               	movslq	%esi, %r9
               	movb	%r9b, 0x2(%r8)
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rdi, %rsi
               	addq	$0x3, %rdx
               	movslq	%edx, %rdi
               	movb	%dil, 0x3(%rsi)
               	leaq	0x1(%rcx), %rax
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

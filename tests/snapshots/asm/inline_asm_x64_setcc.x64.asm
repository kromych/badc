
inline_asm_x64_setcc.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x5, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	sete	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x14, %rax, %rax
               	leaq	(%rax), %rdx
               	movl	$0x3, %esi
               	movl	$0x7, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, -0x30(%rbp)
               	movq	%rsi, -0x28(%rbp)
               	movq	%rax, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setl	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0xf, %rax, %rax
               	leaq	(%rdx,%rax), %rdi
               	movl	$0x9, %edx
               	movl	$0x4, %r8d
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%r8, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setg	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x7, %rax, %rax
               	addq	%rax, %rdi
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	leaq	-0x8(%rbp), %r9
               	movq	%r9, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	movq	%rcx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	sete	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %rdi
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%rdx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setl	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x64, %rax, %rax
               	leaq	(%rdi,%rax), %rsi
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	%r8, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rbx
               	setg	%al
               	movq	-0x30(%rbp), %r10
               	movb	%al, (%r10)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq

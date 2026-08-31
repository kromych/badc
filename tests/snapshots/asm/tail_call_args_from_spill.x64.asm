
tail_call_args_from_spill.x64:	file format elf64-x86-64

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

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movslq	%edi, %rdi
               	leaq	0x1(%rdi), %rcx
               	leaq	0x2(%rdi), %rdx
               	leaq	0x3(%rdi), %rsi
               	leaq	0x4(%rdi), %r8
               	leaq	0x5(%rdi), %r9
               	leaq	0x6(%rdi), %rbx
               	leaq	0x7(%rdi), %r12
               	leaq	0x8(%rdi), %r13
               	leaq	0x9(%rdi), %rax
               	leaq	0xa(%rdi), %r14
               	leaq	0xb(%rdi), %r15
               	leaq	0xc(%rdi), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	0xd(%rdi), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	0xe(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0xf(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	addq	%rdi, %rcx
               	addq	%rsi, %rcx
               	addq	%r8, %rcx
               	addq	%rbx, %rcx
               	addq	%r12, %rcx
               	addq	%r13, %rcx
               	addq	%rax, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	0x78(%rsp), %rcx
               	addq	0x68(%rsp), %rcx
               	addq	0x60(%rsp), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rcx
               	shlq	%rcx
               	addq	%rdx, %rcx
               	leaq	(%rax,%rax,2), %rax
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpl	$0xbf, %ebx
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

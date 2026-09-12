
slot_coalesce_declared.x64:	file format elf64-x86-64

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

<build>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, -0x70(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	leaq	(%rax,%rbx), %rcx
               	leaq	0x1(%rcx), %rax
               	leaq	0x2(%rcx), %rdx
               	leaq	0x3(%rcx), %rsi
               	leaq	0x4(%rcx), %rdi
               	leaq	0x5(%rcx), %r8
               	leaq	0x6(%rcx), %r9
               	leaq	0x7(%rcx), %rbx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	leaq	(%rax,%rbx), %rdx
               	leaq	0x1(%rdx), %rax
               	leaq	0x2(%rdx), %rsi
               	leaq	0x3(%rdx), %rdi
               	leaq	0x4(%rdx), %r8
               	leaq	0x5(%rdx), %r9
               	leaq	0x6(%rdx), %rbx
               	leaq	0x7(%rdx), %r12
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	leaq	(%rax,%r12), %rdi
               	movq	-0x70(%rbp), %r8
               	leaq	-0x40(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	%rsi, 0x20(%rax)
               	movq	%rsi, 0x28(%rax)
               	movq	%rsi, 0x30(%rax)
               	movq	%rsi, 0x38(%rax)
               	movq	-0x60(%rbp), %rsi
               	movq	%rsi, (%rax)
               	movq	-0x60(%rbp), %rsi
               	incq	%rsi
               	movq	%rsi, 0x8(%rax)
               	movq	-0x60(%rbp), %rax
               	leaq	0x2(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	%rsi, 0x10(%rax)
               	movq	-0x60(%rbp), %rsi
               	addq	$0x3, %rsi
               	movq	%rsi, 0x18(%rax)
               	movq	-0x60(%rbp), %rsi
               	addq	$0x4, %rsi
               	movq	%rsi, 0x20(%rax)
               	movq	-0x60(%rbp), %rax
               	leaq	0x5(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	%rsi, 0x28(%rax)
               	movq	-0x60(%rbp), %rsi
               	addq	$0x6, %rsi
               	movq	%rsi, 0x30(%rax)
               	movq	-0x60(%rbp), %rsi
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	addq	%rsi, %rcx
               	movq	%rdx, %r10
               	subq	%r10, %rdx
               	addq	%rdx, %rcx
               	movq	%rdi, %rdx
               	subq	%rdi, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x40(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%r8)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%r8)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%r8)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%r8)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%r8)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%r8)
               	popq	%rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%r8, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rdx
               	leaq	0x7(%rdx), %rsi
               	addq	%rsi, %rcx
               	leaq	(%rax,%rax), %rsi
               	addq	%rax, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	addq	%rcx, %rdx
               	leaq	(%rax,%rax,8), %rcx
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpq	$0x32, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rsi
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpq	$0x32, %rax
               	jl	<addr>
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	movq	%rax, -0x68(%rbp)
               	leaq	-0x68(%rbp), %rax
               	movq	(%rax), %rdx
               	xorq	$0xfeed, %rdx           # imm = 0xFEED
               	movq	%rdx, (%rax)
               	movslq	%ecx, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x68(%rbp), %rax
               	cmpq	$0x12345520, %rax       # imm = 0x12345520
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	movq	0x18(%rax), %rdi
               	movq	0x20(%rax), %r8
               	movq	0x28(%rax), %r9
               	movq	0x30(%rax), %r12
               	movq	0x38(%rax), %r13
               	movslq	%ebx, %rbx
               	xorq	%rax, %rax
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	(%rcx,%rdx), %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	cmpq	$0x65, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rcx
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>

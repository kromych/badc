
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
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
               	addq	%rbx, %rax
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	addq	%rax, %rcx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%r9, %rcx
               	addq	%rbx, %rcx
               	leaq	0x1(%rcx), %rdx
               	leaq	0x2(%rcx), %rsi
               	leaq	0x3(%rcx), %rdi
               	leaq	0x4(%rcx), %r8
               	leaq	0x5(%rcx), %r9
               	leaq	0x6(%rcx), %rbx
               	leaq	0x7(%rcx), %r12
               	addq	%rcx, %rdx
               	addq	%rsi, %rdx
               	addq	%rdi, %rdx
               	addq	%r8, %rdx
               	addq	%r9, %rdx
               	addq	%rbx, %rdx
               	leaq	(%rdx,%r12), %rsi
               	movq	-0x20(%rbp), %rdx
               	movq	-0x10(%rbp), %rdi
               	movq	-0x10(%rbp), %r8
               	incq	%r8
               	movq	-0x10(%rbp), %r9
               	addq	$0x2, %r9
               	movq	-0x10(%rbp), %rbx
               	addq	$0x3, %rbx
               	movq	-0x10(%rbp), %r12
               	addq	$0x4, %r12
               	movq	-0x10(%rbp), %r13
               	addq	$0x5, %r13
               	movq	-0x10(%rbp), %r14
               	addq	$0x6, %r14
               	movq	-0x10(%rbp), %r15
               	movq	%rax, %r10
               	subq	%r10, %rax
               	addq	%r15, %rax
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	addq	%rcx, %rax
               	movq	%rsi, %rcx
               	subq	%rsi, %rcx
               	addq	%rcx, %rax
               	movq	%rdi, (%rdx)
               	movq	%r8, 0x8(%rdx)
               	movq	%r9, 0x10(%rdx)
               	movq	%rbx, 0x18(%rdx)
               	movq	%r12, 0x20(%rdx)
               	movq	%r13, 0x28(%rdx)
               	movq	%r14, 0x30(%rdx)
               	movq	%rax, 0x38(%rdx)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	movq	%rdx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
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
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rdx
               	xorq	$0xfeed, %rdx           # imm = 0xFEED
               	movq	%rdx, (%rax)
               	movslq	%ecx, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x12345520, %rax       # imm = 0x12345520
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
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
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>

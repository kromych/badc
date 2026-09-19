
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, -0x20(%rbp)
               	movl	$0xa, %ecx
               	movq	-0x20(%rbp), %rax
               	movl	$0xb, %edx
               	movl	$0xc, %esi
               	movl	$0xd, %edi
               	movl	$0xe, %r8d
               	movl	$0xf, %r9d
               	movl	$0x10, %ebx
               	movl	$0xa, %r12d
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	%r8, 0x20(%rax)
               	movq	%r9, 0x28(%rax)
               	movq	%rbx, 0x30(%rax)
               	movq	%r12, 0x38(%rax)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpq	$0x32, %rax
               	jge	<addr>
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
               	cmpq	$0x32, %rax
               	jge	<addr>
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
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>


unroll_const_trip_index_literal.x64:	file format elf64-x86-64

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

<bank_init>:
               	movl	$0x1, (%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movl	$0x0, 0x4(%rdi)
               	movq	$0x0, 0x28(%rdi)
               	movl	$0x1, 0x30(%rdi)
               	leaq	0x30(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x1, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0x60(%rdi)
               	leaq	0x60(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x2, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0x90(%rdi)
               	leaq	0x90(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x3, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0xc0(%rdi)
               	leaq	0xc0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x4, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0xf0(%rdi)
               	leaq	0xf0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x5, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0x120(%rdi)
               	leaq	0x120(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x6, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0x150(%rdi)
               	leaq	0x150(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x7, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	leaq	0x180(%rdi), %rax
               	movl	$0x2, (%rax)
               	movq	%rsi, 0x20(%rax)
               	movl	$0x20, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0xb00, 0x10(%rax)      # imm = 0xB00
               	movl	$0x2, 0x30(%rax)
               	addq	$0x30, %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x180(%rdi), %rcx
               	leaq	0x30(%rcx), %rax
               	movl	$0x21, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0x1600, 0x10(%rax)     # imm = 0x1600
               	movl	$0x2, 0x60(%rcx)
               	leaq	0x180(%rdi), %rcx
               	leaq	0x60(%rcx), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x22, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0x2100, 0x10(%rax)     # imm = 0x2100
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rbx, %rax
               	leaq	<rip>, %rsi
               	imulq	$0x30, %rax, %rdx
               	leaq	(%rsi,%rdx), %rcx
               	movl	(%rcx), %edi
               	xorq	$0x1, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movq	0x20(%rcx), %rdi
               	leaq	<rip>, %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	cmpq	$0x0, 0x28(%rcx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdi
               	leaq	0x180(%rdi), %r8
               	imulq	$0x30, %rax, %rcx
               	leaq	(%r8,%rcx), %rdx
               	movl	(%rdx), %esi
               	xorq	$0x2, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movq	0x20(%rdx), %rdx
               	leaq	<rip>, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	0x180(%rdi), %r8
               	leaq	(%r8,%rcx), %rdx
               	movl	0x4(%rdx), %r9d
               	leaq	0x20(%rax), %rsi
               	cmpl	%esi, %r9d
               	jne	<addr>
               	cmpq	$0x0, 0x28(%rdx)
               	jne	<addr>
               	leaq	<rip>, %rdx
               	leaq	0x180(%rdx), %rsi
               	addq	%rsi, %rcx
               	movq	0x10(%rcx), %rdi
               	leaq	<rip>, %rcx
               	movslq	(%rcx,%rax,4), %rcx
               	shlq	$0x8, %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	imulq	$0x30, %rax, %rcx
               	addq	%rsi, %rcx
               	movq	0x10(%rcx), %rcx
               	addq	%rcx, %rbx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x4200, %rbx           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx,%rax,4), %rdx
               	shlq	$0x8, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %eax
               	jl	<addr>
               	cmpq	%rbx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq

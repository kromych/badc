
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
               	leaq	0x30(%rdi), %rdx
               	movq	%rsi, 0x20(%rdx)
               	movl	$0x1, 0x4(%rdx)
               	movq	$0x0, 0x28(%rdx)
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
               	leaq	0xf0(%rdi), %rcx
               	movq	%rsi, 0x20(%rcx)
               	movl	$0x5, 0x4(%rcx)
               	movq	$0x0, 0x28(%rcx)
               	movl	$0x1, 0x120(%rdi)
               	leaq	0x120(%rdi), %rcx
               	movq	%rsi, 0x20(%rcx)
               	movl	$0x6, 0x4(%rcx)
               	movq	$0x0, 0x28(%rcx)
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
               	leaq	0x180(%rdi), %rdx
               	leaq	0x30(%rdx), %rax
               	movl	$0x21, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0x1600, 0x10(%rax)     # imm = 0x1600
               	movl	$0x2, 0x60(%rdx)
               	leaq	0x180(%rdi), %rax
               	addq	$0x60, %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x22, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0x2100, 0x10(%rax)     # imm = 0x2100
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rdi # <addr>
               	imulq	$0x30, %rax, %rsi
               	leaq	(%rdx,%rsi), %rcx
               	movl	(%rcx), %r8d
               	cmpl	$0x1, %r8d
               	jne	<addr>
               	movq	0x20(%rcx), %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	(%rdx,%rsi), %rcx
               	cmpq	$0x0, 0x28(%rcx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %r9 # <addr>
               	xorl	%ecx, %ecx
               	leaq	0x180(%rdx), %rdi
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdi
               	movl	(%rdi), %ebx
               	cmpl	$0x2, %ebx
               	jne	<addr>
               	movq	0x20(%rdi), %rdi
               	cmpq	%r9, %rdi
               	jne	<addr>
               	leaq	0x180(%rdx), %rdi
               	addq	%rsi, %rdi
               	movl	0x4(%rdi), %ebx
               	leaq	0x20(%rax), %r12
               	cmpl	%r12d, %ebx
               	jne	<addr>
               	cmpq	$0x0, 0x28(%rdi)
               	jne	<addr>
               	leaq	0x180(%rdx), %rdi
               	addq	%rdi, %rsi
               	movq	0x10(%rsi), %rsi
               	movslq	(%r8,%rax,4), %rbx
               	shlq	$0x8, %rbx
               	cmpq	%rbx, %rsi
               	jne	<addr>
               	imulq	$0x30, %rax, %rsi
               	addq	%rdi, %rsi
               	movq	0x10(%rsi), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x4200, %rcx           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movl	<rip>, %edi # <addr>
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	cmpl	%edi, %eax
               	jge	<addr>
               	movslq	(%rsi,%rax,4), %r8
               	shlq	$0x8, %r8
               	addq	%r8, %rdx
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

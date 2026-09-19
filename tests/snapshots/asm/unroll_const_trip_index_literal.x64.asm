
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
               	leaq	(%rdi), %rax
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movq	%rsi, 0x20(%rax)
               	xorl	%ecx, %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0x30(%rdi)
               	leaq	0x30(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0x60(%rdi)
               	leaq	0x60(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0x90(%rdi)
               	leaq	0x90(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x3, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0xc0(%rdi)
               	leaq	0xc0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x4, %r8d
               	movl	%r8d, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0xf0(%rdi)
               	leaq	0xf0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x5, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, 0x120(%rdi)
               	leaq	0x120(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x6, %edx
               	movl	%edx, 0x4(%rax)
               	xorl	%edx, %edx
               	movq	%rdx, 0x28(%rax)
               	movl	%ecx, 0x150(%rdi)
               	leaq	0x150(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rdx, 0x28(%rax)
               	leaq	0x180(%rdi), %rcx
               	leaq	(%rcx), %rax
               	movl	$0x2, %edx
               	movl	%edx, (%rax)
               	movq	%rsi, 0x20(%rax)
               	movl	$0x20, %edx
               	movl	%edx, 0x4(%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, 0x28(%rax)
               	leaq	0x180(%rdi), %rax
               	leaq	(%rax), %rcx
               	movl	$0xb00, %edx            # imm = 0xB00
               	movq	%rdx, 0x10(%rcx)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x30(%rax)
               	leaq	0x30(%rax), %rcx
               	movq	%rsi, 0x20(%rcx)
               	movl	$0x21, %edx
               	movl	%edx, 0x4(%rcx)
               	xorl	%edx, %edx
               	movq	%rdx, 0x28(%rcx)
               	movl	$0x1600, %r8d           # imm = 0x1600
               	movq	%r8, 0x10(%rcx)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x60(%rax)
               	leaq	0x180(%rdi), %rcx
               	leaq	0x60(%rcx), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x22, %esi
               	movl	%esi, 0x4(%rax)
               	movq	%rdx, 0x28(%rax)
               	movl	$0x2100, %ecx           # imm = 0x2100
               	movq	%rcx, 0x10(%rax)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r12d, %r12d
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r13
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%r12, %rax
               	cmpl	$0x8, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	imulq	$0x30, %rcx, %rsi
               	leaq	(%rbx,%rsi), %rdx
               	movl	(%rdx), %edi
               	xorq	$0x1, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movq	0x20(%rdx), %rdi
               	cmpq	%r13, %rdi
               	jne	<addr>
               	movl	0x4(%rdx), %edx
               	movl	%ecx, %edi
               	cmpl	%edi, %edx
               	jne	<addr>
               	leaq	(%rbx,%rsi), %rcx
               	movq	0x28(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	leaq	0x180(%rbx), %r8
               	movslq	%eax, %rcx
               	imulq	$0x30, %rcx, %rdx
               	leaq	(%r8,%rdx), %rsi
               	movl	(%rsi), %r9d
               	xorq	$0x2, %r9
               	testl	%r9d, %r9d
               	jne	<addr>
               	movq	0x20(%rsi), %rsi
               	cmpq	%r13, %rsi
               	jne	<addr>
               	leaq	0x180(%rbx), %rsi
               	addq	%rsi, %rdx
               	movl	0x4(%rdx), %r8d
               	leaq	0x20(%rcx), %rdx
               	movl	%edx, %edx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	imulq	$0x30, %rcx, %r8
               	leaq	(%rsi,%r8), %rdx
               	movq	0x28(%rdx), %r9
               	testq	%r9, %r9
               	jne	<addr>
               	movq	0x10(%rdx), %rdx
               	movslq	(%rdi,%rcx,4), %rsi
               	shlq	$0x8, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rcx, %rcx
               	addq	%rdx, %rcx
               	movq	0x10(%rcx), %rcx
               	addq	%rcx, %r12
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x4200, %r12           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movslq	(%rdi), %rsi
               	cmpl	%esi, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movslq	(%rdx,%rsi,4), %rsi
               	shlq	$0x8, %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	movslq	(%rdi), %rsi
               	cmpl	%esi, %eax
               	jl	<addr>
               	cmpq	%r12, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

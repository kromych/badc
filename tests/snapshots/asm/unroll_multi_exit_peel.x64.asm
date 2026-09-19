
unroll_multi_exit_peel.x64:	file format elf64-x86-64

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

<walk_peeled>:
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r8
               	imulq	%r8, %rax
               	imulq	%rdi, %rax
               	leaq	<rip>, %r8
               	movq	(%r8), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	0x8(%rdx), %rdx
               	movq	0x8(%rsi), %rsi
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	0x8(%r8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %r8
               	leaq	<rip>, %rsi
               	movq	0x10(%rsi), %r9
               	imulq	%r9, %r8
               	imulq	%rdi, %r8
               	addq	%r8, %rax
               	leaq	<rip>, %r8
               	movq	0x10(%r8), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	0x18(%rdx), %rdx
               	movq	0x18(%rsi), %rsi
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	0x18(%r8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<scan_peeled>:
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	imulq	$-0x1, %rax, %rax
               	subq	%rcx, %rax
               	decq	%rax
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	movq	(%rdx), %r8
               	imulq	%r8, %rax
               	leaq	<rip>, %r8
               	movq	(%r8), %r9
               	cmpq	%rdi, %r9
               	jge	<addr>
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	0x8(%rdx), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	0x8(%rsi), %rsi
               	movq	0x8(%rdx), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	0x8(%r8), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x10(%rsi), %r8
               	movq	0x10(%rdx), %r9
               	imulq	%r9, %r8
               	addq	%r8, %rax
               	leaq	<rip>, %r8
               	movq	0x10(%r8), %r9
               	cmpq	%rdi, %r9
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	0x18(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	0x18(%rsi), %rdx
               	leaq	<rip>, %rsi
               	movq	0x18(%rsi), %rsi
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	0x18(%r8), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x2, %edi
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	callq	<addr>
               	cmpq	$0x10e14, %rax          # imm = 0x10E14
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x870c, %rax           # imm = 0x870C
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	movq	$0xa, 0x8(%rax)
               	movq	$0x64, 0x10(%rax)
               	movq	$0x3e8, 0x18(%rax)      # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%rbx, 0x10(%rax)
               	movq	%rbx, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$-0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movq	$-0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %ebx
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	%rbx, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$-0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	$-0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %ebx
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	%rbx, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%rbx, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$-0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%rbx, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	$-0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	leaq	<rip>, %r8
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%rbx, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$-0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$-0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0xa, 0x8(%rcx)
               	movq	$0x64, 0x10(%rcx)
               	movq	$0x3e8, 0x18(%rcx)      # imm = 0x3E8
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$-0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0xa, 0x8(%rax)
               	movq	$0x64, 0x10(%rax)
               	movq	$0x3e8, 0x18(%rax)      # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0x1, 0x8(%rax)
               	movq	$-0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	movq	%rsi, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rdx
               	subq	%rcx, %rdx
               	leaq	-0x1(%rdx), %rcx
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x2, %ebx
               	jle	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq

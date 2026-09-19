
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
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	imulq	$-0x1, %rcx, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	retq
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rcx
               	movq	(%rdx), %r8
               	imulq	%r8, %rcx
               	leaq	<rip>, %r8
               	movq	(%r8), %r9
               	cmpq	%rdi, %r9
               	jge	<addr>
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %eax
               	movq	0x8(%rdx), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movq	0x8(%rsi), %rsi
               	movq	0x8(%rdx), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%r8), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x2, %eax
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x10(%rsi), %r8
               	movq	0x10(%rdx), %r9
               	imulq	%r9, %r8
               	addq	%r8, %rcx
               	leaq	<rip>, %r8
               	movq	0x10(%r8), %r9
               	cmpq	%rdi, %r9
               	jl	<addr>
               	movl	$0x3, %eax
               	movq	0x18(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	0x18(%rsi), %rsi
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%r8), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x2, %edi
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	%rdi, 0x8(%rax)
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
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
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
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
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
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
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
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %ebx
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	%rbx, 0x8(%rax)
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
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
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
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
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
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x3, %ebx
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	%rbx, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0xa, 0x8(%rax)
               	movq	$0x64, 0x10(%rax)
               	movq	$0x3e8, 0x18(%rax)      # imm = 0x3E8
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0x1, 0x8(%rax)
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
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
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
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
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	addq	%rsi, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	$-0x2, %rbx
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
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
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
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
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$-0x2, 0x8(%rax)
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
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
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
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
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

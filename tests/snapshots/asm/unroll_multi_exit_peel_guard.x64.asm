
unroll_multi_exit_peel_guard.x64:	file format elf64-x86-64

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

<tier_idx>:
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	testl	%eax, %eax
               	jg	<addr>
               	movslq	%eax, %rsi
               	movq	(%rdx,%rsi,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	testl	%eax, %eax
               	jle	<addr>
               	movq	%rcx, %r9
               	shlq	%r9
               	movl	$0x1, %ecx
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rsi
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	movslq	%eax, %rdi
               	movq	(%rsi,%rdi,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x1, %eax
               	jle	<addr>
               	leaq	(%rdx,%rdx,2), %rax
               	cmpq	%r9, %rax
               	jg	<addr>
               	leaq	-0x1(%rcx), %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x2, %ecx
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rsi
               	movq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jg	<addr>
               	movslq	%eax, %rdi
               	movq	(%rsi,%rdi,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x2, %eax
               	jle	<addr>
               	leaq	(%rdx,%rdx,2), %rax
               	cmpq	%r9, %rax
               	jle	<addr>
               	movl	$0x3, %ecx
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rsi
               	movq	%rcx, %rax
               	cmpl	$0x3, %eax
               	jg	<addr>
               	movslq	%eax, %rdi
               	movq	(%rsi,%rdi,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	leaq	(%rdx,%rdx,2), %rax
               	cmpq	%r9, %rax
               	jle	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<tier_span>:
               	movq	%rdi, %r8
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	jg	<addr>
               	movslq	%eax, %rsi
               	movq	(%rdx,%rsi,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movq	%rcx, %rax
               	imulq	%r8, %rax
               	retq

<walk>:
               	xorq	%rsi, %rsi
               	leaq	<rip>, %rcx
               	leaq	(%rcx), %rax
               	movq	(%rax), %rax
               	shlq	$0x0, %rax
               	imulq	%rdi, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rdx
               	leaq	(%rdx), %r9
               	movq	(%r9), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %esi
               	movq	0x8(%rcx), %r9
               	imulq	$0xa, %r9, %r9
               	imulq	%rdi, %r9
               	addq	%r9, %rax
               	movq	0x8(%rdx), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movl	$0x2, %esi
               	movq	0x10(%rcx), %r9
               	imulq	$0x64, %r9, %r9
               	imulq	%rdi, %r9
               	addq	%r9, %rax
               	movq	0x10(%rdx), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movl	$0x3, %esi
               	movq	0x18(%rcx), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	imulq	%rdi, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rdx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movl	$0x4, %esi
               	jmp	<addr>

<scan>:
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	leaq	(%rcx), %rdx
               	movq	(%rdx), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	imulq	$-0x1, %rax, %rax
               	decq	%rax
               	retq
               	movq	(%rdx), %rax
               	shlq	$0x0, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	retq
               	movq	0x8(%rcx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	0x8(%rcx), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movq	0x10(%rcx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	0x10(%rcx), %rdx
               	imulq	$0x64, %rdx, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movq	0x18(%rcx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	0x18(%rcx), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	%rdi, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %eax
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	leaq	<rip>, %rbx
               	movq	%rdi, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%rcx, 0x10(%rbx)
               	movq	%rdx, 0x18(%rbx)
               	leaq	<rip>, %r12
               	movq	%rdi, (%r12)
               	movq	%rdi, 0x8(%r12)
               	movq	%rdi, 0x10(%r12)
               	movq	%rdi, 0x18(%r12)
               	callq	<addr>
               	movq	%rax, %r13
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	shlq	$0x0, %rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	shlq	%rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x3, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	imulq	%r13, %rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movabsq	$-0x2, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r13, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r13, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x1, %edi
               	movl	$0x2, %eax
               	movabsq	$-0x1, %rcx
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movq	%rdi, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rdi, (%r12)
               	movq	%rdi, 0x8(%r12)
               	movq	%rcx, 0x10(%r12)
               	movq	%rdi, 0x18(%r12)
               	callq	<addr>
               	movq	%rax, %r13
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	shlq	$0x0, %rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	shlq	%rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x3, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	imulq	%r13, %rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movabsq	$-0x2, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r13, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r13, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	movabsq	$-0x2, %rcx
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movq	%rax, (%r12)
               	movq	%rax, 0x8(%r12)
               	movq	%rax, 0x10(%r12)
               	movq	%rax, 0x18(%r12)
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	shlq	%rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x1, %rcx
               	movl	$0x2, %eax
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movq	%rcx, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movq	%rax, 0x8(%r12)
               	movq	%rcx, 0x10(%r12)
               	movq	%rax, 0x18(%r12)
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	shlq	$0x3, %rcx
               	addq	%rcx, %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r12, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rdx, %r8
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %r8
               	leaq	<rip>, %rdi
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	imulq	%r8, %rdx
               	shlq	$0x0, %rdx
               	addq	%rdx, %rsi
               	movq	(%r12,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %edx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %edi
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	movq	%rax, (%rbx)
               	movq	%rdi, 0x8(%rbx)
               	movq	%rcx, 0x10(%rbx)
               	movq	%rdx, 0x18(%rbx)
               	movq	%rax, (%r12)
               	movq	%rax, 0x8(%r12)
               	movq	%rax, 0x10(%r12)
               	movq	%rax, 0x18(%r12)
               	callq	<addr>
               	cmpq	$0x21c6, %rax           # imm = 0x21C6
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	movabsq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	jg	<addr>
               	leaq	<rip>, %rdx
               	movslq	%eax, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movq	%rcx, %rax
               	shlq	%rax
               	cmpq	$0x8ae, %rax            # imm = 0x8AE
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	leave
               	retq
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>

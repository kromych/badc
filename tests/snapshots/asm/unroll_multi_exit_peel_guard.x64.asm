
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
               	xorq	%rcx, %rcx
               	movl	$0x1, %eax
               	leaq	<rip>, %rsi
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	movq	%rcx, %rdi
               	testl	%eax, %eax
               	jg	<addr>
               	movslq	%eax, %rdi
               	movq	(%rsi,%rdi,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rax
               	jmp	<addr>
               	movq	%rdx, %r9
               	shlq	%r9
               	movl	$0x1, %eax
               	xorq	%rdx, %rdx
               	movq	%rax, %rcx
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	cmpl	$0x1, %ecx
               	jg	<addr>
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rcx
               	jmp	<addr>
               	leaq	(%rdx,%rdx,2), %rcx
               	cmpq	%r9, %rcx
               	jg	<addr>
               	decq	%rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x2, %eax
               	xorq	%rdx, %rdx
               	movl	$0x1, %ecx
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	cmpl	$0x2, %ecx
               	jg	<addr>
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rcx
               	jmp	<addr>
               	leaq	(%rdx,%rdx,2), %rcx
               	cmpq	%r9, %rcx
               	jg	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	xorq	%rdx, %rdx
               	movl	$0x1, %ecx
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
               	movq	%rax, %rdi
               	cmpl	$0x3, %ecx
               	jg	<addr>
               	movslq	%ecx, %rdi
               	movq	(%rsi,%rdi,8), %rdi
               	addq	%rdi, %rdx
               	incq	%rcx
               	jmp	<addr>
               	leaq	(%rdx,%rdx,2), %rcx
               	cmpq	%r9, %rcx
               	jg	<addr>
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>

<tier_span>:
               	movq	%rdi, %r8
               	xorq	%rax, %rax
               	movl	$0x1, %ecx
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	movl	$0x3, %esi
               	cmpl	$0x3, %eax
               	jg	<addr>
               	movslq	%eax, %rsi
               	movq	(%rdx,%rsi,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	jmp	<addr>
               	movq	%rcx, %rax
               	imulq	%r8, %rax
               	retq

<walk>:
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	addq	$0x0, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rsi
               	shlq	$0x0, %rcx
               	imulq	%rdi, %rcx
               	addq	$0x0, %rcx
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %eax
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	movq	%rax, %r8
               	movl	$0xa, %esi
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x2, %eax
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	movq	%rax, %r8
               	movl	$0x64, %esi
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	movq	%rax, %r8
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>

<scan>:
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	addq	$0x0, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	imulq	$-0x1, %rax, %rax
               	decq	%rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	shlq	$0x0, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rcx
               	addq	$0x0, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	jmp	<addr>
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
               	movl	$0x1, %ecx
               	movq	%rax, %rcx
               	movl	$0x3, %edx
               	cmpl	$0x3, %eax
               	jg	<addr>
               	leaq	<rip>, %rdx
               	movslq	%eax, %rsi
               	movq	(%rdx,%rsi,8), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	jmp	<addr>
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
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rax
               	leaq	-0x1(%rax), %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

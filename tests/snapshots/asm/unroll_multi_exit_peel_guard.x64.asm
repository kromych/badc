
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
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	testl	%eax, %eax
               	jg	<addr>
               	incq	%rcx
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jle	<addr>
               	movq	%rcx, %rdi
               	shlq	%rdi
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	jg	<addr>
               	addq	$0xa, %rdx
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	jle	<addr>
               	leaq	(%rdx,%rdx,2), %rax
               	cmpq	%rdi, %rax
               	jg	<addr>
               	leaq	-0x1(%rcx), %rax
               	retq
               	movl	$0x2, %ecx
               	xorl	%edx, %edx
               	movq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jg	<addr>
               	addq	$0x64, %rdx
               	movl	$0x3, %eax
               	cmpl	$0x2, %eax
               	jle	<addr>
               	leaq	(%rdx,%rdx,2), %rax
               	cmpq	%rdi, %rax
               	jle	<addr>
               	movl	$0x3, %ecx
               	xorl	%edx, %edx
               	movq	%rcx, %rax
               	cmpl	$0x3, %eax
               	jg	<addr>
               	addq	$0x3e8, %rdx            # imm = 0x3E8
               	movl	$0x4, %eax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	leaq	(%rdx,%rdx,2), %rax
               	cmpq	%rdi, %rax
               	jle	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<tier_span>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	jg	<addr>
               	movq	(%rdx,%rax,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movq	%rcx, %rax
               	imulq	%rdi, %rax
               	retq

<walk>:
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	leaq	(%rdx), %rax
               	movq	(%rax), %rax
               	shlq	$0x0, %rax
               	imulq	%rdi, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rsi
               	leaq	(%rsi), %r9
               	movq	(%r9), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	0x8(%rdx), %r9
               	imulq	$0xa, %r9, %r9
               	imulq	%rdi, %r9
               	addq	%r9, %rax
               	movq	0x8(%rsi), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	0x10(%rdx), %r9
               	imulq	$0x64, %r9, %r9
               	imulq	%rdi, %r9
               	addq	%r9, %rax
               	movq	0x10(%rsi), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	0x18(%rdx), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	0x18(%rsi), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<scan>:
               	xorl	%eax, %eax
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %edi
               	leaq	<rip>, %rbx
               	movq	%rdi, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	leaq	<rip>, %r12
               	movq	%rdi, (%r12)
               	movq	%rdi, 0x8(%r12)
               	movq	%rdi, 0x10(%r12)
               	movq	%rdi, 0x18(%r12)
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	$0x0, %rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movl	$0x3, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	imulq	%r13, %rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	$-0x2, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x1, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	movq	%rdi, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	%rdi, (%r12)
               	movq	%rdi, 0x8(%r12)
               	movq	$-0x1, 0x10(%r12)
               	movq	%rdi, 0x18(%r12)
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	$0x0, %rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movl	$0x3, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	imulq	%r13, %rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movq	$-0x2, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x1, %r13
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	movq	$0x1, (%rbx)
               	movq	$-0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0x1, 0x8(%r12)
               	movq	$0x1, 0x10(%r12)
               	movq	$0x1, 0x18(%r12)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0x1, 0x8(%r12)
               	movq	$-0x1, 0x10(%r12)
               	movq	$0x1, 0x18(%r12)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, %rcx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	$0x0, %rcx
               	addq	%rcx, %rdx
               	movq	(%r12,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	addq	%rdx, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	$0x1, (%rbx)
               	movq	%rdi, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0x1, 0x8(%r12)
               	movq	$0x1, 0x10(%r12)
               	movq	$0x1, 0x18(%r12)
               	callq	<addr>
               	cmpq	$0x21c6, %rax           # imm = 0x21C6
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x3, %eax
               	jg	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx,%rax,8), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	movq	%rcx, %rax
               	shlq	%rax
               	cmpq	$0x8ae, %rax            # imm = 0x8AE
               	je	<addr>
               	movl	$0xc, %eax
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

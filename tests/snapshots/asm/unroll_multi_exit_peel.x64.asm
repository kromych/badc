
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %r8
               	xorl	%edi, %edi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	imulq	%rsi, %rax
               	imulq	%r8, %rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	shlq	$0x3, %rax
               	addq	%rdi, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	movq	0x8(%rcx), %r9
               	movq	0x8(%rdx), %rbx
               	imulq	%rbx, %r9
               	imulq	%r8, %r9
               	addq	%r9, %rax
               	movq	0x8(%rsi), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movl	$0x2, %edi
               	movq	0x10(%rcx), %r9
               	movq	0x10(%rdx), %rbx
               	imulq	%rbx, %r9
               	imulq	%r8, %r9
               	addq	%r9, %rax
               	movq	0x10(%rsi), %r9
               	testq	%r9, %r9
               	jl	<addr>
               	movl	$0x3, %edi
               	movq	0x18(%rcx), %rcx
               	movq	0x18(%rdx), %rdx
               	imulq	%rdx, %rcx
               	imulq	%r8, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rsi), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movl	$0x4, %edi
               	jmp	<addr>

<scan_peeled>:
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	%rcx, %rdx
               	imulq	$-0x1, %rdx, %rax
               	subq	%rcx, %rax
               	decq	%rax
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	(%rax), %rsi
               	imulq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	movq	%rdx, %rax
               	shlq	$0x3, %rax
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	0x8(%rax), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x8(%rsi), %rsi
               	movq	0x8(%rax), %r8
               	imulq	%r8, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	0x8(%rsi), %rsi
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	0x10(%rax), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x10(%rsi), %rsi
               	movq	0x10(%rax), %r8
               	imulq	%r8, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	0x10(%rsi), %rsi
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	0x18(%rax), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x18(%rsi), %rsi
               	movq	0x18(%rax), %rax
               	imulq	%rsi, %rax
               	addq	%rax, %rdx
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	cmpq	%rdi, %rax
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x2, %edi
               	leaq	<rip>, %rbx
               	movq	$0x1, (%rbx)
               	movq	%rdi, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	leaq	<rip>, %r12
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	leaq	<rip>, %r13
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	callq	<addr>
               	cmpq	$0x10e14, %rax          # imm = 0x10E14
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x870c, %rax           # imm = 0x870C
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	movq	%r14, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	%r14, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	$0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$-0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	$-0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x2, %r14d
               	movq	$0x1, (%rbx)
               	movq	%r14, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	movq	$0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$-0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	movq	$-0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	movl	$0x3, %r14d
               	movq	$0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	%r14, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	imulq	%r14, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	movq	$0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$-0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	imulq	%r14, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	movq	$-0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	imulq	%r14, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
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
               	movq	$-0x2, %r14
               	cmpl	$0x2, %r14d
               	jg	<addr>
               	movq	$0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%r12,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r14, %rcx
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
               	movq	$0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$-0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%r12,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r14, %rcx
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
               	movq	$0x1, (%rbx)
               	movq	$-0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%r12,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r14, %rcx
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
               	movq	$-0x1, (%rbx)
               	movq	$0x2, 0x8(%rbx)
               	movq	$0x3, 0x10(%rbx)
               	movq	$0x4, 0x18(%rbx)
               	movq	$0x1, (%r12)
               	movq	$0xa, 0x8(%r12)
               	movq	$0x64, 0x10(%r12)
               	movq	$0x3e8, 0x18(%r12)      # imm = 0x3E8
               	movq	$0x1, (%r13)
               	movq	$0x1, 0x8(%r13)
               	movq	$-0x1, 0x10(%r13)
               	movq	$0x1, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rbx,%rax,8), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%r12,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%r14, %rcx
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
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	subq	%rax, %rcx
               	leaq	-0x1(%rcx), %rax
               	jmp	<addr>
               	incq	%r14
               	cmpl	$0x2, %r14d
               	jle	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

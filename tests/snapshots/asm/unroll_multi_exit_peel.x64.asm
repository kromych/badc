
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
               	leaq	(%rcx), %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	leaq	(%rdx), %rsi
               	movq	(%rsi), %rsi
               	imulq	%rsi, %rax
               	imulq	%r8, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rsi
               	leaq	(%rsi), %r9
               	movq	(%r9), %r9
               	testq	%r9, %r9
               	jge	<addr>
               	shlq	$0x3, %rax
               	movslq	%edi, %rcx
               	addq	%rcx, %rax
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
               	xorl	%edx, %edx
               	leaq	<rip>, %rax
               	leaq	(%rax), %rcx
               	movq	(%rcx), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	movq	%rdx, %rcx
               	imulq	$-0x1, %rcx, %rax
               	movslq	%edx, %rcx
               	subq	%rcx, %rax
               	decq	%rax
               	retq
               	leaq	<rip>, %rsi
               	addq	$0x0, %rsi
               	movq	(%rsi), %rsi
               	movq	(%rcx), %rcx
               	imulq	%rsi, %rcx
               	addq	$0x0, %rcx
               	leaq	<rip>, %rsi
               	addq	$0x0, %rsi
               	movq	(%rsi), %rsi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	movslq	%edx, %rcx
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %edx
               	movq	0x8(%rax), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x8(%rsi), %rsi
               	movq	0x8(%rax), %r8
               	imulq	%r8, %rsi
               	addq	%rsi, %rcx
               	leaq	<rip>, %rsi
               	movq	0x8(%rsi), %rsi
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	movl	$0x2, %edx
               	movq	0x10(%rax), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x10(%rsi), %rsi
               	movq	0x10(%rax), %r8
               	imulq	%r8, %rsi
               	addq	%rsi, %rcx
               	leaq	<rip>, %rsi
               	movq	0x10(%rsi), %rsi
               	cmpq	%rdi, %rsi
               	jl	<addr>
               	movl	$0x3, %edx
               	movq	0x18(%rax), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	leaq	<rip>, %rsi
               	movq	0x18(%rsi), %rsi
               	movq	0x18(%rax), %rax
               	imulq	%rsi, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	cmpq	%rdi, %rax
               	jl	<addr>
               	movl	$0x4, %edx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %eax
               	movl	$0x2, %edi
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	leaq	<rip>, %rbx
               	movq	%rax, (%rbx)
               	movq	%rdi, 0x8(%rbx)
               	movq	%rcx, 0x10(%rbx)
               	movq	%rdx, 0x18(%rbx)
               	leaq	<rip>, %r12
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	leaq	<rip>, %r13
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rax, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
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
               	movl	$0x2, %eax
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	movq	%r14, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%rcx, 0x10(%rbx)
               	movq	%rdx, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%r14, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	$0x0, %rsi
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
               	movslq	%eax, %rax
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
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movq	$-0x1, %rdx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rsi, 0x10(%rbx)
               	movq	%rdi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rdx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	$0x0, %rsi
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
               	movslq	%eax, %rax
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
               	movq	$-0x1, %rax
               	movl	$0x2, %ecx
               	movl	$0x1, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rsi, 0x10(%rbx)
               	movq	%rdi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rdx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rsi
               	movq	(%rsi), %rsi
               	leaq	(%r12,%rcx), %rdi
               	movq	(%rdi), %rdi
               	imulq	%rdi, %rsi
               	shlq	$0x0, %rsi
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
               	movslq	%eax, %rax
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
               	movl	$0x1, %ecx
               	movl	$0x3, %eax
               	movl	$0x4, %edx
               	movq	%rcx, (%rbx)
               	movq	%r14, 0x8(%rbx)
               	movq	%rax, 0x10(%rbx)
               	movq	%rdx, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %edx
               	movq	%rdx, 0x8(%r12)
               	movl	$0x64, %edx
               	movq	%rdx, 0x10(%r12)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movq	%rdx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rcx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movq	$-0x1, %rdx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rsi, 0x10(%rbx)
               	movq	%rdi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rdx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	$-0x1, %rax
               	movl	$0x2, %ecx
               	movl	$0x1, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rsi, 0x10(%rbx)
               	movq	%rdi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rdx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x3, %r14d
               	movl	$0x1, %ecx
               	movl	$0x2, %eax
               	movl	$0x4, %edx
               	movq	%rcx, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%r14, 0x10(%rbx)
               	movq	%rdx, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %edx
               	movq	%rdx, 0x8(%r12)
               	movl	$0x64, %edx
               	movq	%rdx, 0x10(%r12)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movq	%rdx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rcx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movq	$-0x1, %rdx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rsi, 0x10(%rbx)
               	movq	%rdi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rdx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	$-0x1, %rax
               	movl	$0x2, %ecx
               	movl	$0x1, %edx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rsi, 0x10(%rbx)
               	movq	%rdi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rdx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	$-0x2, %r14
               	cmpq	$0x2, %r14
               	jg	<addr>
               	movl	$0x1, %ecx
               	movl	$0x2, %eax
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movq	%rcx, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %edx
               	movq	%rdx, 0x8(%r12)
               	movl	$0x64, %edx
               	movq	%rdx, 0x10(%r12)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movq	%rdx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rcx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movq	$-0x1, %rdx
               	movl	$0x3, %esi
               	movl	$0x4, %edi
               	movq	%rax, (%rbx)
               	movq	%rcx, 0x8(%rbx)
               	movq	%rsi, 0x10(%rbx)
               	movq	%rdi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x8(%r12)
               	movl	$0x64, %ecx
               	movq	%rcx, 0x10(%r12)
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movq	%rcx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rdx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movl	$0x1, %ecx
               	movq	$-0x2, %rax
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movq	%rcx, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %edx
               	movq	%rdx, 0x8(%r12)
               	movl	$0x64, %edx
               	movq	%rdx, 0x10(%r12)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movq	%rdx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rcx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	movq	$-0x1, %rcx
               	movl	$0x2, %eax
               	movl	$0x3, %edx
               	movl	$0x4, %esi
               	movq	%rcx, (%rbx)
               	movq	%rax, 0x8(%rbx)
               	movq	%rdx, 0x10(%rbx)
               	movq	%rsi, 0x18(%rbx)
               	movl	$0x1, %eax
               	movq	%rax, (%r12)
               	movl	$0xa, %edx
               	movq	%rdx, 0x8(%r12)
               	movl	$0x64, %edx
               	movq	%rdx, 0x10(%r12)
               	movl	$0x3e8, %edx            # imm = 0x3E8
               	movq	%rdx, 0x18(%r12)
               	movq	%rax, (%r13)
               	movq	%rax, 0x8(%r13)
               	movq	%rcx, 0x10(%r13)
               	movq	%rax, 0x18(%r13)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	(%rbx,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
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
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r8
               	je	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	jmp	<addr>
               	incq	%r14
               	cmpq	$0x2, %r14
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

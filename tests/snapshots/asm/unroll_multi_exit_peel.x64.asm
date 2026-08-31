
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
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	imulq	%rdx, %rax
               	imulq	%rdi, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	imulq	%rsi, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<scan_peeled>:
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	imulq	$-0x1, %rax, %rax
               	movslq	%ecx, %rcx
               	subq	%rcx, %rax
               	decq	%rax
               	retq
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	imulq	%rdx, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rdx
               	addq	$0x0, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	shlq	$0x3, %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x8(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %ecx
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x870c, %rax           # imm = 0x870C
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	$0x0, %rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movabsq	$-0x1, %rdx
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	$0x0, %rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	$0x0, %rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movabsq	$-0x1, %rdx
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movabsq	$-0x1, %rax
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	shlq	%rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%r14, %rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movabsq	$-0x1, %rdx
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%r14, %rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movabsq	$-0x1, %rax
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
               	movq	%rax, %r9
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rbx,%rcx), %rdi
               	movq	(%rdi), %rdi
               	leaq	(%r12,%rcx), %r8
               	movq	(%r8), %r8
               	imulq	%r8, %rdi
               	imulq	%r14, %rdi
               	addq	%rdi, %rdx
               	addq	%r13, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	%rax, %r9
               	jne	<addr>
               	movabsq	$-0x2, %r14
               	jmp	<addr>
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
               	xorq	%rax, %rax
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
               	movslq	%eax, %rax
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
               	movabsq	$-0x1, %rdx
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
               	xorq	%rax, %rax
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
               	movslq	%eax, %rax
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
               	movabsq	$-0x2, %rax
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
               	xorq	%rax, %rax
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
               	movslq	%eax, %rax
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
               	xorq	%rax, %rax
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
               	movslq	%eax, %rax
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
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	jmp	<addr>
               	jmp	<addr>
               	imulq	$-0x1, %rdx, %rcx
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	decq	%rax
               	jmp	<addr>
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
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

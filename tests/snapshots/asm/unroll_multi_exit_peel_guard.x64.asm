
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
               	movl	$0x3, %eax
               	retq

<tier_span>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
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
               	movq	<rip>, %rax # <addr>
               	imulq	%rdi, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jge	<addr>
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	<rip>, %rdx # <addr>
               	imulq	$0xa, %rdx, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	<rip>, %rdx # <addr>
               	imulq	$0x64, %rdx, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	movq	<rip>, %rdx # <addr>
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<scan>:
               	xorl	%ecx, %ecx
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	xorq	$-0x1, %rax
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	retq
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	imulq	$0xa, %rcx, %rcx
               	addq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jl	<addr>
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jl	<addr>
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1, %edi
               	movq	%rdi, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rsi,%rbx,8), %rbx
               	imulq	%rax, %rbx
               	addq	%rbx, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rsi,%rbx,8), %rbx
               	imulq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, 0x50(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	0x50(%rsp), %rsi
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rbx
               	movl	$0x3, %r12d
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %r12
               	movq	(%rdi,%r12,8), %r12
               	imulq	%r12, %rbx
               	imulq	%rsi, %rbx
               	addq	%rbx, %rdx
               	movq	(%r9,%rcx,8), %rbx
               	testq	%rbx, %rbx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	movq	%rax, %r10
               	movq	0x58(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	$-0x2, %r8
               	movq	%r8, 0x48(%rsp)
               	movq	%r8, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	0x48(%rsp), %r8
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x58(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	0x58(%rsp), %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r9,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%rax, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r8, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	0x58(%rsp), %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x1, %r8
               	movq	%r8, 0x40(%rsp)
               	movq	%r8, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	0x40(%rsp), %r8
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x58(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	0x58(%rsp), %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r9,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%rax, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r8, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	0x58(%rsp), %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x1, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rsi,%rbx,8), %rbx
               	imulq	%rax, %rbx
               	addq	%rbx, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rsi,%rbx,8), %rbx
               	imulq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x3, %esi
               	movq	%rsi, 0x38(%rsp)
               	movq	%rsi, %rdi
               	callq	<addr>
               	movq	%rax, 0x58(%rsp)
               	movq	0x38(%rsp), %rsi
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rbx
               	movl	$0x3, %r12d
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %r12
               	movq	(%rdi,%r12,8), %r12
               	imulq	%r12, %rbx
               	imulq	%rsi, %rbx
               	addq	%rbx, %rdx
               	movq	(%r9,%rcx,8), %rbx
               	testq	%rbx, %rbx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	movq	%rax, %r10
               	movq	0x58(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	$-0x2, %r8
               	movq	%r8, 0x30(%rsp)
               	movq	%r8, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	0x30(%rsp), %r8
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x58(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	0x58(%rsp), %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r9,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%rax, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r8, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	0x58(%rsp), %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x1, %r8
               	movq	%r8, 0x28(%rsp)
               	movq	%r8, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	0x28(%rsp), %r8
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x58(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	0x58(%rsp), %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r9,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%rax, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%r8, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	0x58(%rsp), %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x1, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rsi,%rbx,8), %rbx
               	imulq	%rax, %rbx
               	shlq	%rbx
               	addq	%rbx, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$-0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%r8,%rdx), %rbx
               	movq	(%rbx), %rbx
               	leaq	(%rdi,%rdx), %r12
               	movq	(%r12), %r12
               	imulq	%r12, %rbx
               	addq	%rbx, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r13
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rsi,%rbx,8), %rbx
               	imulq	%rax, %rbx
               	addq	%rbx, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movq	$0x1, <rip> # <addr>
               	movq	%rdi, <rip> # <addr>
               	movq	$0x3, <rip> # <addr>
               	movq	$0x4, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
               	movq	$0x1, <rip> # <addr>
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
               	leaq	<rip>, %rdx # <addr>
               	movq	%rax, %rcx
               	movq	(%rdx,%rax,8), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jle	<addr>
               	shlq	%rcx
               	cmpq	$0x8ae, %rcx            # imm = 0x8AE
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
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>
               	xorq	$-0x1, %rsi
               	jmp	<addr>

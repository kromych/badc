
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
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jge	<addr>
               	xorq	$-0x1, %rax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	retq
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
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
               	popq	%r14
               	popq	%rbp
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
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %r12d
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %r12
               	movq	(%rsi,%r12,8), %r12
               	imulq	%rax, %r12
               	imulq	%rbx, %r12
               	addq	%r12, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
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
               	leaq	(%r8,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%rdi,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r14
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
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
               	leaq	(%r8,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%rdi,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r14
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
               	popq	%r14
               	popq	%rbp
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
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movl	<rip>, %r9d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r9d, %ecx
               	jge	<addr>
               	movq	(%rdi,%rcx,8), %rax
               	movl	$0x3, %r12d
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %r12
               	movq	(%rsi,%r12,8), %r12
               	imulq	%rax, %r12
               	imulq	%rbx, %r12
               	addq	%r12, %rdx
               	movq	(%r8,%rcx,8), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r9d, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r14
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
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
               	leaq	(%r8,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%rdi,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r14
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
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
               	leaq	(%r8,%rdx), %r12
               	movq	(%r12), %r12
               	leaq	(%rdi,%rdx), %r13
               	movq	(%r13), %r13
               	imulq	%r13, %r12
               	addq	%r12, %rsi
               	addq	%r9, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	cmpq	%rsi, %r14
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
               	popq	%r14
               	popq	%rbp
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
               	popq	%r14
               	popq	%rbp
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
               	popq	%r14
               	popq	%rbp
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
               	popq	%r14
               	popq	%rbp
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
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
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
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
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

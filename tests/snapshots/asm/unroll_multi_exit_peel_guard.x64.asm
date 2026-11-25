
unroll_multi_exit_peel_guard.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	movq	%rcx, %rax
               	movq	(%rdx,%rcx,8), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x3, %ecx
               	jle	<addr>
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
               	cmpq	%rdi, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	imulq	$0xa, %rax, %rax
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rdi, %rcx
               	jge	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	jl	<addr>
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rax, %rcx
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdi, %rax
               	jmp	<addr>

<main>:
               	subq	$0x20, %rsp
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
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rsi
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rdi,%rbx,8), %rbx
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	movq	(%r9,%rcx,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rdx
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rdi,%rbx,8), %rbx
               	imulq	%rbx, %rdx
               	shlq	%rdx
               	addq	%rdx, %rsi
               	movq	(%r9,%rcx,8), %rdx
               	nopw	(%rax,%rax)
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rsi,%rcx), %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rdx
               	movl	$0x3, %r12d
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %r12
               	movq	(%rdi,%r12,8), %r12
               	imulq	%r12, %rdx
               	imulq	%rbx, %rdx
               	addq	%rdx, %rsi
               	movq	(%r9,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rsi,%rcx), %rax
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r12d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r12d, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	%rbx, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r12d, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r13
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r12d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r12d, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	%rbx, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r12d, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r13
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	$0x1, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	$0x2, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
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
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rsi
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rdi,%rbx,8), %rbx
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rsi
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rdi,%rbx,8), %rbx
               	imulq	%rbx, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, 0x28(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rsi
               	movl	$0x3, %r12d
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %r12
               	movq	(%rdi,%r12,8), %r12
               	imulq	%r12, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	movq	%rax, %r10
               	movq	0x28(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r12d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r12d, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	nop
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	nopl	(%rax,%rax)
               	cmpq	%rbx, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r12d, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r13
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %r12d # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%r12d, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	nopl	(%rax,%rax)
               	cmpq	%rbx, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%r12d, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r13
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	$0x1, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	cmpq	$0x2, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
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
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	nopl	(%rax)
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rsi
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rdi,%rbx,8), %rbx
               	imulq	%rbx, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
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
               	movq	%rax, %r12
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ebx # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%ebx, %ecx
               	jge	<addr>
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	(%r8,%rcx,8), %rdi
               	imulq	%rsi, %rdi
               	addq	%rdi, %rdx
               	movq	(%rax,%rcx,8), %rsi
               	nop
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	cmpl	%ebx, %ecx
               	jl	<addr>
               	cmpq	%rdx, %r12
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %r8 # <addr>
               	leaq	<rip>, %r9 # <addr>
               	movl	<rip>, %eax # <addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	cmpl	%eax, %ecx
               	jge	<addr>
               	movq	(%r8,%rcx,8), %rsi
               	movl	$0x3, %ebx
               	cmpl	$0x3, %ecx
               	cmovlq	%rcx, %rbx
               	movq	(%rdi,%rbx,8), %rbx
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	movq	(%r9,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	%eax, %ecx
               	jl	<addr>
               	leaq	(%rdx,%rcx), %rax
               	cmpq	%rax, %r13
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
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
               	addq	$0x20, %rsp
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
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
               	addq	$0x20, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x20, %rsp
               	retq
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>
               	xorq	$-0x1, %rdx
               	jmp	<addr>

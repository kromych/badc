
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
               	incq	%rcx
               	movl	$0x1, %eax
               	testl	%eax, %eax
               	jle	<addr>
               	movq	%rcx, %rsi
               	shlq	%rsi
               	movl	$0x1, %eax
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	addq	$0xa, %rcx
               	movl	$0x2, %edx
               	cmpl	$0x1, %edx
               	jle	<addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	cmpq	%rsi, %rcx
               	jg	<addr>
               	decq	%rax
               	retq
               	movl	$0x2, %eax
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	addq	$0x64, %rcx
               	movl	$0x3, %edx
               	cmpl	$0x2, %edx
               	jle	<addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	cmpq	%rsi, %rcx
               	jle	<addr>
               	movl	$0x3, %eax
               	xorl	%ecx, %ecx
               	movq	%rax, %rdx
               	addq	$0x3e8, %rcx            # imm = 0x3E8
               	movl	$0x4, %edx
               	cmpl	$0x3, %edx
               	jle	<addr>
               	leaq	(%rcx,%rcx,2), %rcx
               	cmpq	%rsi, %rcx
               	jle	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>

<tier_span>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
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
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	imulq	%rdi, %rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r8
               	testq	%r8, %r8
               	jge	<addr>
               	addq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	movq	0x8(%rdx), %r8
               	imulq	$0xa, %r8, %r8
               	imulq	%rdi, %r8
               	addq	%r8, %rax
               	movq	0x8(%rsi), %r8
               	testq	%r8, %r8
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	0x10(%rdx), %rdx
               	imulq	$0x64, %rdx, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	movq	0x10(%rsi), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x3, %ecx
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>

<scan>:
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	jge	<addr>
               	xorq	$-0x1, %rax
               	retq
               	movq	(%rcx), %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	cmpq	%rdi, %rsi
               	jge	<addr>
               	retq
               	movq	0x8(%rcx), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	0x8(%rcx), %rsi
               	imulq	$0xa, %rsi, %rsi
               	addq	%rsi, %rax
               	movq	0x8(%rdx), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movq	0x10(%rcx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	movq	0x10(%rcx), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdx
               	movq	0x18(%rdx), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movq	0x18(%rdx), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	addq	%rdx, %rax
               	movq	0x18(%rcx), %rcx
               	cmpq	%rdi, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1, %edi
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x1, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	$-0x1, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	imulq	%rbx, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rbx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x1, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	cmpq	$0x2, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$-0x2, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	shlq	%rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
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
               	movq	$0x1, 0x8(%rax)
               	movq	$-0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	xorl	%edi, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi,%rcx,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %r8
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %r8
               	movq	(%r8), %r8
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	imulq	%r8, %rdi
               	addq	%rdi, %rsi
               	leaq	<rip>, %rdi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	incq	%rcx
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	%edx, %ecx
               	jl	<addr>
               	cmpq	%rsi, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rdi
               	leaq	<rip>, %r8
               	cmpl	$0x3, %ecx
               	jge	<addr>
               	movq	%rcx, %rsi
               	movq	(%r8,%rsi,8), %rsi
               	imulq	%rdi, %rsi
               	addq	%rsi, %rdx
               	leaq	<rip>, %rsi
               	movq	(%rsi,%rcx,8), %rsi
               	testq	%rsi, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movl	$0x3, %esi
               	jmp	<addr>
               	incq	%rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %ecx
               	jl	<addr>
               	addq	%rdx, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movq	$0x3, 0x10(%rcx)
               	movq	$0x4, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	movq	$0x1, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	movq	$0x1, 0x10(%rcx)
               	movq	$0x1, 0x18(%rcx)
               	callq	<addr>
               	cmpq	$0x21c6, %rax           # imm = 0x21C6
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x2, %rdi
               	callq	<addr>
               	cmpq	$0x10e1, %rax           # imm = 0x10E1
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rcx
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
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
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

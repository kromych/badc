
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
               	movq	%rcx, %rdi
               	shlq	%rdi
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	movq	%rcx, %rax
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
               	movq	0x8(%rsi), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x2, %ecx
               	movq	0x10(%rdx), %rdx
               	imulq	$0x64, %rdx, %rdx
               	imulq	%rdi, %rdx
               	addq	%rdx, %rax
               	leaq	<rip>, %rdx
               	movq	0x10(%rdx), %rsi
               	testq	%rsi, %rsi
               	jl	<addr>
               	movl	$0x3, %ecx
               	leaq	<rip>, %rsi
               	movq	0x18(%rsi), %rsi
               	imulq	$0x3e8, %rsi, %rsi      # imm = 0x3E8
               	imulq	%rdi, %rsi
               	addq	%rsi, %rax
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
               	imulq	$-0x1, %rax, %rax
               	decq	%rax
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
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	imulq	%rbx, %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
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
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	imulq	%rbx, %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	movq	$-0x2, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rbx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$-0x2, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0x1, 0x8(%rax)
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	shlq	%rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	movq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdx
               	testq	%rdx, %rdx
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rsi
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	incq	%rax
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%rsi, %r8
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	movq	%rax, %r9
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rdi
               	leaq	<rip>, %rsi
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movq	%rax, %rcx
               	movq	(%rsi,%rcx,8), %rcx
               	imulq	%rdi, %rcx
               	addq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	movq	(%rcx,%rax,8), %rcx
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
               	leave
               	retq
               	movl	$0x2, %edi
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	$0x3, 0x10(%rax)
               	movq	$0x4, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	$0x1, 0x8(%rax)
               	movq	$0x1, 0x10(%rax)
               	movq	$0x1, 0x18(%rax)
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
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>
               	imulq	$-0x1, %rsi, %rax
               	leaq	-0x1(%rax), %rsi
               	jmp	<addr>

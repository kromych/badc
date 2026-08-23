
offsetof_multi_runtime_subscript.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rdx
               	imulq	$0x7, %rdx, %rdi
               	movslq	%eax, %rcx
               	addq	%rcx, %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	imulq	$0xe, %rdx, %rdx
               	movq	%rcx, %r8
               	shlq	%r8
               	addq	%r8, %rdx
               	addq	$0x2, %rdx
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	cmpl	$0x5, %esi
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%r8d, %rdx
               	leaq	(%rdx,%rdx,2), %rcx
               	movslq	%edi, %rsi
               	addq	%rsi, %rcx
               	movq	%rcx, %r9
               	shlq	%r9
               	movslq	%eax, %rcx
               	addq	%rcx, %r9
               	shlq	$0x2, %r9
               	addq	$0x48, %r9
               	imulq	$0x18, %rdx, %rdx
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdx
               	movq	%rcx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rdx
               	addq	$0x48, %rdx
               	cmpq	%r9, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movslq	%edi, %rax
               	leaq	0x1(%rax), %rdi
               	cmpl	$0x3, %edi
               	jl	<addr>
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	cmpl	$0x4, %r8d
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x7, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	imulq	$0xe, %rcx, %rdx
               	addq	$0x8, %rdx
               	imulq	$0x7, %rcx, %rsi
               	shlq	%rsi
               	addq	$0x8, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rdx
               	imulq	$0x18, %rdx, %rdi
               	movslq	%eax, %rcx
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	addq	$0x50, %rdi
               	imulq	$0x6, %rdx, %rdx
               	addq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	addq	$0x50, %rdx
               	cmpq	%rdx, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	cmpl	$0x4, %esi
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%r8d, %rcx
               	imulq	$0x34, %rcx, %rcx
               	leaq	0xac(%rcx), %r9
               	movslq	%edi, %rsi
               	leaq	(%rsi,%rsi,2), %rbx
               	movslq	%eax, %rdx
               	addq	%rdx, %rbx
               	shlq	$0x2, %rbx
               	addq	%rbx, %r9
               	imulq	$0xc, %rsi, %rsi
               	addq	%rsi, %rcx
               	movq	%rdx, %rsi
               	shlq	$0x2, %rsi
               	addq	%rsi, %rcx
               	addq	$0xac, %rcx
               	cmpq	%r9, %rcx
               	jne	<addr>
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%edi, %rax
               	leaq	0x1(%rax), %rdi
               	cmpl	$0x4, %edi
               	jl	<addr>
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	cmpl	$0x3, %r8d
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

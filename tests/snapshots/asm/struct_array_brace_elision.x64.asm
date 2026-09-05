
struct_array_brace_elision.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-0x30(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	%rsi, 0x20(%rax)
               	movq	%rsi, 0x28(%rax)
               	leaq	<rip>, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %r8
               	movq	%r8, %r9
               	shlq	$0x4, %r9
               	leaq	(%rdi,%r9), %rbx
               	movslq	%eax, %rcx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	leaq	(%rbx,%r12), %rdx
               	movslq	(%rdx), %r13
               	testq	%r13, %r13
               	jne	<addr>
               	movslq	0x4(%rdx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	cmpl	$0x3, %esi
               	jl	<addr>
               	leaq	-0x30(%rbp), %rdi
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %r8
               	movq	%r8, %r9
               	shlq	$0x4, %r9
               	leaq	(%rdi,%r9), %rbx
               	movslq	%eax, %rcx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	leaq	(%rbx,%r12), %rdx
               	movslq	(%rdx), %r13
               	testq	%r13, %r13
               	jne	<addr>
               	movslq	0x4(%rdx), %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movslq	%esi, %rax
               	leaq	0x1(%rax), %rsi
               	cmpl	$0x3, %esi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x8, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x10(%rax), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x14(%rax), %rax
               	cmpl	$0x4, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpl	$0x6, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	0x20(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x2c(%rax), %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq


member_name_space_keeps_object_shape.x64:	file format elf64-x86-64

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
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	movq	%rdx, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %r9
               	imulq	$0x30, %rdi, %r8
               	addq	%r8, %r9
               	movq	%rcx, %rbx
               	shlq	$0x4, %rbx
               	addq	%rbx, %r9
               	leaq	(%r9), %r12
               	leaq	0x1(%rdx), %r9
               	movl	%edx, (%r12)
               	leaq	<rip>, %rdx
               	addq	%r8, %rdx
               	addq	%rdx, %rbx
               	leaq	0x1(%r9), %rdx
               	movl	%r9d, 0x4(%rbx)
               	leaq	<rip>, %r9
               	addq	%r8, %r9
               	movq	%rcx, %rbx
               	shlq	$0x4, %rbx
               	leaq	(%r9,%rbx), %r12
               	leaq	0x1(%rdx), %r9
               	movl	%edx, 0x8(%r12)
               	leaq	<rip>, %rdx
               	addq	%r8, %rdx
               	leaq	(%rdx,%rbx), %r8
               	leaq	0x1(%r9), %rdx
               	movl	%r9d, 0xc(%r8)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	0x1(%rdi), %rsi
               	movslq	%esi, %rdi
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x5c(%rax), %rax
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rax
               	leaq	(%rax), %r8
               	imulq	$0xa, %rcx, %rax
               	leaq	(%rax), %rdi
               	movl	%edi, (%r8)
               	leaq	<rip>, %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	0x1(%rax), %rdi
               	movl	%edi, 0x4(%r8)
               	leaq	<rip>, %rdi
               	leaq	(%rdi,%rsi), %r8
               	leaq	0x2(%rax), %rdi
               	movl	%edi, 0x8(%r8)
               	leaq	<rip>, %rdi
               	addq	%rdi, %rsi
               	addq	$0x3, %rax
               	movl	%eax, 0xc(%rsi)
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	0x1c(%rax), %rax
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

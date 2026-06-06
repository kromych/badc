
three_dim_array_indexing.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rdi), %rax
               	movq	%rdi, %rcx
               	addq	$0x1, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rdi, %rcx
               	addq	$0x2, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0x2, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	addq	$0x3, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x8, %rcx
               	movzbq	(%rcx), %rdx
               	movq	%rcx, %rsi
               	addq	$0x1, %rsi
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movq	%rcx, %rsi
               	addq	$0x2, %rsi
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x10, %rcx
               	movzbq	(%rcx), %rdx
               	movq	%rcx, %rsi
               	addq	$0x1, %rsi
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	movq	%rcx, %rsi
               	addq	$0x2, %rsi
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	addq	$0x3, %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0x4a, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0xb, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0xc, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x17, %rcx
               	movzbq	(%rcx), %rcx
               	xorq	$0x18, %rcx
               	movl	%ecx, %ecx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0xc, %rcx
               	movzbq	(%rcx), %rcx
               	movzbq	(%rax), %rdx
               	subq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	addq	$0x4, %rcx
               	movzbq	(%rcx), %rcx
               	movzbq	(%rax), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)

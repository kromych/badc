
rotate_variable_count.x64:	file format elf64-x86-64

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
               	subq	$0x48, %rsp
               	pushq	%rbx
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	xorl	%r9d, %r9d
               	movl	$0x1, -0x10(%rbp)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax,%r9,8), %rdx
               	movslq	-0x10(%rbp), %rcx
               	movq	%rdx, %rbx
               	rorq	%cl, %rbx
               	movslq	-0x10(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	$0x1, %edi
               	shlq	%cl, %rdi
               	andq	%rdx, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rdi
               	subq	%rsi, %rdi
               	andq	$0x3f, %rdi
               	movl	$0x1, %r8d
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	orq	%r8, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movslq	-0x10(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x10(%rbp)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x6, %r9d
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rsi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shrq	$0x7, %rax
               	movq	-0x8(%rbp), %rcx
               	shlq	$0x39, %rcx
               	movq	%rax, %r8
               	orq	%rcx, %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movl	$0x1, %edx
               	movq	%rdx, %rdi
               	shlq	%cl, %rdi
               	andq	%rsi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x7(%rcx), %rdi
               	andq	$0x3f, %rdi
               	pushq	%rcx
               	movq	%rdi, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	orq	%rdx, %rax
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	cmpq	%rax, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq

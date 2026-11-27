
rotate_variable_count.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x48, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	xorl	%r9d, %r9d
               	movl	$0x1, %esi
               	movl	%esi, 0x30(%rsp)
               	jmp	<addr>
               	movq	(%rsp,%r9,8), %rdi
               	movslq	0x30(%rsp), %rcx
               	movq	%rdi, %r10
               	rorq	%cl, %r10
               	movl	0x30(%rsp), %r8d
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x40, %eax
               	jge	<addr>
               	shlxq	%rax, %rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rax, %rdx
               	subq	%r8, %rdx
               	andq	$0x3f, %rdx
               	shlxq	%rdx, %rsi, %rdx
               	orq	%rdx, %rcx
               	jmp	<addr>
               	cmpq	%rcx, %r10
               	jne	<addr>
               	movl	0x30(%rsp), %eax
               	incq	%rax
               	movl	%eax, 0x30(%rsp)
               	movl	0x30(%rsp), %eax
               	nop
               	cmpl	$0x40, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x6, %r9d
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %rdi # imm = 0x123456789ABCDEF
               	movq	%rdi, 0x38(%rsp)
               	movq	0x38(%rsp), %r8
               	shrq	$0x7, %r8
               	movq	0x38(%rsp), %rax
               	shlq	$0x39, %rax
               	orq	%rax, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movl	$0x1, %esi
               	shlxq	%rax, %rsi, %rdx
               	andq	%rdi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x7(%rax), %rdx
               	andq	$0x3f, %rdx
               	shlxq	%rdx, %rsi, %rdx
               	orq	%rdx, %rcx
               	jmp	<addr>
               	cmpq	%rcx, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq

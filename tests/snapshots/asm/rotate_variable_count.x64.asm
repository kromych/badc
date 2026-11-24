
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
               	subq	$0x50, %rsp
               	pushq	%rbx
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	xorl	%r9d, %r9d
               	movl	$0x1, 0x40(%rsp)
               	jmp	<addr>
               	movq	0x10(%rsp,%r9,8), %rdx
               	movslq	0x40(%rsp), %rcx
               	movq	%rdx, %rbx
               	rorq	%cl, %rbx
               	movl	0x40(%rsp), %edi
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movl	$0x1, %esi
               	shlxq	%rax, %rsi, %rsi
               	andq	%rdx, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	andq	$0x3f, %rsi
               	movl	$0x1, %r8d
               	shlxq	%rsi, %r8, %rsi
               	orq	%rsi, %rcx
               	jmp	<addr>
               	cmpq	%rcx, %rbx
               	jne	<addr>
               	movl	0x40(%rsp), %eax
               	incq	%rax
               	movl	%eax, 0x40(%rsp)
               	movl	0x40(%rsp), %eax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	incq	%r9
               	cmpl	$0x6, %r9d
               	jb	<addr>
               	movabsq	$0x123456789abcdef, %rsi # imm = 0x123456789ABCDEF
               	movq	%rsi, 0x48(%rsp)
               	movq	0x48(%rsp), %rax
               	shrq	$0x7, %rax
               	movq	0x48(%rsp), %rcx
               	shlq	$0x39, %rcx
               	movq	%rax, %r8
               	orq	%rcx, %r8
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rax
               	cmpl	$0x40, %eax
               	jge	<addr>
               	movl	$0x1, %edx
               	shlxq	%rax, %rdx, %rdi
               	andq	%rsi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	-0x7(%rax), %rdi
               	andq	$0x3f, %rdi
               	shlxq	%rdi, %rdx, %rdx
               	orq	%rdx, %rcx
               	jmp	<addr>
               	cmpq	%rcx, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x50, %rsp
               	retq

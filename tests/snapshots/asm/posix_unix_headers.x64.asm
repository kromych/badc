
posix_unix_headers.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	leaq	-0x80(%rbp), %rcx
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	cmpl	$0x80, %eax
               	jge	<addr>
               	movslq	%eax, %rsi
               	movb	%dl, (%rcx,%rsi)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rcx
               	orq	$0x8, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x5(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	(%rax), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	0x5(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	andq	$0x10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rdx
               	andq	$-0x9, %rdx
               	movb	%dl, (%rax)
               	movzbq	(%rax), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

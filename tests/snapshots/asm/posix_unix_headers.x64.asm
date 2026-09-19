
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
               	movb	%dl, (%rcx,%rax)
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
               	testb	$0x8, %cl
               	je	<addr>
               	movzbq	0x5(%rax), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	testb	$0x10, %cl
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rdx
               	andq	$-0x9, %rdx
               	movb	%dl, (%rax)
               	movzbq	(%rax), %rax
               	testb	$0x8, %al
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

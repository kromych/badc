
fd_set_macros.x64:	file format elf64-x86-64

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
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	movb	%dl, -0x80(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, -0x80(%rbp,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	orb	$0x1, -0x80(%rbp)
               	orb	$-0x80, -0x80(%rbp)
               	orb	$0x1, -0x7f(%rbp)
               	orb	$0x10, -0x74(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	testb	$-0x80, %al
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	-0x7f(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	-0x74(%rbp), %rax
               	testb	$0x10, %al
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x2, %al
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzbq	-0x7a(%rbp), %rcx
               	testb	$0x4, %cl
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	cmpl	$0x81, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movzbq	-0x7f(%rbp), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movzbq	-0x74(%rbp), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	andb	$0x7f, -0x80(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	testb	$-0x80, %al
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movzbq	-0x7f(%rbp), %rcx
               	testb	$0x1, %cl
               	jne	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	orq	$0x1, %rax
               	movb	%al, -0x80(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	movb	%cl, -0x80(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movzbq	-0x74(%rbp), %rax
               	testb	$0x10, %al
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq

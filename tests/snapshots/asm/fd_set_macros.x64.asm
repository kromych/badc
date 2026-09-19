
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
               	leaq	-0x80(%rbp), %rcx
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rcx,%rax)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	orq	$0x80, %rcx
               	movb	%cl, (%rax)
               	movzbq	0x1(%rax), %rcx
               	orq	$0x1, %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	0xc(%rax), %rcx
               	orq	$0x10, %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	0x1(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	movzbq	0xc(%rax), %rcx
               	andq	$0x10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	andq	$0x2, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movzbq	0x6(%rax), %rcx
               	andq	$0x4, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x81, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movzbq	0x1(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movzbq	0xc(%rax), %rcx
               	xorq	$0x10, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	movq	%rcx, %rdx
               	andq	$-0x81, %rdx
               	movb	%dl, (%rax)
               	movzbq	(%rax), %rcx
               	andq	$0x80, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movzbq	0x1(%rax), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	orq	$0x1, %rax
               	movb	%al, (%rcx)
               	movzbq	(%rcx), %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %rax
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	leaq	-0x80(%rbp), %rax
               	movzbq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movzbq	0xc(%rax), %rax
               	andq	$0x10, %rax
               	testq	%rax, %rax
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


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
               	movzbq	-0x80(%rbp), %rax
               	orq	$0x1, %rax
               	movb	%al, -0x80(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	orq	$0x80, %rax
               	movb	%al, -0x80(%rbp)
               	movzbq	-0x7f(%rbp), %rax
               	orq	$0x1, %rax
               	movb	%al, -0x7f(%rbp)
               	movzbq	-0x74(%rbp), %rax
               	orq	$0x10, %rax
               	movb	%al, -0x74(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movzbq	-0x80(%rbp), %rax
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
               	movzbq	-0x7a(%rbp), %rax
               	testb	$0x4, %al
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movzbq	-0x80(%rbp), %rax
               	xorq	$0x81, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movzbq	-0x7f(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movzbq	-0x74(%rbp), %rax
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movzbq	-0x80(%rbp), %rax
               	andq	$-0x81, %rax
               	movb	%al, -0x80(%rbp)
               	movzbq	-0x80(%rbp), %rax
               	testb	$-0x80, %al
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	movzbq	-0x80(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	movzbq	-0x7f(%rbp), %rax
               	testb	$0x1, %al
               	jne	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rdx
               	movzbq	-0x80(%rbp), %rax
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
               	movb	%cl, (%rdx,%rax)
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

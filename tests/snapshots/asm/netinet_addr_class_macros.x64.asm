
netinet_addr_class_macros.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	-0x30(%rbp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzbq	-0x20(%rbp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpl	$0x0, -0x20(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x1c(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x18(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x14(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x13(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x12(%rbp)
               	jne	<addr>
               	movzbq	-0x11(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0x0, -0x30(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x2c(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x28(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x24(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x23(%rbp)
               	jne	<addr>
               	cmpb	$0x0, -0x22(%rbp)
               	jne	<addr>
               	movzbq	-0x21(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	-0x30(%rbp), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x2f(%rbp), %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

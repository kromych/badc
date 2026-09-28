
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
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x30(%rbp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	(%rdx), %rcx
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0xff, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xc(%rax)
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	cmpb	$0x0, 0xd(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xe(%rax)
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x30(%rbp), %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xc(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xd(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xe(%rax)
               	jne	<addr>
               	movzbq	0xf(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	(%rax), %rax
               	xorq	$0xff, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	andq	$0xf, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

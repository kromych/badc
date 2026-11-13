
thread_local_image_alignment.x64:	file format elf64-x86-64

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

<check>:
               	movq	%fs:0x0, %rax
               	addq	$-0x20, %rax
               	testb	$0xf, %al
               	je	<addr>
               	leaq	0x1(%rdi), %rax
               	retq
               	movq	$0x3, (%rax)
               	movq	$0x4, 0x8(%rax)
               	movq	%fs:0x0, %rcx
               	addq	$-0x30, %rcx
               	movb	$0x1, (%rcx)
               	movq	%fs:0x0, %rdx
               	addq	$-0x10, %rdx
               	movb	$0x2, (%rdx)
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	leaq	0x2(%rdi), %rax
               	retq
               	movsbq	(%rcx), %rax
               	addq	$0x2, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	leaq	0x3(%rdi), %rax
               	retq
               	xorl	%eax, %eax
               	retq

<thread_main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	movq	%rax, 0x8(%rsp)
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x8(%rsp), %rax
               	leaq	<rip>, %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	-0x10(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	0x18(%rsp), %r11
               	movq	%rsi, %rcx
               	callq	*%r11
               	movq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movq	0x10(%rsp), %r11
               	callq	*%r11
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

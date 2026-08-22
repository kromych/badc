
builtin_str_compare_fold.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x61, %edx
               	movb	%dl, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x62, %edx
               	movb	%dl, 0x1(%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	$0x63, %edx
               	movb	%dl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movb	%cl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x3, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	-0x8(%rbp), %rsi
               	leaq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	movl	%eax, %eax
               	subq	$0x61, %rax
               	movl	%eax, %eax
               	addq	$0x3, %rax
               	movl	%eax, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

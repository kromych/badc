
elvis_operator.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movl	%eax, -0x10(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x63, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	movq	%rax, %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	%eax, (%rcx)
               	incq	%rax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	jmp	<addr>

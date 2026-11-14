
setlocale_decimal_point.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	(%rbx), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movq	(%rbx), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x6, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x6, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rdx, 0x18(%rsp)
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	0x18(%rsp), %rdx
               	movq	(%rbx), %rdi
               	leaq	<rip>, %rsi
               	movq	%rdx, 0x18(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x18(%rsp), %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rdi
               	leaq	<rip>, %rsi
               	movq	(%rbx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

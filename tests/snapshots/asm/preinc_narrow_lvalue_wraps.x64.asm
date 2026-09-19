
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

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
               	movb	$-0x1, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	xorl	%ebx, %ebx
               	movzbq	(%rax), %rcx
               	incq	%rcx
               	movb	%cl, (%rax)
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %ebx
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>

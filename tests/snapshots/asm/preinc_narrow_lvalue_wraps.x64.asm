
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
               	leaq	-0x8(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rcx), %rdx
               	incq	%rdx
               	movb	%dl, (%rcx)
               	cmpb	$0x0, (%rcx)
               	jne	<addr>
               	movl	$0x1, %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	cmpb	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movq	%rax, %rbx
               	orq	$0x0, %rbx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

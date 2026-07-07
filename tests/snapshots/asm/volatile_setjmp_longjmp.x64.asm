
volatile_setjmp_longjmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x1, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movzbq	%al, %rax
               	movslq	-0x8(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)


volatile_setjmp_longjmp.x64:	file format elf64-x86-64

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
               	movl	$0x1, -0x8(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, -0x8(%rbp)
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movl	-0x8(%rbp), %eax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x2, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	leave
               	retq

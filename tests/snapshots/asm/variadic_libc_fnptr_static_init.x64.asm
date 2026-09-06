
variadic_libc_fnptr_static_init.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rdi
               	xorq	%rax, %rax
               	movb	%al, (%rdi)
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movl	$0x2a, %ecx
               	leaq	<rip>, %r8
               	movl	$0x63, %r9d
               	subq	$0x10, %rsp
               	movq	%rax, (%rsp)
               	movq	(%rsp), %r10
               	movb	$0x0, %al
               	callq	*%r10
               	addq	$0x10, %rsp
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq

<__c5_sys_snprintf>:
               	jmp	<addr>

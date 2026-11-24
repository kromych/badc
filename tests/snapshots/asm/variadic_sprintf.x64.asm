
variadic_sprintf.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x10, %rsp
               	pushq	%rbx
               	movl	$0x40, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rsi
               	movl	$0xb, %edx
               	movl	$0x16, %ecx
               	movl	$0x21, %r8d
               	movl	$0x2c, %r9d
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	leaq	<rip>, %rsi
               	movl	$0xb, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq

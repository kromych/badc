
exit_from_nested_call.x64:	file format elf64-x86-64

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

<handler>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<descend>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movb	%dil, -0x40(%rbp)
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x2, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	decq	%rdi
               	callq	<addr>
               	movsbq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rdi       # <addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x8, %edi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	jmp	<addr>

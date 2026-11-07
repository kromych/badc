
call_int_return_single_widening.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x80000000, %eax       # imm = 0x80000000
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	%rcx, %rax
               	subq	%rcx, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

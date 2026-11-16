
static_init_once_guard.x64:	file format elf64-x86-64

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

<step>:
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	jmpq	*%rax
               	movl	$0xa, %eax
               	retq
               	movl	$0x14, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	jmpq	*%rax

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

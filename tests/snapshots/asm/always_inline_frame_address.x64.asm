
always_inline_frame_address.x64:	file format elf64-x86-64

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

<inner>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rbp, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rbp, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rbp, %rax
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rbp, %rax
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	popq	%rbp
               	retq

<outer>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rbp, %rax
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movl	$0x2, <rip> # <addr>
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq


builtin_frame_address_levels.x64:	file format elf64-x86-64

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

<f3>:
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
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rbp, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq

<f2>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rbp, %rax
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movl	%eax, <rip> # <addr>
               	incq	%rax
               	popq	%rbp
               	retq

<f1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rbp, %rax
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movl	%eax, <rip> # <addr>
               	incq	%rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rbp, %rax
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

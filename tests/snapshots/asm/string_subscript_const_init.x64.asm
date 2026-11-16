
string_subscript_const_init.x64:	file format elf64-x86-64

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

<f>:
               	movq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7a, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x79, %ecx
               	jne	<addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x73, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x79, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x69, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6a, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x61, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x61, %ecx
               	jne	<addr>
               	movsbq	0x2(%rax), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7a, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	xorl	%eax, %eax
               	retq

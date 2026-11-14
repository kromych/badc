
block_scope_parenthesized_function_declarator.x64:	file format elf64-x86-64

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

<calls>:
               	subq	%rsi, %rdi
               	imulq	$0x3e8, %rdi, %rax      # imm = 0x3E8
               	addq	$0xc8, %rax
               	movq	<rip>, %rcx # <addr>
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	addq	$0x30d40, %rax          # imm = 0x30D40
               	retq

<sub>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<twice>:
               	movq	%rdi, %rax
               	shlq	%rax
               	retq

<where>:
               	leaq	<rip>, %rax # <addr>
               	retq

<msf>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rsi
               	movq	%rdx, %rsi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rsi
               	leave
               	retq

<main>:
               	movq	<rip>, %rax # <addr>
               	imulq	$0xa, %rax, %rax
               	addq	$0x898, %rax            # imm = 0x898
               	incq	%rax
               	addq	$0x30d40, %rax          # imm = 0x30D40
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x3161f, %rax          # imm = 0x3161F
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq


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
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
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
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	imulq	$0xa, %rax, %rax
               	addq	$0x898, %rax            # imm = 0x898
               	incq	%rax
               	addq	$0x30d40, %rax          # imm = 0x30D40
               	cmpq	$0x3161f, %rax          # imm = 0x3161F
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

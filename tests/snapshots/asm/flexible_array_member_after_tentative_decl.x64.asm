
flexible_array_member_after_tentative_decl.x64:	file format elf64-x86-64

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

<early_ref>:
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5a5a5a5a, %rax       # imm = 0x5A5A5A5A
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xd, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xe, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x10, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x11, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x12, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x13, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x14, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq

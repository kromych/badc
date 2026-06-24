
sizeof_function_call_truncation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<harness>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movq	%rdi, %rcx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<main>:
               	movl	$0x1234, %eax           # imm = 0x1234
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	addq	%rcx, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x8c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	addq	%rcx, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0xff00, %eax           # imm = 0xFF00
               	movq	%rax, %rcx
               	andq	$0xff, %rcx
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	addq	%rcx, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	cmpq	$0x1fe, %rax            # imm = 0x1FE
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq

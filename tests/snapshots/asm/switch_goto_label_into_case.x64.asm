
switch_goto_label_into_case.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	cmpq	$0x3, %rdi
               	jl	<addr>
               	cmpq	$0x4, %rdi
               	jl	<addr>
               	cmpq	$0x4, %rdi
               	je	<addr>
               	cmpq	$0x5, %rdi
               	setge	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x8, %rdi
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	cmpq	$0x3, %rdi
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	cmpq	$0x2, %rdi
               	jne	<addr>
               	movl	$0x14, %eax
               	retq
               	cmpq	$0x1, %rdi
               	jne	<addr>
               	movl	$0xa, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	movl	$0xa, %eax
               	movl	$0x14, %eax
               	movl	$0x1e, %eax
               	movl	$0x1e, %eax
               	movl	$0x1, %eax
               	movl	$0x1e, %eax
               	movl	$0x1, %eax
               	movl	$0x1e, %eax
               	movl	$0x1, %eax
               	movl	$0x1e, %eax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

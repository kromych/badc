
switch_multilabel.x64:	file format elf64-x86-64

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

<classify>:
               	movslq	%edi, %rdi
               	cmpq	$0x42, %rdi
               	jl	<addr>
               	cmpq	$0x62, %rdi
               	jl	<addr>
               	cmpq	$0x63, %rdi
               	jl	<addr>
               	cmpq	$0x64, %rdi
               	jl	<addr>
               	cmpq	$0x64, %rdi
               	je	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	cmpq	$0x61, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x42, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x32, %rdi
               	jl	<addr>
               	cmpq	$0x33, %rdi
               	jl	<addr>
               	cmpq	$0x41, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x33, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	retq
               	jmp	<addr>
               	cmpq	$0x31, %rdi
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x30, %rdi
               	je	<addr>
               	jmp	<addr>

<main>:
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq

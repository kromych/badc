
local_label.x64:	file format elf64-x86-64

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

<label_address>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax         # <addr>
               	movq	%rax, -0x8(%rbp)
               	movslq	%edi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movq	-0x8(%rbp), %rax
               	jmpq	*%rax
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movl	$0x1, %ecx
               	movl	$0x64, %ecx
               	movq	%rcx, %rsi
               	movl	$0x12d, %edx            # imm = 0x12D
               	movl	$0x3e9, %eax            # imm = 0x3E9
               	movl	$0x65, %eax
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movl	$0x6, %eax
               	movl	$0x5, %eax
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	movl	$0x2, %eax
               	movq	%rax, %rdx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

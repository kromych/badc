
mixed_signed_unsigned_div.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movabsq	$-0x1, %rax
               	movl	$0x2, %ecx
               	movl	%eax, %edx
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdx, %rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	%ecx, %ecx
               	cmpq	$0x7fffffff, %rcx       # imm = 0x7FFFFFFF
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	movl	%eax, %eax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rdx, %rax
               	popq	%rdx
               	movl	%eax, %eax
               	xorq	$0x3, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)

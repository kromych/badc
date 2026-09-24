
register_var_asm_operand_r10.x64:	file format elf64-x86-64

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

<mark>:
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x1e, %r10d
               	movl	$0xc, %r8d
               	movq	%r10, %rax
               	addq	%r8, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x25, %eax
               	movq	%rax, %r10
               	addq	$0x5, %r10
               	movq	%r10, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xa, %r10d
               	movl	$0x2, %r11d
               	movq	%r10, %rax
               	addq	%r11, %rax
               	addq	$0x1e, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %r10d
               	movq	%r10, <rip>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq


many_args_host_stack_overflow.x64:	file format elf64-x86-64

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

<sum_eleven>:
               	popq	%r10
               	subq	$0xb0, %rsp
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0xc0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xc8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	movq	0xd0(%rsp), %rax
               	movq	%rax, 0xa0(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	cmpl	$0x1, %edi
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpl	$0x2, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpl	$0x3, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpl	$0x5, %r8d
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	cmpl	$0x6, %r9d
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x70(%rbp), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x80(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0x90(%rbp), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0xa0(%rbp), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	movslq	0xb0(%rbp), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xb0, %rsp
               	pushq	%r11
               	retq

<main>:
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	retq

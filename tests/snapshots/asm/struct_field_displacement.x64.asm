
struct_field_displacement.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	-0x20(%rbp), %rax
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movl	$0x16, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x14d, %ecx            # imm = 0x14D
               	movq	%rcx, 0x8(%rax)
               	movl	$0x2c, %ecx
               	movw	%cx, 0x10(%rax)
               	movl	$0x5, %ecx
               	movb	%cl, 0x12(%rax)
               	movl	$0x63, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x309, %esi            # imm = 0x309
               	movq	%rsi, 0x8(%rax)
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movl	%ecx, 0x4(%rax)
               	movq	0x8(%rax), %rcx
               	addq	$0xa, %rcx
               	movq	%rcx, 0x8(%rax)
               	movsbq	0x12(%rax), %rcx
               	incq	%rcx
               	movb	%cl, 0x12(%rax)
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x64, %ecx
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	0x8(%rax), %rcx
               	cmpq	$0x313, %rcx            # imm = 0x313
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movswq	0x10(%rax), %rcx
               	cmpl	$0x2c, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x12(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

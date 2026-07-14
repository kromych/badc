
struct_field_displacement.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<set_b>:
               	movl	%esi, 0x4(%rdi)
               	xorq	%rax, %rax
               	retq

<set_c>:
               	movq	%rsi, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<rmw_b>:
               	movslq	0x4(%rdi), %rax
               	addq	%rsi, %rax
               	movl	%eax, 0x4(%rdi)
               	xorq	%rax, %rax
               	retq

<rmw_c>:
               	movq	0x8(%rdi), %rax
               	addq	%rsi, %rax
               	movq	%rax, 0x8(%rdi)
               	xorq	%rax, %rax
               	retq

<rmw_d>:
               	movsbq	0x12(%rdi), %rax
               	incq	%rax
               	movb	%al, 0x12(%rdi)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x1, %ebx
               	movl	%ebx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x16, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x14d, %ecx            # imm = 0x14D
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2c, %ecx
               	movw	%cx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movb	%cl, 0x12(%rax)
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x63, %esi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x309, %esi            # imm = 0x309
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x64, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x313, %rax            # imm = 0x313
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movswq	0x10(%rax), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x12(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)

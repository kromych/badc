
case_label_const_object.x64:	file format elf64-x86-64

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

<stays_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x10, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	xorq	%rcx, %rcx
               	leaq	(%rax), %rdx
               	movl	%ecx, (%rdx)
               	movl	$0x1, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	$0x3, %ecx
               	movl	%ecx, 0xc(%rax)
               	movslq	0xc(%rax), %rax
               	cmpq	$0x3, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x6, %eax
               	movl	$0x4, %eax
               	movl	$0x2, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x2, %eax
               	movl	$0x3, %eax
               	movl	$0x9, %eax
               	movl	$0x8, %eax
               	leaq	<rip>, %rax
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3e8, %rax            # imm = 0x3E8
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	jmp	<addr>

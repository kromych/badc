
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
               	leaq	(%rax), %rdx
               	movl	$0x0, (%rdx)
               	movl	$0x1, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x2, 0x8(%rax)
               	movl	$0x3, 0xc(%rax)
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rcx
               	movl	$0x9, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%eax, %eax
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x9, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
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
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

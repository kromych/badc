
inline_asm_x64_setcc.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0x5, %ebx
               	movl	$0x5, %ecx
               	cmpq	%rcx, %rbx
               	sete	%al
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x14, %rax, %rdx
               	movl	$0x3, %ebx
               	movl	$0x7, %ecx
               	cmpq	%rcx, %rbx
               	setl	%al
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0xf, %rax, %rax
               	addq	%rax, %rdx
               	movl	$0x9, %ebx
               	movl	$0x4, %ecx
               	cmpq	%rcx, %rbx
               	setg	%al
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x7, %rax, %rax
               	addq	%rax, %rdx
               	movl	$0x1, %ebx
               	movl	$0x2, %ecx
               	cmpq	%rcx, %rbx
               	sete	%al
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %rdx
               	movl	$0x9, %ebx
               	movl	$0x3, %ecx
               	cmpq	%rcx, %rbx
               	setl	%al
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rax, %rdx
               	movl	$0x4, %ebx
               	movl	$0x9, %ecx
               	cmpq	%rcx, %rbx
               	setg	%al
               	movb	%al, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	imulq	$0x64, %rax, %rax
               	addq	%rdx, %rax
               	popq	%rbx
               	leave
               	retq

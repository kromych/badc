
far_field_copy_load.x64:	file format elf64-x86-64

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

<from_big>:
               	movzbq	0x1(%rdi), %rax
               	leaq	0x2000(%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<half_from_big>:
               	movzbq	0x3(%rdi), %rax
               	leaq	0x9c40(%rdi), %rcx
               	movzwq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<word_from_big>:
               	movzbq	0x5(%rdi), %rax
               	leaq	0x9c44(%rdi), %rcx
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	retq

<wide_from_big>:
               	movzbq	0x7(%rdi), %rax
               	leaq	0x9c48(%rdi), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	movl	$0x9, %eax
               	movb	%al, (%rbx)
               	movl	$0x2, %eax
               	movb	%al, 0x1(%rbx)
               	movl	$0x3, %eax
               	movb	%al, 0x3(%rbx)
               	movl	$0x5, %eax
               	movb	%al, 0x5(%rbx)
               	movl	$0x7, %eax
               	movb	%al, 0x7(%rbx)
               	leaq	0x2000(%rbx), %rax
               	movl	$0x28, %ecx
               	movb	%cl, (%rax)
               	leaq	0x9c40(%rbx), %rax
               	movl	$0x1234, %ecx           # imm = 0x1234
               	movw	%cx, (%rax)
               	leaq	0x9c44(%rbx), %rax
               	movl	$0x12345678, %ecx       # imm = 0x12345678
               	movl	%ecx, (%rax)
               	leaq	0x9c48(%rbx), %rax
               	movabsq	$0x123456789a, %rcx     # imm = 0x123456789A
               	movq	%rcx, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1237, %rax           # imm = 0x1237
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1234567d, %rax       # imm = 0x1234567D
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movabsq	$0x12345678a1, %r11     # imm = 0x12345678A1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq

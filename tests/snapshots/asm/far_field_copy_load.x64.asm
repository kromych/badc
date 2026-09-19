
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
               	movzbq	0x2000(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<half_from_big>:
               	movzbq	0x3(%rdi), %rax
               	movzwq	0x9c40(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<word_from_big>:
               	movzbq	0x5(%rdi), %rax
               	movl	0x9c44(%rdi), %ecx
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	retq

<wide_from_big>:
               	movzbq	0x7(%rdi), %rax
               	movq	0x9c48(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	movb	$0x9, (%rbx)
               	movb	$0x2, 0x1(%rbx)
               	movb	$0x3, 0x3(%rbx)
               	movb	$0x5, 0x5(%rbx)
               	movb	$0x7, 0x7(%rbx)
               	leaq	0x2000(%rbx), %rax
               	movb	$0x28, (%rax)
               	leaq	0x9c40(%rbx), %rax
               	movw	$0x1234, (%rax)         # imm = 0x1234
               	leaq	0x9c44(%rbx), %rax
               	movl	$0x12345678, (%rax)     # imm = 0x12345678
               	leaq	0x9c48(%rbx), %rax
               	movabsq	$0x123456789a, %rcx     # imm = 0x123456789A
               	movq	%rcx, (%rax)
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1237, %rax           # imm = 0x1237
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1234567d, %rax       # imm = 0x1234567D
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movabsq	$0x12345678a1, %r11     # imm = 0x12345678A1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq

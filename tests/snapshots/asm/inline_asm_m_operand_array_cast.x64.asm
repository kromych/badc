
inline_asm_m_operand_array_cast.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movabsq	$0x1111111111111111, %rax # imm = 0x1111111111111111
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x2222222222222222, %rax # imm = 0x2222222222222222
               	movq	%rax, -0x8(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	(%rcx), %rax
               	adcq	0x8(%rcx), %rax
               	adcq	$0x0, %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	$0x5, -0x10(%rbp)
               	movq	$0x9, -0x8(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	addq	(%rcx), %rax
               	adcq	0x8(%rcx), %rax
               	adcq	$0x0, %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	$0x0, (%rcx)
               	movq	$0x0, 0x8(%rcx)
               	cmpq	$0x0, -0x10(%rbp)
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

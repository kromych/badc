
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
               	subq	$0x28, %rsp
               	pushq	%rbx
               	leaq	-0x18(%rbp), %rax
               	movabsq	$0x1111111111111111, %rcx # imm = 0x1111111111111111
               	movq	%rcx, (%rax)
               	movabsq	$0x2222222222222222, %rcx # imm = 0x2222222222222222
               	movq	%rcx, 0x8(%rax)
               	movq	$0x0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leaq	-0x18(%rbp), %rbx
               	leaq	-0x18(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movabsq	$0x3333333333333333, %r11 # imm = 0x3333333333333333
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	$0x5, (%rax)
               	movq	$0x9, 0x8(%rax)
               	movq	$0x0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leaq	-0x18(%rbp), %rbx
               	leaq	-0x18(%rbp), %rcx
               	addq	(%rbx), %rax
               	adcq	0x8(%rbx), %rax
               	adcq	$0x0, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x18(%rbp), %rbx
               	movq	$0x0, (%rbx)
               	movq	$0x0, 0x8(%rbx)
               	leaq	-0x18(%rbp), %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x8(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

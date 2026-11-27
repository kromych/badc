
add_three_operand_lea.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x38, %rsp
               	movl	$0x3, %eax
               	movq	%rax, 0x28(%rsp)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x20(%rsp)
               	movl	$0x5, %edx
               	movq	%rdx, 0x18(%rsp)
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	addq	%rdi, %rsi
               	cmpq	$0x7, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	addq	%rdi, %rsi
               	movq	0x28(%rsp), %rdi
               	movq	0x18(%rsp), %r8
               	addq	%r8, %rdi
               	addq	%rdi, %rsi
               	cmpq	$0xf, %rsi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	$-0x5, 0x28(%rsp)
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	addq	%rdi, %rsi
               	cmpq	$-0x1, %rsi
               	je	<addr>
               	addq	$0x38, %rsp
               	retq
               	movl	$0x77359400, 0x10(%rsp) # imm = 0x77359400
               	movl	$0x77359400, 0x8(%rsp)  # imm = 0x77359400
               	movl	0x10(%rsp), %eax
               	movl	0x8(%rsp), %esi
               	addq	%rsi, %rax
               	cmpl	$0xee6b2800, %eax       # imm = 0xEE6B2800
               	je	<addr>
               	movq	%rcx, %rax
               	addq	$0x38, %rsp
               	retq
               	movabsq	$0x7fffffffffffffff, %rax # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%rax, (%rsp)
               	movq	(%rsp), %rax
               	incq	%rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movq	%rdx, %rax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq

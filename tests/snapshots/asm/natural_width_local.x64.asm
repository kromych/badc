
natural_width_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x12c, %eax            # imm = 0x12C
               	movl	$0xc8, %ecx
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	movslq	%edx, %rdi
               	cmpq	$0x4, %rdi
               	jge	<addr>
               	movsbq	%al, %rdi
               	addq	%rdi, %rsi
               	incq	%rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movsbq	%al, %rdx
               	cmpq	$0x2c, %rdx
               	je	<addr>
               	movq	%rdi, %rdx
               	incq	%rdx
               	movslq	%edx, %rdi
               	andq	$0xff, %rax
               	xorq	$0x2c, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rdi
               	movsbq	%cl, %rax
               	cmpq	$-0x38, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rdi
               	movslq	%esi, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rdi
               	movslq	%edi, %rax
               	movq	(%rsp), %r13
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

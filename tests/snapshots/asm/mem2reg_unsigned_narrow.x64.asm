
mem2reg_unsigned_narrow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	jmp	<addr>
               	addq	$0x2c, %rax
               	addq	$0x2345, %rcx           # imm = 0x2345
               	incq	%rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rsi
               	cmpq	$0x3, %rsi
               	jl	<addr>
               	xorq	%rsi, %rsi
               	movslq	%eax, %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	leaq	0x4(%rsi), %rax
               	movslq	%eax, %rsi
               	movslq	%ecx, %rax
               	cmpq	$0x69cf, %rax           # imm = 0x69CF
               	je	<addr>
               	leaq	0x8(%rsi), %rax
               	movslq	%eax, %rsi
               	movslq	%esi, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x1, %esi
               	jmp	<addr>
               	leaq	0x2(%rsi), %rdx
               	movslq	%edx, %rsi
               	jmp	<addr>

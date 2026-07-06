
natural_width_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
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
               	leaq	0x1(%rdi), %rdx
               	movslq	%edx, %rdi
               	andq	$0xff, %rax
               	xorq	$0x2c, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x2(%rdi), %rax
               	movslq	%eax, %rdi
               	movsbq	%cl, %rax
               	cmpq	$-0x38, %rax
               	je	<addr>
               	leaq	0x4(%rdi), %rax
               	movslq	%eax, %rdi
               	movslq	%esi, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	leaq	0x8(%rdi), %rax
               	movslq	%eax, %rdi
               	movslq	%edi, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
